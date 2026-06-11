diagrama entidad-relación (ER) en formato **Mermaid**. 

Este diagrama representa visualmente las tres tablas que creamos, sus campos, los tipos de datos y cómo se conectan a través de las llaves foráneas.


```mermaid
erDiagram
    tutores {
        int id_tutor PK "SERIAL"
        varchar nombre "NOT NULL"
        varchar telefono
    }

    mascotas {
        int id_mascota PK "SERIAL"
        varchar nombre "NOT NULL"
        varchar especie
        int edad_meses
        int tutor_id FK
    }

    consultas_veterinarias {
        int id_consulta PK "SERIAL"
        date fecha_consulta "NOT NULL"
        varchar motivo "NOT NULL"
        decimal costo
        int tutor_id FK
        int mascota_id FK
    }

    %% Relaciones entre las tablas
    tutores ||--o{ mascotas : "un tutor tiene"
    tutores ||--o{ consultas_veterinarias : "autoriza"
    mascotas ||--o{ consultas_veterinarias : "recibe"

```

---

### Explicación del diagrama para la clase:

* **`PK` (Primary Key)**: Identifica la llave primaria de cada tabla (los identificadores únicos autoincrementables).
* **`FK` (Foreign Key)**: Identifica las llaves foráneas, que son los campos que apuntan a otra tabla para crear el enlace.
* **Simbología de las líneas (`||--o{`)**:
* El lado con las dos líneas verticales (`||`) significa **Uno (1)**.
* El lado con la "pata de gallo" (`o{`) significa **Muchos (N)**.



analizando el diagrama:

1. **Un** tutor puede tener **muchas** mascotas.
2. **Un** tutor puede figurar en **muchas** consultas.
3. **Una** mascota puede tener **muchas** consultas a lo largo de su vida.