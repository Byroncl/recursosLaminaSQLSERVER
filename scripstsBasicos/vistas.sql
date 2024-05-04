use NORTHWIND
go
---Crear una vista
CREATE VIEW VIEW_VENTAS
AS
Select c.CustomerID, c.CompanyName, c.Country, o.OrderID
, o.OrderDate, cat.CategoryName, p.ProductName, d.UnitPrice, d.Quantity
, d.UnitPrice * d.Quantity as TotalPartial
from customers as c 
inner join orders as o on c.CustomerID=o.CustomerID
inner join [order details] as d on d.OrderID=o.OrderID
inner join products as p on p.ProductID=d.ProductID
inner join Categories as cat on p.CategoryID=cat.CategoryID
GO
---Usar la vista
SELECT * FROM VIEW_VENTAS
GO
---VER EL SCRIPT QUE ORIGINA UNA VISTA
SP_HELPTEXT select * from VIEW_VENTAS

--MODIFICAR LA VISTA ENCRIPTANDO EL SCRIPT
ALTER VIEW VIEW_VENTAS (CODIGOCLIENTE, COMPAÑIA, PAIS, NUMEROORDEN, FECHA
, CATEGORIA, PRODUCTO, PRECIO, CANTIDAD, TOTAL)
WITH ENCRYPTION
AS
Select c.CustomerID, c.CompanyName, c.Country, o.OrderID
, o.OrderDate, cat.CategoryName, p.ProductName, d.UnitPrice, d.Quantity, 
d.UnitPrice * d.Quantity as TotalParcial
from DBO.customers as c 
inner join DBO.orders as o on c.CustomerID=o.CustomerID
inner join DBO.[order details] as d on d.OrderID=o.OrderID
inner join DBO.products as p on p.ProductID=d.ProductID
inner join DBO.Categories as cat on p.CategoryID=cat.CategoryID
GO

---VER EL SCRIPT QUE ORIGINA UNA VISTA ENCRIPTADO
SP_HELPTEXT select * from VIEW_VENTAS

--MODIFICAR LA VISTA VINCULANDOLA A ESQUEMA
ALTER VIEW VIEW_VENTAS (CODIGOCLIENTE, COMPAÑIA, PAIS, NUMEROORDEN, FECHA
, CATEGORIA, PRODUCTO, PRECIO, CANTIDAD, TOTAL)
WITH SCHEMABINDING
AS
Select c.CustomerID, c.CompanyName, c.Country, o.OrderID
, o.OrderDate, cat.CategoryName, p.ProductName, d.UnitPrice, d.Quantity, 
d.UnitPrice * d.Quantity as TotalParcial
from DBO.customers as c 
inner join DBO.orders as o on c.CustomerID=o.CustomerID
inner join DBO.[order details] as d on d.OrderID=o.OrderID
inner join DBO.products as p on p.ProductID=d.ProductID
inner join DBO.Categories as cat on p.CategoryID=cat.CategoryID
GO
DROP TABLE [Order Details]
GO
--MODIFICAR LA VISTA USANDO VIEW_METADATA
ALTER VIEW VIEW_VENTAS (CODIGOCLIENTE, COMPAÑIA, PAIS, NUMEROORDEN, FECHA
, CATEGORIA, PRODUCTO, PRECIO, CANTIDAD, TOTAL)
WITH ENCRYPTION, SCHEMABINDING, VIEW_METADATA
AS
Select c.CustomerID, c.CompanyName, c.Country, o.OrderID
, o.OrderDate, cat.CategoryName, p.ProductName, d.UnitPrice, d.Quantity, 
d.UnitPrice * d.Quantity as TotalParcial
from DBO.customers as c 
inner join DBO.orders as o on c.CustomerID=o.CustomerID
inner join DBO.[order details] as d on d.OrderID=o.OrderID
inner join DBO.products as p on p.ProductID=d.ProductID
inner join DBO.Categories as cat on p.CategoryID=cat.CategoryID
GO

---USO DE WITH CHECK OPTION
ALTER VIEW VIEW_CLIENTESPORPAIS
AS
SELECT CUSTOMERID, COMPANYNAME, CONTACTNAME, CONTACTTITLE, COUNTRY
FROM CUSTOMERS
WHERE COUNTRY='USA'
WITH CHECK OPTION
GO
---USAR LA VISTA
SELECT * FROM VIEW_CLIENTESPORPAIS
GO
---INSERTAR DATOS A LA VISTA VIEW_CLIENTESPORPAIS
INSERT INTO VIEW_CLIENTESPORPAIS 
(CUSTOMERID, COMPANYNAME, CONTACTNAME, CONTACTTITLE, COUNTRY)
VALUES
('ABCD4','LA OTRA, S.A.','JUAN PEREZ','ING','USA')
GO

---VISTAS PARTICIONADAS
CREATE VIEW VIEW_CATALOGO
AS
SELECT COMPANYNAME, CONTACTNAME, CONTACTTITLE, COUNTRY
FROM CUSTOMERS
UNION ALL
SELECT COMPANYNAME, CONTACTNAME, CONTACTTITLE, COUNTRY
FROM SUPPLIERS
GO
---CREAR UNA VISTA A PARTIR DE UNA VISTA
CREATE VIEW VIEW_LISTAEMPRESAS
AS
SELECT * FROM VIEW_CATALOGO
GO
---USAR LA VISTA

SELECT * FROM VIEW_LISTAEMPRESAS

---CREAR UN INDICE DE TIPO UNIQUE CLUSTERED PARA LA VISTA
CREATE UNIQUE CLUSTERED INDEX IDX_VENTAS ON VIEW_VENTAS 
(CODIGOCLIENTE, NUMEROORDEN, PRODUCTO)
GO
---CREAR UN INDICE NO CLUSTEREADO
CREATE NONCLUSTERED INDEX IDX_COMPANIA ON VIEW_VENTAS
(COMPAÑIA)
GO
---VISTAS DEL SISTEMA
---PARA CONSULTAR LOS CONSTRAINT DE NUESTRA BD

SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
---VISTAS DE ADMINISTRACIÓN DINAMICA
SELECT WAIT_TYPE, WAIT_TIME_MS FROM SYS.dm_os_wait_stats












