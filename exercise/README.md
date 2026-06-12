# Ejercicios de PostgreSQL 🐘

Catálogo de los sets de ejercicios del curso. Cada **set** es una ruta guiada, de lo más
simple a lo más completo, sobre un caso práctico. Hazlos en orden.

> **Requisito:** tener el laboratorio abierto y pgAdmin conectado.
> Si aún no llegas ahí, sigue el [README principal](../README.md).

## Sets disponibles

| # | Set | De qué trata | Aprendes |
|---|---|---|---|
| 01 | **[Veterinaria](01-veterinaria/README.md)** | Tutores, mascotas y consultas | CRUD básico, CREATE TABLE, claves foráneas y JOIN |

> 🚧 Se irán agregando más sets. Cada uno vive en su propia carpeta (`02-…`, `03-…`) para que
> no se mezclen entre sí.

## Cómo se organizan las entregas

Cada set indica qué entregar y cómo. La estructura general es **una carpeta por alumno**, y
dentro **una subcarpeta por set**:

```
entregas/
└── apellido_nombre/
    ├── 01-veterinaria/
    │   ├── paso1.sql
    │   ├── paso1.png
    │   └── ...
    └── 02-…/
```

Así tus entregas de distintos sets **nunca chocan**. El detalle de cada set está en su propio
archivo de **Entrega**.
