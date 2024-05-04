-- Desactivar la restricción CHK_Monto_Positive en la tabla Pedidos
ALTER TABLE Pedidos
NOCHECK CONSTRAINT CHK_Monto_Positive;

-- Activar nuevamente la restricción CHK_Monto_Positive en la tabla Pedidos
ALTER TABLE Pedidos
CHECK CONSTRAINT CHK_Monto_Positive;
