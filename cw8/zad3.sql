-- 3.Utwórz procedurę składowaną, która jako parametr przyjmuję nazwę produktu, a jako rezultat wyświetla jego identyfikator, numer i dostępność.

create or replace procedure productInfo (productName name)
language plpgsql as $$ 
declare 
	_id int;
	_number varchar(25);
	_quantity int;
begin
	select productid
	into _id
	from production.product where production.product.name = productName;

	select productnumber
	into _number
	from production.product where production.product.name = productName;

	select sum(quantity)
	into _quantity
	from production.productinventory 
	join production.product p2 on p2.productid = production.productinventory.productid
	where p2.productid = _id;

	raise notice 'name:% number:% quantity:%', _id, _number, _quantity;
end; $$;

call productinfo(cast('Spokes' as name)) 

	select productid, name, productnumber 
	from production.product where production.product.name = cast('Spokes' as name);

select quantity from production.productinventory p where p.productid = 527
-- bo czasem jest więcej wpisów o tym samym id produktu
select SUM(quantity) from production.productinventory p where p.productid = 527
