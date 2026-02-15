-- Query 1: Listar nombre completo de clientes que han visitado la sucursal "Sucursal Norte" en el último mes

SELECT 
    CONCAT(c.nombre, ' ', c.apellidos) AS nombre_completo
FROM 
    Cliente c
    INNER JOIN Visitan v ON c.id = v.idCliente
    INNER JOIN Sucursal s ON v.idSucursal = s.id
WHERE 
    s.nombre = 'Sucursal Norte'
    AND v.fechaVisita >= CURRENT_DATE - INTERVAL '1 month'
ORDER BY 
    c.nombre, c.apellidos;
