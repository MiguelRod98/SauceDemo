# 🗄️ Database - Gym/Spa Chain SQL Queries

## Descripción del Sistema

Sistema de gestión para una cadena de gimnasios/spas con:
- Clientes que pueden visitar diferentes sucursales
- Sucursales ubicadas en diferentes ciudades
- Productos (membresías, clases, servicios)
- Inscripciones de clientes a productos
- Disponibilidad de productos por sucursal
- Registro de visitas de clientes a sucursales

## 📊 Modelo de Datos

### Tablas

#### Cliente
| Campo     | Tipo    | Restricción |
|-----------|---------|-------------|
| id        | number  | PK, NN      |
| nombre    | varchar | NN          |
| apellidos | varchar | NN          |
| ciudad    | varchar | NN          |

#### Sucursal
| Campo  | Tipo    | Restricción |
|--------|---------|-------------|
| id     | number  | PK, NN      |
| nombre | varchar | NN          |
| ciudad | varchar | NN          |

#### Producto
| Campo        | Tipo    | Restricción |
|--------------|---------|-------------|
| id           | number  | PK, NN      |
| nombre       | varchar | NN          |
| tipoProducto | varchar | NN          |

#### Inscripcion
| Campo      | Tipo   | Restricción        |
|------------|--------|--------------------|
| idProducto | number | FK(Producto.id)    |
| idCliente  | number | FK(Cliente.id)     |

#### Disponibilidad
| Campo      | Tipo   | Restricción        |
|------------|--------|--------------------|
| idSucursal | number | PK, FK(Sucursal.id)|
| idProducto | number | FK(Producto.id)    |

#### Visitan
| Campo       | Tipo   | Restricción        |
|-------------|--------|--------------------|
| idSucursal  | number | PK, FK(Sucursal.id)|
| idCliente   | number | PK, FK(Cliente.id) |
| fechaVisita | Date   | NN                 |

## 📝 Queries Implementados

### Query 1: Clientes de Sucursal Norte (Último Mes)
**Archivo**: `query1_clientes_sucursal_norte.sql`

Lista el nombre completo de clientes que visitaron "Sucursal Norte" en el último mes.

**Resultado esperado**:
```
nombre_completo
-----------------
Ana López
Carlos Rodríguez
Diego Ramírez
```

### Query 2: Clientes por Sucursal
**Archivo**: `query2_clientes_por_sucursal.sql`

Muestra cuántos clientes distintos han visitado cada sucursal, ordenado descendente.

**Resultado esperado**:
```
sucursal          | ciudad    | clientes_distintos
------------------|-----------|-------------------
Sucursal Norte    | Bogotá    | 4
Sucursal Centro   | Medellín  | 3
Sucursal Poblado  | Medellín  | 2
...
```

### Query 3: Productos Medellín vs Bogotá
**Archivo**: `query3_productos_medellin_no_bogota.sql`

Encuentra productos disponibles en Medellín pero NO en Bogotá.

**Resultado esperado**:
```
nombre                    | tipoProducto
--------------------------|-------------
Pilates                   | Clase
CrossFit                  | Clase
Entrenamiento Personal    | Servicio
```

### Query 4: Clientes con Múltiples Productos
**Archivo**: `query4_clientes_mas_2_productos.sql`

Lista clientes inscritos en más de 2 productos con la cantidad.

**Resultado esperado**:
```
nombre  | apellidos  | cantidad_productos
--------|------------|-------------------
Carlos  | Rodríguez  | 4
María   | González   | 3
Juan    | Martínez   | 3
```

### Query 5: Última Visita por Cliente
**Archivo**: `query5_ultima_visita_cliente.sql`

Muestra la última visita de cada cliente o "Sin visitas" si no ha visitado.

**Resultado esperado**:
```
nombre    | apellidos  | ultima_sucursal    | ultima_fecha_visita
----------|------------|--------------------|--------------------
Carlos    | Rodríguez  | Sucursal Norte     | 2024-01-15
María     | González   | Sucursal Poblado   | 2024-01-18
Valentina | Morales    | Sin visitas        | Sin visitas
```

## 🚀 Cómo Ejecutar

### 1. Crear la base de datos

```bash
psql -U postgres
CREATE DATABASE gym_spa_db;
\c gym_spa_db
```

### 2. Ejecutar scripts de creación

```bash
\i database/01_schema.sql
\i database/02_data.sql
```

### 3. Ejecutar queries individuales

```bash
\i database/query1_clientes_sucursal_norte.sql
\i database/query2_clientes_por_sucursal.sql
\i database/query3_productos_medellin_no_bogota.sql
\i database/query4_clientes_mas_2_productos.sql
\i database/query5_ultima_visita_cliente.sql
```

## 🔍 Características Técnicas

- **Motor**: PostgreSQL 15
- **Integridad Referencial**: Todas las FK con CASCADE
- **Índices**: Optimización en fechas y ciudades
- **Datos de Prueba**: 10+ registros por tabla
- **Queries Complejos**: JOINs, subqueries, agregaciones, COALESCE

## 📌 Notas

- Los datos de prueba incluyen visitas de los últimos 2 meses
- Las fechas usan `CURRENT_DATE - INTERVAL` para ser dinámicas
- Query 5 usa subquery para encontrar la fecha máxima por cliente
- Query 3 usa NOT IN con subquery para exclusión
