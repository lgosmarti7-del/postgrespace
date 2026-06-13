# psql en el Devcontainer

## El problema

El entorno usa tres contenedores Docker: `workspace` (donde vive la terminal de VS Code), `postgres` y `pgadmin`.

El binario `psql` solo existe dentro del contenedor `postgres`, pero el shell del alumno corre en `workspace`, que es una imagen Ubuntu base sin cliente PostgreSQL instalado. Por eso al escribir `psql` aparece:

```
bash: psql: command not found
```

## Opciones evaluadas

| Opción | Comando del alumno | Problema |
|---|---|---|
| `docker exec` al contenedor postgres | `docker exec -it postgres psql -U postgres` | Expone Docker internals, confuso para aprender SQL |
| Conectar por red con flags explícitos | `psql -h postgres -U postgres` | Mejor, pero requiere recordar flags |
| **Instalar `postgresql-client` en workspace** | `psql` | Igual que en producción real |

## La solución

Se modificó `.devcontainer/devcontainer.json` con dos bloques:

```json
"postCreateCommand": "sudo apt-get update -qq && sudo apt-get install -y postgresql-client",

"remoteEnv": {
  "PGHOST": "postgres",
  "PGUSER": "postgres",
  "PGPASSWORD": "1234",
  "PGDATABASE": "postgres"
},
```

**`postCreateCommand`** instala el paquete `postgresql-client` en el contenedor `workspace` una sola vez al crearlo. Es el paquete liviano que contiene solo el binario `psql`, sin levantar ningún servidor.

**`remoteEnv`** define las cuatro variables de entorno que `psql` lee por defecto para conectarse:

- `PGHOST=postgres` — hostname del servicio en la red interna `pgnet`
- `PGUSER`, `PGPASSWORD`, `PGDATABASE` — credenciales ya definidas en `docker-compose.yml`

Los dos contenedores comparten la red `pgnet`, por lo que `workspace` alcanza a `postgres` directamente por nombre de servicio.

## Resultado

Después de hacer **Rebuild Container**, el alumno solo escribe:

```
psql
```

Y entra directamente a la consola interactiva:

```
psql (16.x)
Type "help" for help.

postgres=#
```

## Por qué este camino

Es exactamente como trabaja cualquier desarrollador con PostgreSQL en un entorno real: el cliente está en su máquina, el servidor en otro host, y las variables de entorno manejan la conexión. Los alumnos aprenden el patrón correcto desde el principio, sin workarounds de Docker.
