Create table cliente(
codigoCliente int identity(1,1) not null primary key,
nombre varchar(150),
dirección varchar(300),
telefono varchar(20),
email varchar(40),
fechanacimiento date,
)
go
