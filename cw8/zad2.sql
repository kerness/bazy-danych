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