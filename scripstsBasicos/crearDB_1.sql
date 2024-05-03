-- CREAR BASE DE DATOS
Create database Empresa 
on Primary
(name=EmpresaPrimary, filename='C:\Data\Empresa.mdf'
, size=50MB, filegrowth=25%)
log on
(name=EmpresaLog, filename='C:\Data\EmpresaLog.ldf'
, size=25MB, filegrowth=25%)
GO

Alter Database Empresa
add filegroup Produccion
go

Alter Database Empresa
add file (name=EmpresaProduccion, filename='C:\Data\EmpresaProduccion.ndf'
, size=50MB, filegrowth=25%) to filegroup Produccion
go