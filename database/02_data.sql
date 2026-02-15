-- PostgreSQL 15 Data Population
-- Insert test data for Gym/Spa Chain Database

-- Insert Clientes (10 records)
INSERT INTO Cliente (nombre, apellidos, ciudad) VALUES
('Carlos', 'Rodríguez', 'Bogotá'),
('María', 'González', 'Medellín'),
('Juan', 'Martínez', 'Cali'),
('Ana', 'López', 'Bogotá'),
('Pedro', 'Hernández', 'Medellín'),
('Laura', 'García', 'Barranquilla'),
('Diego', 'Ramírez', 'Bogotá'),
('Sofía', 'Torres', 'Medellín'),
('Miguel', 'Flores', 'Cali'),
('Valentina', 'Morales', 'Cartagena');

-- Insert Sucursales (10 records)
INSERT INTO Sucursal (nombre, ciudad) VALUES
('Sucursal Norte', 'Bogotá'),
('Sucursal Sur', 'Bogotá'),
('Sucursal Centro', 'Medellín'),
('Sucursal Poblado', 'Medellín'),
('Sucursal Valle', 'Cali'),
('Sucursal Costa', 'Barranquilla'),
('Sucursal Histórica', 'Cartagena'),
('Sucursal Oriente', 'Bucaramanga'),
('Sucursal Occidente', 'Pereira'),
('Sucursal Caribe', 'Santa Marta');

-- Insert Productos (10 records)
INSERT INTO Producto (nombre, tipoProducto) VALUES
('Membresía Básica', 'Membresía'),
('Membresía Premium', 'Membresía'),
('Membresía VIP', 'Membresía'),
('Yoga Matutino', 'Clase'),
('Spinning', 'Clase'),
('Pilates', 'Clase'),
('CrossFit', 'Clase'),
('Masaje Relajante', 'Servicio'),
('Sauna y Vapor', 'Servicio'),
('Entrenamiento Personal', 'Servicio');

-- Insert Inscripciones (multiple enrollments)
INSERT INTO Inscripcion (idProducto, idCliente) VALUES
(1, 1), (2, 1), (4, 1), (5, 1), -- Carlos: 4 productos
(1, 2), (6, 2), (8, 2), -- María: 3 productos
(3, 3), (7, 3), (10, 3), -- Juan: 3 productos
(1, 4), (4, 4), -- Ana: 2 productos
(2, 5), -- Pedro: 1 producto
(1, 6), (5, 6), -- Laura: 2 productos
(3, 7), -- Diego: 1 producto
(2, 8), (6, 8), -- Sofía: 2 productos
(1, 9), -- Miguel: 1 producto
(2, 10); -- Valentina: 1 producto

-- Insert Disponibilidad (products available at branches)
INSERT INTO Disponibilidad (idSucursal, idProducto) VALUES
-- Sucursal Norte (Bogotá) - NO tiene productos 6, 7, 10
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 8), (1, 9),
-- Sucursal Sur (Bogotá) - basic products
(2, 1), (2, 2), (2, 4), (2, 5), (2, 8),
-- Sucursal Centro (Medellín) - tiene 6, 7, 10 que Bogotá NO tiene
(3, 2), (3, 3), (3, 6), (3, 7), (3, 9), (3, 10),
-- Sucursal Poblado (Medellín) - all products
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 8), (4, 9), (4, 10),
-- Sucursal Valle (Cali)
(5, 1), (5, 2), (5, 4), (5, 5), (5, 6),
-- Sucursal Costa (Barranquilla)
(6, 1), (6, 3), (6, 7), (6, 8), (6, 9),
-- Sucursal Histórica (Cartagena)
(7, 2), (7, 3), (7, 8), (7, 9), (7, 10),
-- Sucursal Oriente (Bucaramanga)
(8, 1), (8, 2), (8, 4), (8, 5),
-- Sucursal Occidente (Pereira)
(9, 1), (9, 6), (9, 7), (9, 8),
-- Sucursal Caribe (Santa Marta)
(10, 2), (10, 3), (10, 9), (10, 10);

-- Insert Visitas (visits in the last 2 months)
INSERT INTO Visitan (idSucursal, idCliente, fechaVisita) VALUES
-- Recent visits (last month)
(1, 1, CURRENT_DATE - INTERVAL '5 days'),
(1, 1, CURRENT_DATE - INTERVAL '15 days'),
(1, 2, CURRENT_DATE - INTERVAL '10 days'),
(1, 4, CURRENT_DATE - INTERVAL '20 days'),
(1, 7, CURRENT_DATE - INTERVAL '25 days'),
(3, 2, CURRENT_DATE - INTERVAL '8 days'),
(3, 5, CURRENT_DATE - INTERVAL '12 days'),
(3, 8, CURRENT_DATE - INTERVAL '18 days'),
(4, 2, CURRENT_DATE - INTERVAL '3 days'),
(4, 5, CURRENT_DATE - INTERVAL '7 days'),
-- Older visits (more than 1 month ago)
(2, 1, CURRENT_DATE - INTERVAL '45 days'),
(2, 4, CURRENT_DATE - INTERVAL '50 days'),
(5, 3, CURRENT_DATE - INTERVAL '40 days'),
(5, 9, CURRENT_DATE - INTERVAL '60 days'),
(6, 6, CURRENT_DATE - INTERVAL '35 days');

-- Verify data
SELECT 'Clientes' as tabla, COUNT(*) as registros FROM Cliente
UNION ALL
SELECT 'Sucursales', COUNT(*) FROM Sucursal
UNION ALL
SELECT 'Productos', COUNT(*) FROM Producto
UNION ALL
SELECT 'Inscripciones', COUNT(*) FROM Inscripcion
UNION ALL
SELECT 'Disponibilidad', COUNT(*) FROM Disponibilidad
UNION ALL
SELECT 'Visitas', COUNT(*) FROM Visitan;
