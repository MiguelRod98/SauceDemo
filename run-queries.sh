#!/bin/bash

echo "🚀 Iniciando PostgreSQL con Docker..."
docker-compose up -d

echo "⏳ Esperando que PostgreSQL esté listo..."
sleep 5

echo "📊 Ejecutando Queries..."
echo ""
echo "=== Query 1: Clientes Sucursal Norte (último mes) ==="
docker exec -it saucedemo-db psql -U postgres -d gym_spa_db -f /docker-entrypoint-initdb.d/query1_clientes_sucursal_norte.sql

echo ""
echo "=== Query 2: Clientes por Sucursal (DESC) ==="
docker exec -it saucedemo-db psql -U postgres -d gym_spa_db -f /docker-entrypoint-initdb.d/query2_clientes_por_sucursal.sql

echo ""
echo "=== Query 3: Productos Medellín NO Bogotá ==="
docker exec -it saucedemo-db psql -U postgres -d gym_spa_db -f /docker-entrypoint-initdb.d/query3_productos_medellin_no_bogota.sql

echo ""
echo "=== Query 4: Clientes con más de 2 productos ==="
docker exec -it saucedemo-db psql -U postgres -d gym_spa_db -f /docker-entrypoint-initdb.d/query4_clientes_mas_2_productos.sql

echo ""
echo "=== Query 5: Última visita por cliente ==="
docker exec -it saucedemo-db psql -U postgres -d gym_spa_db -f /docker-entrypoint-initdb.d/query5_ultima_visita_cliente.sql

echo ""
echo "✅ Queries ejecutados exitosamente!"
echo ""
echo "💡 Para detener: docker-compose down"
echo "💡 Para conectar: docker exec -it saucedemo-db psql -U postgres -d gym_spa_db"
