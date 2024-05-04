Use Northwind
go
--Creacion de campos calculados en una tabla
--Creando una tabla nueva
Create table OrdenDetalle
(OrdenDetalleId int not null primary key,
ordenId int not null,
ProductoId int not null,
Precio decimal(7,2),
cantidad int,
Parcial as Precio * cantidad PERSISTED
)
GO
--Insertando un dato a la tabla
INSERT INTO OrdenDetalle (OrdenDetalleId, ordenId, ProductoId
,Precio, cantidad) values (1, 22, 7, 56.70, 7)
go
--Consultando la tabla y revisando el campo calculado
Select * from OrdenDetalle
go
--Agregar a una tabla existente de Northwind un campo calculado
Alter table [Order Details]
add partial as UnitPrice * Quantity
--consultar el resultado
Select * from [Order Details]
go






