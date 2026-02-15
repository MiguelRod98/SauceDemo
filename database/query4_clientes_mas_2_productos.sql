-- Query 4: Listar los clientes (nombre, apellido) que están inscritos en más de 2 productos, mostrando la cantidad de productos

SELECT 
    c.nombre,
    c.apellidos,
    COUNT(i.idProducto) AS cantidad_productos
FROM 
    Cliente c
    INNER JOIN Inscripcion i ON c.id = i.idCliente
GROUP BY 
    c.id, c.nombre, c.apellidos
HAVING 
    COUNT(i.idProducto) > 2
ORDER BY 
    cantidad_productos DESC, c.nombre;
