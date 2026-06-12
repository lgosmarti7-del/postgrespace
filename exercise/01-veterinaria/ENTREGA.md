# 📤 Entrega de los ejercicios

Para cada ejercicio entregarás **2 archivos**: tu **script `.sql`** (lo que escribiste) y
**una captura** del resultado clave. Sigue estas reglas y se corregirá rápido y justo.

---

## Qué entregar por ejercicio

| Ejercicio | Archivo `.sql` (tu código) | Captura `.png` (resultado clave) |
|---|---|---|
| **Paso 1** | Todos tus `INSERT` y el `UPDATE` | `SELECT * FROM tutores;` mostrando **tus** tutores |
| **Paso 2** | El `CREATE TABLE mascotas` + tus `INSERT` | El **error de clave foránea** del paso 2.4 |
| **Paso 3** | El `CREATE TABLE consultas...` + `INSERT` | El resultado del **JOIN** de las 3 tablas |

> 💡 **Importante (paso 1):** uno de los tutores que insertes debe llevar **tu propio nombre y
> apellido**. Así tu entrega es única y no se puede copiar de un compañero.

---

## Dónde y cómo se organizan tus entregas

Tienes **una sola carpeta propia**: `entregas/apellido_nombre/`. Dentro, cada **set de
ejercicios** tiene su subcarpeta (este es el set `01-veterinaria`). Así, cuando hagas más
ejercicios, cada uno vive en su espacio y **nunca chocan** entre sí.

```
entregas/
└── apellido_nombre/              ← tu carpeta (la única que tocas)
    └── 01-veterinaria/           ← este set de ejercicios
        ├── paso1.sql
        ├── paso1.png
        ├── paso2.sql
        ├── paso2.png
        ├── paso3.sql
        └── paso3.png
```

Reglas:

- **Tu carpeta** se llama `apellido_nombre`: **todo en minúscula, sin tildes, sin `ñ` y sin
  espacios.** Ejemplo: María Núñez → `nunez_maria`.
- Dentro de cada set, los archivos se llaman simplemente `paso1`, `paso2`, `paso3`
  (la ruta ya dice de quién y de qué set son; no repitas tu nombre en cada archivo).

---

## Cómo guardar tu `.sql` desde pgAdmin

1. En el **Query Tool**, con tu código escrito, abre el menú **File** (o el icono de guardar 💾).
2. Elige **Save As** y guarda el archivo como `pasoN.sql` en tu carpeta del set.

## Cómo tomar la captura

- Asegúrate de que se vea **tu SQL** y el **resultado** (la grilla de abajo o el mensaje).
- Guarda la imagen como `pasoN.png` junto a su `.sql`.

---

## Subir tus entregas

Una vez tengas tus archivos en `entregas/apellido_nombre/01-veterinaria/`, haz **commit** en
tu **fork** y abre un **Pull Request** hacia el repositorio del curso.

> ¿No sabes aún qué es un Pull Request? No te preocupes: tu instructor te explicará este paso.
> Lo importante primero es tener tus archivos bien ubicados en tu carpeta.
