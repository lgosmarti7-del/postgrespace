# Registrar el servidor PostgreSQL manualmente

> **¿Cuándo necesitas esto?**
> Normalmente **no**. El entorno ya viene con el servidor **PostgreSQL Curso** registrado
> automáticamente y solo debes ingresar la contraseña al expandirlo (ver el
> [README](../README.md#6-conectarte-al-servidor-ya-viene-registrado)).
>
> Usa esta guía únicamente si el servidor **no aparece** en el panel izquierdo de pgAdmin
> y necesitas registrarlo a mano.

---

## 1. Añadir un nuevo servidor

En el panel izquierdo de pgAdmin, haz clic derecho sobre **Servers → Register → Server…**
(o usa **Add New Server** en la página de inicio).

> ![Añadir servidor](images/pg_servers.png)

---

## 2. Pestaña General

En el campo **Name** escribe un nombre identificativo para el servidor, por ejemplo:

```text
PostgreSQL Curso
```

> ![Pestaña General](images/pg_name.png)

---

## 3. Pestaña Connection

Cambia a la pestaña **Connection** y rellena los campos **exactamente** así:

| Campo | Valor |
|---|---|
| **Host name/address** | `postgres` |
| **Port** | `5432` |
| **Maintenance database** | `postgres` |
| **Username** | `postgres` |
| **Password** | `1234` |

Marca la casilla **Save Password** y presiona **Save**.

nota importante: si estas en una instalación local de postgres el host name/address es **localhost**



> ![Pestaña Connection](images/pg_connection.png)

> ⚠️ **Importante:** el host es `postgres` (el nombre del contenedor), **no** `localhost`
> ni `127.0.0.1`. PostgreSQL corre en un contenedor aparte, accesible por ese nombre dentro
> de la red de Docker.

---

## 4. Listo

El servidor aparecerá en el panel izquierdo. Al expandirlo verás la base de ejemplo
`veterinariadb` (tablas `tutores` y `mascotas`) y podrás crear tus propias bases de datos,
ejecutar consultas y administrar todo desde pgAdmin.

> ![pgAdmin conectado](images/pgadmin.png)
