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