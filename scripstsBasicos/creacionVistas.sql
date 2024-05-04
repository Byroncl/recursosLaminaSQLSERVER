-- Crear una vista para las ventas
CREATE VIEW VIEW_VENTAS
AS
SELECT c.ClienteID, c.Nombre AS NombreCliente, c.Email AS CorreoCliente,
       v.Fecha AS FechaVenta, p.Nombre AS NombreProducto, 
       v.Total AS TotalVenta
FROM Clientes c
INNER JOIN Ventas v ON c.ClienteID = v.ClienteID
INNER JOIN DetallesVenta dv ON v.VentaID = dv.VentaID
INNER JOIN Productos p ON dv.ProductoID = p.ProductoID;

-- Usar la vista de ventas
SELECT * FROM VIEW_VENTAS;

-- Ver el script que origina la vista
SP_HELPTEXT 'VIEW_VENTAS';

-- Modificar la vista encriptando el script
ALTER VIEW VIEW_VENTAS
WITH ENCRYPTION
AS
SELECT c.ClienteID, c.Nombre AS NombreCliente, c.Email AS CorreoCliente,
       v.Fecha AS FechaVenta, p.Nombre AS NombreProducto, 
       v.Total AS TotalVenta
FROM dbo.Clientes c
INNER JOIN dbo.Ventas v ON c.ClienteID = v.ClienteID
INNER JOIN dbo.DetallesVenta dv ON v.VentaID = dv.VentaID
INNER JOIN dbo.Productos p ON dv.ProductoID = p.ProductoID;

-- Ver el script que origina la vista encriptada
SP_HELPTEXT 'VIEW_VENTAS';

-- Modificar la vista vinculándola a esquema
ALTER VIEW VIEW_VENTAS
WITH SCHEMABINDING
AS
SELECT c.ClienteID, c.Nombre AS NombreCliente, c.Email AS CorreoCliente,
       v.Fecha AS FechaVenta, p.Nombre AS NombreProducto, 
       v.Total AS TotalVenta
FROM dbo.Clientes c
INNER JOIN dbo.Ventas v ON c.ClienteID = v.ClienteID
INNER JOIN dbo.DetallesVenta dv ON v.VentaID = dv.VentaID
INNER JOIN dbo.Productos p ON dv.ProductoID = p.ProductoID;

-- Modificar la vista usando VIEW_METADATA
ALTER VIEW VIEW_VENTAS
WITH ENCRYPTION, SCHEMABINDING, VIEW_METADATA
AS
SELECT c.ClienteID, c.Nombre AS NombreCliente, c.Email AS CorreoCliente,
       v.Fecha AS FechaVenta, p.Nombre AS NombreProducto, 
       v.Total AS TotalVenta
FROM dbo.Clientes c
INNER JOIN dbo.Ventas v ON c.ClienteID = v.ClienteID
INNER JOIN dbo.DetallesVenta dv ON v.VentaID = dv.VentaID
INNER JOIN dbo.Productos p ON dv.ProductoID = p.ProductoID;

-- Uso de WITH CHECK OPTION
ALTER VIEW VIEW_CLIENTESPORPAIS
AS
SELECT ClienteID, Nombre, Email
FROM Clientes
WHERE Country='USA'
WITH CHECK OPTION;

-- Insertar datos en la vista VIEW_CLIENTESPORPAIS
INSERT INTO VIEW_CLIENTESPORPAIS 
(ClienteID, Nombre, Email)
VALUES
('ABCD4', 'LA OTRA, S.A.', 'JUANPEREZ@EMAIL.COM');

-- Vistas particionadas
CREATE VIEW VIEW_CATALOGO
AS
SELECT Nombre, Email
FROM Clientes
UNION ALL
SELECT Nombre, Email
FROM Proveedores;

-- Crear una vista a partir de otra vista
CREATE VIEW VIEW_LISTA_EMPRESAS
AS
SELECT * FROM VIEW_CATALOGO;

-- Usar la vista
SELECT * FROM VIEW_LISTA_EMPRESAS;

-- Crear un índice único agrupado para la vista
CREATE UNIQUE CLUSTERED INDEX IDX_VENTAS ON VIEW_VENTAS 
(ClienteID, FechaVenta);

-- Crear un índice no agrupado
CREATE NONCLUSTERED INDEX IDX_CLIENTE ON VIEW_VENTAS
(NombreCliente);

-- Vistas del sistema
-- Para consultar los constraint de nuestra base de datos
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE;

-- Vistas de administración dinámica
SELECT WAIT_TYPE, WAIT_TIME_MS FROM SYS.dm_os_wait_stats;
