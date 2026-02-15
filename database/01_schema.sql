-- PostgreSQL 15 Schema Creation
-- Gym/Spa Chain Database

-- Drop tables if exist (for clean setup)
DROP TABLE IF EXISTS Visitan CASCADE;
DROP TABLE IF EXISTS Disponibilidad CASCADE;
DROP TABLE IF EXISTS Inscripcion CASCADE;
DROP TABLE IF EXISTS Producto CASCADE;
DROP TABLE IF EXISTS Sucursal CASCADE;
DROP TABLE IF EXISTS Cliente CASCADE;

-- Create Cliente table
CREATE TABLE Cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL
);

-- Create Sucursal table
CREATE TABLE Sucursal (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL
);

-- Create Producto table
CREATE TABLE Producto (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipoProducto VARCHAR(50) NOT NULL
);

-- Create Inscripcion table
CREATE TABLE Inscripcion (
    idProducto INTEGER NOT NULL,
    idCliente INTEGER NOT NULL,
    PRIMARY KEY (idProducto, idCliente),
    FOREIGN KEY (idProducto) REFERENCES Producto(id) ON DELETE CASCADE,
    FOREIGN KEY (idCliente) REFERENCES Cliente(id) ON DELETE CASCADE
);

-- Create Disponibilidad table
CREATE TABLE Disponibilidad (
    idSucursal INTEGER NOT NULL,
    idProducto INTEGER NOT NULL,
    PRIMARY KEY (idSucursal, idProducto),
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(id) ON DELETE CASCADE,
    FOREIGN KEY (idProducto) REFERENCES Producto(id) ON DELETE CASCADE
);

-- Create Visitan table
CREATE TABLE Visitan (
    idSucursal INTEGER NOT NULL,
    idCliente INTEGER NOT NULL,
    fechaVisita DATE NOT NULL,
    PRIMARY KEY (idSucursal, idCliente, fechaVisita),
    FOREIGN KEY (idSucursal) REFERENCES Sucursal(id) ON DELETE CASCADE,
    FOREIGN KEY (idCliente) REFERENCES Cliente(id) ON DELETE CASCADE
);

-- Create indexes for better query performance
CREATE INDEX idx_visitan_fecha ON Visitan(fechaVisita);
CREATE INDEX idx_cliente_ciudad ON Cliente(ciudad);
CREATE INDEX idx_sucursal_ciudad ON Sucursal(ciudad);
