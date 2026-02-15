-- Query 5: Para cada cliente, mostrar su última visita (fecha más reciente) y a qué sucursal fue. Si no ha visitado, mostrar "Sin visitas"

SELECT 
    c.nombre,
    c.apellidos,
    COALESCE(s.nombre, 'Sin visitas') AS ultima_sucursal,
    COALESCE(TO_CHAR(v.fechaVisita, 'YYYY-MM-DD'), 'Sin visitas') AS ultima_fecha_visita
FROM 
    Cliente c
    LEFT JOIN (
        SELECT 
            v1.idCliente,
            v1.idSucursal,
            v1.fechaVisita
        FROM 
            Visitan v1
            INNER JOIN (
                SELECT 
                    idCliente,
                    MAX(fechaVisita) AS max_fecha
                FROM 
                    Visitan
                GROUP BY 
                    idCliente
            ) v2 ON v1.idCliente = v2.idCliente AND v1.fechaVisita = v2.max_fecha
    ) v ON c.id = v.idCliente
    LEFT JOIN Sucursal s ON v.idSucursal = s.id
ORDER BY 
    c.nombre, c.apellidos;
