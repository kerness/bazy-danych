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
	-- sometimes one product has more than one record
	select sum(quantity)
	into _quantity
	from production.productinventory 
	join production.product p2 on p2.productid = production.productinventory.productid
	where p2.productid = _id;

	raise notice 'id:% number:% quantity:%', _id, _number, _quantity;
end; $$;

call productinfo(cast('Spokes' as name)) 

-- multiple records about one product
select quantity from production.productinventory p where p.productid = 527
select SUM(quantity) from production.productinventory p where p.productid = 527
