-- TODO 4 and 7


-- 1.
--https://www.postgresqltutorial.com/plpgsql-function-returns-a-table/

create or replace function avgRateInfoo()
returns table (
	person_firstname Name,
	person_lastname Name,
	person_rate numeric
)
language plpgsql
as $$
declare
	_avgRate numeric;
	_i record;
begin
	
	-- get AVG rate
	select AVG(rate)
	into _avgRate
	from humanresources.employeepayhistory;
	raise notice 'avgRate: %', _avgRate;
	-- insert data to table which will be returned
	for _i in (
		select firstname, lastname, rate 
		from person.person
   		join humanresources.employeepayhistory e on  e.businessentityid = person.person.businessentityid
   		where rate < _avgRate
	)loop
		person_firstname := _i.firstname;
		person_lastname := _i.lastname;
		person_rate := _i.rate;
		return next;
	end loop;
end; $$;

select * from avgRateInfoo();


--2. Przyjmuje ID zamówienia ma zwracać datę zamówienia

create or replace function getOrderDate(_orderID int)
returns timestamp
language plpgsql
as $$
declare 
	_orderDate timestamp;
begin 
	select orderdate
	into _orderDate
	from purchasing.purchaseorderheader
	where purchaseorderid = _orderID;
	
	return _orderDate;
end;
$$;

select getOrderDate(1);


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




-- 4. przyjmuje id zamówienia zwraca numer karty NIE MAM

create or replace function getCardNumber(_orderID int)
returns timestamp
language plpgsql
as $$
declare 
	_cardNumber varchar(25);
begin
	
	
	select cardnumber, p.businessentityid, p2.name
	--into _cardNumber
	from sales.creditcard c
	join sales.personcreditcard p on p.creditcardid = c.creditcardid
	join person.person p2 on p2.businessentityid = p.businessentityid 
	where purchaseorderid = _orderID;
	
	return _cardNumber;
end;
$$;

select getCardNumber(1);



-- 5. returns division result + exception handling

create or replace procedure divide(_num1 float, _num2 float)
language plpgsql as $$
declare
	_result float;	
begin
	
	if _num1 < _num2 then
		raise exception using errcode = 'WRDAT';
	end if;
	
	_result = _num1 / _num2;
	raise notice 'Division result: %', _result;
end

$$;

do
$$
begin
	call divide(100,50);

	exception
		when sqlstate 'WRDAT' then
		raise warning 'num2 is greater than num1';
end;
$$
language plpgsql;


-- 6. returns leave days count

create or replace function leaveDaysCount(_nationalIdNumber varchar(15))
returns float
language plpgsql
as $$
declare 
	_vacationHours int;
	_sickLeaveHours int;
	_leaveDays float;
begin 
	select vacationhours
	into _vacationHours
	from humanresources.employee
	where nationalidnumber = _nationalIdNumber;

	select sickleavehours
	into _sickLeaveHours
	from humanresources.employee
	where nationalidnumber = _nationalIdNumber;
	
	_leaveDays = (_sickLeaveHours::float / 24) + (_vacationHours::float / 24);
	
	return _leaveDays;
end;
$$;

select leaveDaysCount('509647174');





