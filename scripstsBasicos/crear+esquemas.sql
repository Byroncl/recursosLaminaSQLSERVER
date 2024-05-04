---------------------------------Cree un login---------------------------
use master
go 
create login UserInformatica with password = 'P@ssw0rd' 
---------------------------------cree un user para el login---------------
use Northwind
create user UserInformatica for login UserInformatica
with default_schema = Informatica 
go

---------------------------------Cree el esquema asociado al user-----------------
USE Northwind GO
CREATE SCHEMA Curso AUTHORIZATION UserInformatica ; GO

 
---------------------------------Cree el esquema asociado al user-----------------
create schema Informatica authorization UserInformatica 
Go
---------------------Dar permisos de creacion de tabla al usuario---------------------
grant create table to UserInformatica 
go 
--revisar el usuario actual
Select user

execute as user = 'UserInformatica' 
go 

create table Empleado
(
codigo int, nombre varchar(100)
) 
go 

revert 
go 

