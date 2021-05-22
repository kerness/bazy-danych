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