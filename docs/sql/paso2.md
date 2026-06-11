cómo unir **tres tablas**, la mejor forma es añadir una entidad que represente una acción o un historial donde participen tanto el tutor como la mascota.

En este caso, vamos a crear una tabla llamada **`consultas_veterinarias`**. Esta tabla registrará las visitas al veterinario y necesitará relacionarse con la mascota (para saber a quién atienden) y con el tutor (para saber quién autoriza o paga).

Aquí tienes el script con la nueva tabla, los datos de prueba y el código paso a paso totalmente comentado.

---

### Código SQL para añadir la tercera tabla y hacer el JOIN triple

Puedes ejecutar este código directamente en la base de datos `veterinaria_db` que creaste en el paso anterior:

```sql
-- =============================================================
-- PASO 1: Crear la tercera tabla (Consultas Veterinarias)
-- Esta tabla depende de las dos anteriores porque usará sus IDs.
-- =============================================================

CREATE TABLE consultas_veterinarias (
    id_consulta SERIAL PRIMARY KEY,
    fecha_consulta DATE NOT NULL,
    motivo VARCHAR(255) NOT NULL, -- Ejemplo: Vacunación, Revisión, etc.
    costo DECIMAL(6,2),          -- Permite guardar números con decimales (ej: 45.50)
    
    -- Creamos las columnas para las Claves Foráneas (FK)
    tutor_id INT,
    mascota_id INT,
    
    -- Relación 1: Conectamos con la tabla 'tutores'
    CONSTRAINT fk_consulta_tutor
        FOREIGN KEY (tutor_id) 
        REFERENCES tutores(id_tutor)
        ON DELETE CASCADE,
        
    -- Relación 2: Conectamos con la tabla 'mascotas'
    CONSTRAINT fk_consulta_mascota
        FOREIGN KEY (mascota_id) 
        REFERENCES mascotas(id_mascota)
        ON DELETE CASCADE
);

-- =============================================================
-- PASO 2: Insertar 3 registros de prueba en la nueva tabla
-- =============================================================

-- Recordemos los IDs que ya existían:
-- Tutores: 1 (Carlos), 2 (Ana)
-- Mascotas: 1 (Firulais - de Carlos), 2 (Michi - de Ana), 3 (Luna - de Carlos)

INSERT INTO consultas_veterinarias (fecha_consulta, motivo, costo, tutor_id, mascota_id) VALUES 
('2026-03-10', 'Vacuna anual contra la rabia', 35.00, 1, 1), -- Carlos (1) lleva a Firulais (1)
('2026-03-11', 'Esterilización y control', 120.50, 2, 2),   -- Ana (2) lleva a Michi (2)
('2026-03-12', 'Chequeo general de rutina', 25.00, 1, 3);    -- Carlos (1) lleva a Luna (3)


-- =============================================================
-- PASO 3: El JOIN de las 3 tablas (La magia de las relaciones)
-- =============================================================

-- Aquí le pedimos a la base de datos que junte la información de las tres tablas
-- usando las Claves Foráneas como "pegamento".

SELECT 
    -- Seleccionamos qué columnas queremos ver en el resultado final
    c.fecha_consulta AS "Fecha Visita",
    t.nombre AS "Nombre del Tutor",
    m.nombre AS "Nombre de la Mascota",
    m.especie AS "Especie",
    c.motivo AS "Motivo de la Consulta",
    c.costo AS "Total Pagado"
FROM consultas_veterinarias c  -- 'c' es un alias corto para no escribir todo el nombre de la tabla
-- Primer JOIN: Conectamos las consultas con los tutores
INNER JOIN tutores t ON c.tutor_id = t.id_tutor
-- Segundo JOIN: Conectamos las consultas con las mascotas
INNER JOIN mascotas m ON c.mascota_id = m.id_mascota;

```

---

### Explicación del JOIN triple para los alumnos:

Cuando ejecutas el último bloque de código (`SELECT` con los dos `INNER JOIN`), la base de datos hace lo siguiente en su mente:

1. Lee la tabla **`consultas_veterinarias`** (la tabla central).
2. Mira la columna `tutor_id` de la consulta, viaja a la tabla **`tutores`** y busca al tutor que tenga ese mismo ID para traer su nombre.
3. Mira la columna `mascota_id` de la consulta, viaja a la tabla **`mascotas`** y busca a la mascota que tenga ese mismo ID para traer su nombre y especie.

### 💡 Tips de aprendizaje incluidos en este paso:

* **Alias (`c`, `t`, `m`)**: Al lado del nombre de la tabla en el `FROM` y en el `JOIN`, pusimos una letra. Esto se llama *Alias*. Sirve para que el código sea más corto y limpio (en lugar de escribir `consultas_veterinarias.motivo`, solo escribes `c.motivo`).
* **`DECIMAL(6,2)`**: Es el tipo de dato ideal para dinero. El `6` significa que el número puede tener hasta 6 dígitos en total, y el `2` significa que dos de ellos serán decimales (por ejemplo: `9999.99`).