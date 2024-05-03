Create table clientes(
codigoCliente int identity(1,1) not null primary key,
nombre varchar(150),
dirección varchar(300),
email varchar(40),
fechanacimiento date,
edad int,
constraint ck_edad check (edad<18)
)
go


insert into clientes(nombre, dirección, email, edad) values
('byron calderon', 'santa martha', 'coso@gmail.com', 17)


insert into clientes(nombre, dirección, email, edad) values
('jose perez', 'santa martha', 'coso1@gmail.com', 21)

select * from clientes;