-- Query 2: Mostrar cuántos clientes distintos han visitado cada sucursal, ordenado por cantidad de visitas descendente

SELECT 
    s.nombre AS sucursal,
    s.ciudad,
    COUNT(DISTINCT v.idCliente) AS clientes_distintos
FROM 
    Sucursal s
    LEFT JOIN Visitan v ON s.id = v.idSucursal
GROUP BY 
    s.id, s.nombre, s.ciudad
ORDER BY 
    clientes_distintos DESC;
