# Ejercicio 2 — Crea la tabla `mascotas` y relaciónala

> 🎯 **Qué vas a aprender:** a **crear una tabla** (CREATE TABLE) y a **relacionarla** con
> otra usando una **clave foránea** (FOREIGN KEY). Esta es la idea más importante de las
> bases de datos relacionales.

En el Ejercicio 1 trabajaste con `tutores`. Ahora vas a crear la tabla **`mascotas`**.
Cada mascota pertenece a **un** tutor → es una relación **Uno a Muchos** (un tutor puede
tener muchas mascotas, pero cada mascota tiene un solo tutor).

```
  tutores (1) ────< (muchas) mascotas
```

---

## Paso 2.1 — Crea la tabla `mascotas` (CREAR)

Necesitamos una tabla con: nombre, especie, edad y **una columna que apunte al tutor dueño**.
Esa columna (`tutor_id`) será la **clave foránea** hacia `tutores`.

**Pista** — la estructura, con el hueco de la clave foránea para que la completes:

```sql
CREATE TABLE mascotas (
    id_mascota SERIAL PRIMARY KEY,
    nombre     VARCHAR(50) NOT NULL,
    especie    VARCHAR(30),      -- Ejemplo: Perro, Gato, Ave
    edad_meses INT,
    tutor_id   INT,              -- aquí guardaremos el id del tutor dueño

    -- 👇 Define que tutor_id apunta a tutores(id_tutor)
    CONSTRAINT fk_tutor
        FOREIGN KEY (tutor_id)
        REFERENCES  -- ¿a qué tabla y columna? complétalo
);
```

> 🔎 **¿Qué es una clave foránea (FK)?** Es un "puente" entre tablas. Le dice a PostgreSQL:
> *"el valor de `tutor_id` debe existir en `tutores`"*. Así es imposible registrar una mascota
> de un tutor que no existe.

<details>
<summary>👀 Ver la solución completa</summary>

```sql
CREATE TABLE mascotas (
    id_mascota SERIAL PRIMARY KEY,
    nombre     VARCHAR(50) NOT NULL,
    especie    VARCHAR(30),
    edad_meses INT,
    tutor_id   INT,
    CONSTRAINT fk_tutor
        FOREIGN KEY (tutor_id)
        REFERENCES tutores(id_tutor)
        ON DELETE CASCADE   -- si se borra el tutor, se borran sus mascotas
);
```

> 💡 `ON DELETE CASCADE` es una regla de integridad: si un tutor se elimina, sus mascotas
> no quedan "huérfanas", se eliminan con él.

</details>

---

## Paso 2.2 — Agrega 2 mascotas (INSERTAR)

Inserta **2 mascotas** asociadas a tutores que **ya existen**. Recuerda que Carlos es el
`id_tutor` 1 y Ana el 2 (puedes confirmarlo con `SELECT * FROM tutores;`).

**Pista:**

```sql
INSERT INTO mascotas (nombre, especie, edad_meses, tutor_id) VALUES
('NOMBRE', 'ESPECIE', EDAD, ID_DEL_TUTOR),
('NOMBRE', 'ESPECIE', EDAD, ID_DEL_TUTOR);
```

<details>
<summary>👀 Ver una solución de ejemplo</summary>

```sql
INSERT INTO mascotas (nombre, especie, edad_meses, tutor_id) VALUES
('Firulais', 'Perro', 24, 1),   -- de Carlos (id 1)
('Michi',    'Gato',  12, 2);   -- de Ana (id 2)
```

</details>

---

## Paso 2.3 — Ve las mascotas (LEER)

```sql
SELECT * FROM mascotas;
```

Deberías ver tus 2 mascotas con su `tutor_id`. ✅

---

## Paso 2.4 — 🧪 Prueba el poder de la clave foránea (a propósito falla)

Intenta insertar una mascota de un tutor que **no existe** (por ejemplo el `tutor_id` 999):

```sql
INSERT INTO mascotas (nombre, especie, edad_meses, tutor_id) VALUES
('Fantasma', 'Perro', 10, 999);
```

PostgreSQL lo **rechazará** con un error parecido a:

```text
ERROR: insert or update on table "mascotas" violates foreign key constraint "fk_tutor"
DETAIL: Key (tutor_id)=(999) is not present in table "tutores".
```

> 🎉 ¡Eso es exactamente lo que queremos! La clave foránea **protege** tus datos: no deja
> registrar mascotas de tutores inexistentes. Esto se llama **integridad referencial**.

---

## ✅ Lo que lograste

* **CREATE TABLE** → crear tu propia tabla.
* **FOREIGN KEY** → relacionar una tabla con otra (relación 1:N).
* Viste cómo la FK **impide** datos inválidos (integridad referencial).
* `ON DELETE CASCADE` para no dejar registros huérfanos.

> 📤 **Entrega:** guarda tu `CREATE TABLE mascotas` y tus `INSERT` en `paso2.sql`, y una
> captura del **error de clave foránea** del paso 2.4. Dónde ubicar los archivos:
> [Entrega](ENTREGA.md).

➡️ **Siguiente:** en el [Ejercicio 3](paso3.md) crearás una tercera tabla que se relaciona
con **dos** tablas a la vez, y aprenderás a unirlas todas con un **JOIN**.
