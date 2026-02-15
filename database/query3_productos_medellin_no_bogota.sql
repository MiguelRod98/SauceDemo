-- Query 3: Encontrar productos que están disponibles en la sucursal de ciudad "Medellín" pero NO en la sucursal de ciudad "Bogotá"

SELECT DISTINCT
    p.nombre,
    p.tipoProducto
FROM 
    Producto p
    INNER JOIN Disponibilidad d ON p.id = d.idProducto
    INNER JOIN Sucursal s ON d.idSucursal = s.id
WHERE 
    s.ciudad = 'Medellín'
    AND p.id NOT IN (
        SELECT d2.idProducto
        FROM Disponibilidad d2
        INNER JOIN Sucursal s2 ON d2.idSucursal = s2.id
        WHERE s2.ciudad = 'Bogotá'
    )
ORDER BY 
    p.nombre;
