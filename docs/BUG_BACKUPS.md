# Bug: los backups de pgAdmin no aparecen en `data/`

> Documento de continuación para retomar la investigación **desde dentro del devcontainer**,
> donde sí hay acceso a `docker` (gracias a la feature `docker-outside-of-docker`).

## Síntoma

Al hacer un backup desde pgAdmin (Backup… sobre una base de datos), el proceso reporta
**"Successfully completed"**, pero el archivo `.db`/`.sql` **no aparece** en `data/` del repo.
Solo se crea la carpeta del usuario (`data/postgres_sql.dev/`) y queda **vacía**.

Salida típica del comando que ejecuta pgAdmin:

```
/usr/local/pgsql-16/pg_dump --file "/var/lib/pgadmin/storage/postgres_sql.dev/respaldo.db" \
  --host "postgres" --port "5432" --username "postgres" --no-password \
  --format=c --large-objects --section=data --verbose "vetdb"
```

## Hipótesis principal

El contenedor `pgadmin` en ejecución **no tiene el volumen montado** porque se creó antes de
los cambios al `docker-compose.yml`. Los cambios de `volumes:` solo se aplican al **recrear**
el contenedor (`--force-recreate` / "Rebuild Container"), no con "Reload Window" ni restart.

Resultado: `pg_dump` escribe el archivo con éxito **dentro de la capa interna del contenedor**
(`/var/lib/pgadmin/storage` sin mapear al host), por eso "Successfully completed" pero el
archivo nunca llega a `data/` en el host. La carpeta `postgres_sql.dev` visible es un
remanente de una generación anterior del contenedor.

## Configuración actual

`.devcontainer/docker-compose.yml` → servicio `pgadmin`:

```yaml
  pgadmin:
    image: dpage/pgadmin4:latest
    restart: unless-stopped
    user: root
    environment:
      PGADMIN_DEFAULT_EMAIL: postgres@sql.dev
      PGADMIN_DEFAULT_PASSWORD: 1234
    ports:
      - "5050:80"
    volumes:
      - ../data:/var/lib/pgadmin/storage
```

- `user: root` → evita problema de permisos (pgAdmin corre como uid 5050 y `data/` es del host).
- `../data:/var/lib/pgadmin/storage` → mapea `data/` del repo al storage de pgAdmin.

## Pasos de diagnóstico (ejecutar DENTRO del devcontainer)

Requiere haber hecho **Rebuild Container** (instala `docker` CLI vía la feature).

### 1. ¿El volumen está realmente montado en el contenedor en ejecución?

```bash
docker inspect $(docker ps -qf "ancestor=dpage/pgadmin4:latest") \
  --format '{{range .Mounts}}{{.Source}} -> {{.Destination}}{{"\n"}}{{end}}'
```

**Esperado:** una línea terminando en `-> /var/lib/pgadmin/storage`.
**Si NO aparece** → el contenedor no se recreó → recrear y repetir.

### 2. ¿El archivo existe DENTRO del contenedor?

```bash
docker exec $(docker ps -qf "ancestor=dpage/pgadmin4:latest") \
  ls -la /var/lib/pgadmin/storage/postgres_sql.dev/
```

### 3. ¿El archivo existe en el host (repo)?

```bash
ls -la data/postgres_sql.dev/
```

### Tabla de decisión

| Comando 2 (dentro) | Comando 3 (host) | Diagnóstico | Acción |
|---|---|---|---|
| Archivo presente | Vacío | Mount no activo / stale | `docker compose ... up -d --force-recreate pgadmin` |
| Archivo presente | Archivo presente | ✅ Resuelto | — |
| Vacío | Vacío | `pg_dump` escribe en otro path o falla silenciosamente | Revisar logs de pgAdmin + permisos |

## Recrear el contenedor manualmente (con docker CLI disponible)

```bash
docker compose -f .devcontainer/docker-compose.yml up -d --force-recreate pgadmin
```

## Si tras confirmar el mount el archivo SIGUE sin aparecer

Entonces es **permisos**: el `user: root` no bastó o pgAdmin lanza `pg_dump` con un uid sin
escritura sobre el host mount. Siguiente experimento:

```bash
# Ver dueño/permisos del directorio de storage dentro del contenedor
docker exec $(docker ps -qf "ancestor=dpage/pgadmin4:latest") \
  ls -la /var/lib/pgadmin/storage/
```

Comparar UID/GID con el dueño de `data/` en el host. Ajustar con `chown` o con la opción
`PGADMIN_...` correspondiente.

## Estado / próximos pasos

- [x] Volumen `../data:/var/lib/pgadmin/storage` configurado.
- [x] `user: root` añadido al servicio pgadmin.
- [x] Feature `docker-outside-of-docker` añadida (CLI docker en el devcontainer).
- [x] Extensión `anthropic.claude-code` añadida (continuar la conversación dentro del contenedor).
- [ ] **Rebuild Container** y confirmar mount con el paso 1.
- [ ] Repetir backup y verificar `data/postgres_sql.dev/`.
- [ ] Si falla, seguir la rama de permisos.
