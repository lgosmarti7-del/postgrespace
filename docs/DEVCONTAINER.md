# ¿Qué es Dev Containers?

## Concepto simple

Dev Containers (Contenedores de Desarrollo) es una **extensión de VS Code** que te permite desarrollar *dentro* de un contenedor Docker.

En lugar de:
1. Instalar PostgreSQL en tu máquina
2. Instalar pgAdmin en tu máquina
3. Configurar puertos, variables de entorno...

Simplemente:
1. Haces clic en "Reopen in Container"
2. VS Code se abre *dentro* del contenedor
3. Todo está configurado y funciona

## Flujo normal vs Dev Containers

### Sin Dev Containers ❌
```
Tu máquina
├── Instala PostgreSQL
├── Instala pgAdmin
├── Configura puertos
├── Configura variables
└── Espera todo funcione...
```

### Con Dev Containers ✅
```
Tu máquina
└── Docker
    └── Contenedor con todo preconfigurado
        ├── PostgreSQL ✓
        ├── pgAdmin ✓
        ├── Puertos ✓
        └── Variables de entorno ✓
```

## ¿Qué se necesita?

- VS Code (editor de código)
- Extensión "Dev Containers" (se instala automáticamente)
- Docker (corre en el fondo)

## En este proyecto

El archivo `.devcontainer/devcontainer.json` define:
- Qué imagen Docker usar
- Qué extensiones instalar en VS Code
- Qué puertos exponer
- Qué variables de entorno configurar

```json
{
  "name": "postgrespace",
  "dockerComposeFile": "docker-compose.yml",
  "service": "workspace"
}
```

Cuando haces clic en "Reopen in Container", Dev Containers lee este archivo y configura todo automáticamente.

## Ventajas

| Ventaja | Explicación |
|---------|-----------|
| **Ambiente consistente** | Todos los alumnos tienen la misma configuración |
| **Sin instalar nada** | No contaminas tu máquina |
| **Fácil de compartir** | Solo necesitas este repositorio |
| **Reversible** | Si algo falla, cierras el contenedor y listo |
| **Multiplataforma** | Funciona en Windows, Mac, Linux igual |

## ¿Necesito aprender sobre Dev Containers?

Para este proyecto: **No**. Solo debes saber:
1. Hacer clic en "Reopen in Container" cuando lo pide
2. Que estás trabajando *dentro* de un contenedor
3. Que al arrancar ya tienes el servidor registrado en pgAdmin y una base de
   datos de ejemplo (`veterinariadb`) creada automáticamente
4. Que los datos de PostgreSQL persisten en `pgdta/` y tus backups en `data/`

El resto está automatizado.

## Relación con Docker

- **Docker**: La tecnología base (contenedores)
- **Dev Containers**: La herramienta que integra Docker con VS Code

[Aprende más sobre Docker](DOCKER.md)
