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
