# Cómo leer el diagrama entidad-relación (ERD)

> 👀 El diagrama está en el [README de los ejercicios](README.md#modelo-de-datos).
> Aquí explicamos qué significa cada símbolo.

Un **diagrama entidad-relación** muestra las tablas, sus campos y cómo se conectan entre sí
a través de las llaves. Es el "plano" de la base de datos.

## Símbolos dentro de cada tabla

* **`PK` (Primary Key / Llave primaria)**: el identificador único de cada fila
  (los `id_*`, autoincrementables con `SERIAL`). No se repite nunca.
* **`FK` (Foreign Key / Llave foránea)**: un campo que **apunta** a la `PK` de otra tabla
  para crear el enlace. Es el "puente" entre tablas.

## Símbolos de las líneas (las relaciones)

La simbología `||--o{` describe el tipo de relación entre dos tablas:

* El lado con dos líneas verticales (`||`) significa **Uno (1)**.
* El lado con la "pata de gallo" (`o{`) significa **Muchos (N)**.

Así, `tutores ||--o{ mascotas` se lee: **un** tutor tiene **muchas** mascotas.

## Leyendo nuestro modelo

1. **Un** tutor puede tener **muchas** mascotas.
2. **Un** tutor puede figurar en **muchas** consultas.
3. **Una** mascota puede tener **muchas** consultas a lo largo de su vida.

> 💡 Por eso `mascotas` tiene una FK a `tutores`, y `consultas_veterinarias` tiene **dos** FK
> (una a `tutores` y otra a `mascotas`): así cada consulta sabe a qué mascota y a qué tutor
> pertenece.
