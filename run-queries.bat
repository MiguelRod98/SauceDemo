@echo off
echo ========================================
echo   Validacion de Queries SQL
echo ========================================
echo.

echo [1/3] Iniciando PostgreSQL con Docker...
docker-compose up -d

echo [2/3] Esperando que PostgreSQL este listo...
timeout /t 5 /nobreak >nul

echo [3/3] Ejecutando Queries...
echo.

echo === Query 1: Clientes Sucursal Norte (ultimo mes) ===
docker exec saucedemo-db psql -U postgres -d gym_spa_db -f /docker-entrypoint-initdb.d/query1_clientes_sucursal_norte.sql
echo.

echo === Query 2: Clientes por Sucursal (DESC) ===
docker exec saucedemo-db psql -U postgres -d gym_spa_db -f /docker-entrypoint-initdb.d/query2_clientes_por_sucursal.sql
echo.

echo === Query 3: Productos Medellin NO Bogota ===
docker exec saucedemo-db psql -U postgres -d gym_spa_db -f /docker-entrypoint-initdb.d/query3_productos_medellin_no_bogota.sql
echo.

echo === Query 4: Clientes con mas de 2 productos ===
docker exec saucedemo-db psql -U postgres -d gym_spa_db -f /docker-entrypoint-initdb.d/query4_clientes_mas_2_productos.sql
echo.

echo === Query 5: Ultima visita por cliente ===
docker exec saucedemo-db psql -U postgres -d gym_spa_db -f /docker-entrypoint-initdb.d/query5_ultima_visita_cliente.sql
echo.

echo ========================================
echo   Queries ejecutados exitosamente!
echo ========================================
echo.
echo Para detener: docker-compose down
echo Para conectar: docker exec -it saucedemo-db psql -U postgres -d gym_spa_db
echo.
