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