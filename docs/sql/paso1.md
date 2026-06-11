Crear una relación de **Uno a Muchos** (un tutor puede tener varias mascotas) es la mejor forma de entender cómo funcionan las claves foráneas (FK).

Vamos a usar el ejemplo de **Tutor y Mascota** en PostgreSQL. Aquí tienes el script paso a paso, diseñado para que entiendas perfectamente qué hace cada línea.

---

## Código SQL para PostgreSQL

Puedes copiar y pegar este código directamente en tu editor de PostgreSQL (como pgAdmin o psql):

```sql
-- =============================================================
-- PASO 1: Crear la tabla independiente (Tutor)
-- Esta tabla debe existir primero porque la otra dependerá de ella.
-- =============================================================

CREATE TABLE tutores (
    -- SERIAL genera un número único que aumenta solo (1, 2, 3...)
    -- PRIMARY KEY indica que este campo identifica de forma única a cada tutor
    id_tutor SERIAL PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(15)
);

-- =============================================================
-- PASO 2: Crear la tabla dependiente (Mascotas)
-- Esta tabla incluye la Clave Foránea (FK) para conectarse con Tutores.
-- =============================================================

CREATE TABLE mascotas (
    id_mascota SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    especie VARCHAR(30), -- Ejemplo: Perro, Gato, Ave
    edad_meses INT,
    
    -- Creamos la columna que guardará el ID del tutor
    tutor_id INT,
    
    -- Definimos explícitamente que 'tutor_id' es una CLAVE FORÁNEA (FK)
    -- que hace referencia al 'id_tutor' de la tabla 'tutores'
    CONSTRAINT fk_tutor
        FOREIGN KEY (tutor_id) 
        REFERENCES tutores(id_tutor)
        ON DELETE CASCADE -- Si borras un tutor, se borran sus mascotas automáticamente
);

-- =============================================================
-- PASO 3: Insertar registros de prueba (3 en cada tabla)
-- =============================================================

-- Primero insertamos los tutores (no ponemos el ID porque se genera solo)
INSERT INTO tutores (nombre, telefono) VALUES 
('Carlos Mendoza', '555-1234'),
('Ana Gómez', '555-5678'),
('Luis Martínez', '555-9012');

-- Ahora insertamos las mascotas asociándolas a los IDs de los tutores creados
-- (Carlos es ID 1, Ana es ID 2, Luis es ID 3)
INSERT INTO mascotas (nombre, especie, edad_meses, tutor_id) VALUES 
('Firulais', 'Perro', 24, 1),  -- Firulais le pertenece a Carlos (ID 1)
('Michi', 'Gato', 12, 2),     -- Michi le pertenece a Ana (ID 2)
('Luna', 'Perro', 36, 1);     -- Luna también le pertenece a Carlos (ID 1)

-- =============================================================
-- PASO 4: Comprobar la relación con una consulta (JOIN)
-- =============================================================

-- Vamos a juntar ambas tablas para ver el nombre de la mascota junto a su tutor
SELECT 
    mascotas.nombre AS nombre_mascota,
    mascotas.especie,
    tutores.nombre AS nombre_tutor
FROM mascotas
INNER JOIN tutores ON mascotas.tutor_id = tutores.id_tutor;

```

---

## 💡 Conceptos clave que acabas de aplicar:

* **`SERIAL PRIMARY KEY`**: En PostgreSQL, esto le dice a la base de datos: *"Crea un ID numérico, asegúrate de que nadie lo repita y desentiéndete, que yo lo sumo automáticamente"*.
* **`FOREIGN KEY (tutor_id) REFERENCES tutores(id_tutor)`**: Este es el "puente". Le prohíbe al sistema registrar una mascota con un `tutor_id` que no exista en la tabla de tutores. Si intentaras registrar una mascota con el tutor `99`, PostgreSQL te dará un error de inmediato.
* **`ON DELETE CASCADE`**: Es una regla de integridad. Si "Carlos" decide darse de baja en el sistema, no queremos que sus mascotas se queden "huérfanas" en la base de datos causando errores, así que se eliminan junto con él.

