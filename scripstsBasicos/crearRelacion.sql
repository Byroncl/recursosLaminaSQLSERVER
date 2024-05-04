-- Crear tabla Usuarios
CREATE TABLE Usuarios (
    UserID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Email VARCHAR(100)
);

-- Crear tabla Pedidos
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,
    UserID INT,
    FechaPedido DATE,
    Monto DECIMAL(10, 2),
    CONSTRAINT FK_Usuario_Pedido FOREIGN KEY (UserID) REFERENCES Usuarios(UserID)
);

-- Agregar un constraint CHECK para asegurar que el monto del pedido sea mayor que cero
ALTER TABLE Pedidos
ADD CONSTRAINT CHK_Monto_Positive CHECK (Monto > 0);
