# psql — La terminal de PostgreSQL

`psql` es la consola interactiva de PostgreSQL. Permite escribir consultas SQL directamente desde el terminal, sin necesidad de una interfaz gráfica como pgAdmin.

> **Referencia:** este documento complementa el video [Aprende a usar psql paso a paso](https://youtu.be/DmZkPTZXjNw?si=tCaUEoCgQ_IRHIqL) de *Profe Luis*, adaptando los ejemplos a los dos entornos del curso.

---

## Cómo abrir psql según tu entorno

### Si usas Codespaces (terminal de VS Code)

El entorno ya está configurado. Simplemente abre la terminal y escribe:

```
psql
```

La conexión al servidor ocurre automáticamente — no te pedirá usuario ni contraseña.

### Si usas Windows con PostgreSQL instalado

Abre el programa **SQL Shell (psql)** desde el menú de inicio. Te pedirá completar los datos de conexión — puedes pulsar Enter en cada campo para aceptar el valor por defecto:

```
Server [localhost]:
Database [postgres]:
Port [5432]:
Username [postgres]:
Password for user postgres: ****
```

---

## Prompt de psql

Una vez dentro verás algo así:

```
psql (16.3)
Type "help" for help.

postgres=#
```

El símbolo `postgres=#` indica que estás conectado a la base de datos `postgres` y listo para escribir comandos. El nombre antes del `#` cambia según la base de datos activa.

Para salir en cualquier momento:

```
\q
```

---

## Gestión de bases de datos

### Listar todas las bases de datos

```sql
\l
```

### Crear una base de datos

```sql
CREATE DATABASE veterinariadb;
```

### Conectarse a una base de datos

```sql
\c veterinariadb
```

El prompt cambiará a `veterinariadb=#` confirmando el cambio.

---

## Gestión de tablas

### Listar las tablas de la base de datos actual

```sql
\dt
```

### Crear una tabla

```sql
CREATE TABLE clientes (
    id        SERIAL PRIMARY KEY,
    nombre    VARCHAR(100),
    apellido  VARCHAR(100),
    edad      SMALLINT
);
```

### Ver la estructura de una tabla

```sql
\d clientes
```

---

## Manipulación de datos

Toda instrucción SQL termina con `;` — si lo olvidas, psql espera que continúes escribiendo y el prompt cambia a `->`.

### Insertar un registro

```sql
INSERT INTO clientes (nombre, apellido, edad)
VALUES ('Ana', 'López', 28);
```

### Insertar varios registros a la vez

```sql
INSERT INTO clientes (nombre, apellido, edad) VALUES
    ('Carlos', 'Ruiz', 34),
    ('María', 'Gómez', 22),
    ('Luis', 'Martín', 41);
```

### Actualizar un registro

```sql
UPDATE clientes SET edad = 29 WHERE nombre = 'Ana';
```

### Eliminar un registro

```sql
DELETE FROM clientes WHERE nombre = 'Ana';
```

---

## Consultas SQL

### Ver todos los registros

```sql
SELECT * FROM clientes;
```

### Ver solo algunas columnas

```sql
SELECT nombre, apellido FROM clientes;
```

### Filtrar con WHERE

```sql
SELECT * FROM clientes WHERE edad > 30;
```

### Ordenar resultados

```sql
SELECT * FROM clientes ORDER BY apellido;
SELECT * FROM clientes ORDER BY edad DESC;
```

### Limitar la cantidad de resultados

```sql
SELECT * FROM clientes ORDER BY edad DESC LIMIT 3;
```

---

## Comandos de navegación rápida

Estos comandos empiezan con `\` y no llevan `;` al final.

| Comando | Qué hace |
|---|---|
| `\l` | Lista todas las bases de datos |
| `\c nombre_db` | Cambia a otra base de datos |
| `\dt` | Lista las tablas de la base de datos actual |
| `\d nombre_tabla` | Muestra la estructura de una tabla |
| `\du` | Lista los usuarios y sus roles |
| `\conninfo` | Muestra servidor, base de datos y usuario activos |
| `\q` | Sale de psql |

---

## Consejos rápidos

- Si el prompt cambia a `->` o `postgres-#`, psql espera más input — generalmente falta el `;`. Escríbelo y pulsa Enter.
- Las flechas arriba/abajo navegan el historial de comandos.
- `\e` abre un editor de texto para escribir consultas largas.
- `\timing` activa el tiempo de ejecución de cada consulta.
