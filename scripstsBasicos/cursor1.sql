use Northwind;

Declare @codigo varchar(5),@compania varchar(200),
@contacto varchar(150),@pais varchar(100)
Declare ccustomers cursor GLOBAL
	for Select customerid, companyname, contactname
	, country from customers
Open ccustomers
fetch ccustomers into @codigo, @compania, @contacto,@pais
while(@@FETCH_STATUS=0)
	begin
	print @codigo +' '+ @compania +' '+ @contacto +' '+@pais
	fetch ccustomers into @codigo, @compania, @contacto,
	@pais
	end
close ccustomers
deallocate ccustomers
