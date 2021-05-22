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