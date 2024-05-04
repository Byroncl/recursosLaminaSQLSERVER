-- Crear la base de datos
CREATE DATABASE Tienda;
GO

-- Usar la base de datos
USE Tienda;
GO

-- Crear la tabla de productos
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Precio DECIMAL(10, 2),
    Stock INT
);

-- Crear la tabla de clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Email VARCHAR(100)
);

-- Crear la tabla de ventas
CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY,
    ClienteID INT,
    Fecha DATE,
    Total DECIMAL(10, 2),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Crear la tabla de detalles de venta
CREATE TABLE DetallesVenta (
    VentaID INT,
    ProductoID INT,
    Cantidad INT,
    PrecioUnitario DECIMAL(10, 2),
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- Insertar datos de ejemplo en la tabla de productos
INSERT INTO Productos (ProductoID, Nombre, Precio, Stock)
VALUES
    (1, 'Camiseta', 15.99, 100),
    (2, 'Pantalón', 29.99, 50),
    (3, 'Zapatos', 39.99, 30);

-- Insertar datos de ejemplo en la tabla de clientes
INSERT INTO Clientes (ClienteID, Nombre, Email)
VALUES
    (1, 'Juan Pérez', 'juan@example.com'),
    (2, 'María García', 'maria@example.com'),
    (3, 'Carlos López', 'carlos@example.com');

-- Insertar datos de ejemplo en la tabla de ventas
INSERT INTO Ventas (VentaID, ClienteID, Fecha, Total)
VALUES
    (1, 1, '2024-05-01', 45.97),
    (2, 2, '2024-05-02', 75.98),
    (3, 3, '2024-05-03', 109.97);

-- Insertar datos de ejemplo en la tabla de detalles de venta
INSERT INTO DetallesVenta (VentaID, ProductoID, Cantidad, PrecioUnitario)
VALUES
    (1, 1, 2, 15.99),
    (1, 3, 1, 29.99),
    (2, 2, 3, 29.99),
    (3, 1, 1, 15.99),
    (3, 2, 2, 29.99),
    (3, 3, 1, 39.99);
