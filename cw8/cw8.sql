
-- 1.
-- https://www.postgresqltutorial.com/plpgsql-function-returns-a-table/
-- https://www.postgresql.org/docs/9.1/plpgsql-control-structures.html
-- using looping through query results
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


-- 4. przyjmuje id zamówienia zwraca numer karty
-- https://dataedo.com/samples/html/AdventureWorks/doc/AdventureWorks_2/modules/Sales_12/module.html

create or replace function getCardNumber(_orderId int)
returns varchar(25)
language plpgsql
as $$
declare 
	_creditCardId int;
	_cardNumber varchar(25);
begin
	-- get credit card id
	select creditcardid 
	into _creditCardId
	from sales.salesorderheader s 
	join sales.customer c on c.customerid = s.customerid
	where s.salesorderid = _orderId;
	
	-- get card number
	select cardnumber
	into _cardNumber
	from sales.creditcard c 
	where c.creditcardid = _creditCardId;

	return _cardNumber;
end;
$$;


select getCardNumber(43785);


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

-- 7

-- co sie bedzie działo jak nie ma kursy dla danej daty? 

create or replace procedure currencyConverter(
	_from bpchar(3), 
	_to bpchar(3), 
	_ammount float,
	_date timestamp
	)
language plpgsql as $$
declare
	_currencyToSelect bpchar(3);
	_rate numeric;
	_reversedRate float;
	_result float :=1;
begin
	
	-- throw exception when _from or _to isn't USD
	if (_from <> 'USD') and (_to <> 'USD') then  	
		raise exception using errcode = 'WRCUR'; -- wrong currency
	end if;
	
	-- get currency rate and make sure to always select correct value from database
	if _from <> 'USD' then
		_currencyToSelect = _from;
	else
		_currencyToSelect = _to;
	end if;

	raise notice E'\nSELECTING: % rate from database', _currencyToSelect;
	-- queray database
	select averagerate
	into _rate
	from sales.currencyrate c 
	where c.tocurrencycode = _currencyToSelect and c.currencyratedate = _date;

	-- make sure if the _rate is null - no currency rate for specified date?
	if _rate is null then  	
		raise exception using errcode = 'RNULL'; -- rate null
	end if;

	-- currency conversion
	
	-- convert from USD to other
	if _from = 'USD' then
		raise notice 'CONVERTING from USD to %', _to;
		raise notice 'USD to % rate is %', _to, _rate;
		_result = _ammount * _rate;
	else
		-- convert from other to USD
		raise notice 'CONVERTING from % to USD', _from;
		-- reverse rate
		--raise notice 'rate before reversion is %', _rate;
		_reversedRate = _rate::float;
		_rate = 1::float/_rate;
		raise notice '% to USD rate is %',_from, round(_rate::numeric, 4);
		_result = _ammount * _rate;
	end if;
	
	-- write output
	raise notice 'Value before conversion: %', _ammount;
	raise notice E'Conversion result: %\n', to_char(_result, '999.99');
end
$$;

do
$$
begin
call currencyConverter('USD', 'BRL', 54, '2012-06-29 00:00:00'); 
call currencyConverter('BRL', 'USD', 54, '2012-06-29 00:00:00'); 
call currencyConverter('ZYX', 'XYZ', 54, '2012-06-29 00:00:00'); 
call currencyConverter('USD', 'BRL', 54, '2077-01-01 00:00:00'); 
	exception
		when sqlstate 'WRCUR' then
			raise warning 'unsupported conversion. one of the inputs must be USD';
		when sqlstate 'RNULL' then
					raise warning 'rate variable is NULL. Maybe check other date?';

end;
$$
language plpgsql;

