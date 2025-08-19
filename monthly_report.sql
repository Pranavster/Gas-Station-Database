# Monthly report
# from_year_month to_year_month
# aggregate sales for every month 
# ie 1 - 9 aggregate and return
drop procedure pr_monthly_report;
delimiter $$
create procedure pr_monthly_report(from_year_month varchar(7), to_year_month varchar(7))
begin
	
	#if the format is not ####-## signal sqlstate '45000' set messagetext = YEAR MONTH IN WRONG FORMAT
    # if the 1st 4 characters in from_year_month and to_year_month and the last 2 characters are non numeric AND the 5th position is NOT - then 
    declare v_from_year_month date;
	declare v_to_year_month date;
    
    if( REGEXP_INSTR(substring(from_year_month,1,4),'[^0-9]') != 0 
    or REGEXP_INSTR(substring(from_year_month,5,1),'[^-]') != 0 
    or REGEXP_INSTR(substring(from_year_month,6,2),'[^0-9]') != 0) then 
		signal sqlstate '45000' set message_text = "from_year_month in WRONG FORMAT";
	end if;
    if (REGEXP_INSTR(substring(to_year_month,1,4),'[^0-9]') != 0 
    or REGEXP_INSTR(substring(to_year_month,5,1),'[^-]') != 0 
    or REGEXP_INSTR(substring(to_year_month,6,2),'[^0-9]') != 0) then
		signal sqlstate '45000' set message_text = "to_year_month in WRONG FORMAT";
	end if;
    -- select date_format(str_to_date(Created_Time, '%d/%m/%Y'), '%Y-%m-%d') as Date from VarcharToDate;

	set v_from_year_month = date_format(concat(from_year_month,"-01"), '%Y-%m-%d');
	set v_to_year_month = date_format(concat(to_year_month,"-01"),'%Y-%m-%d');#add month subtract day
    select v_from_year_month,v_to_year_month;
    set v_to_year_month = date_add(v_to_year_month, interval 1 month);
    set v_to_year_month = date_sub(v_to_year_month, interval 1 day);
    
    select from_year_month, v_to_year_month;
    
	select s.*, p.prod_name, p.prod_type from sales s join product p on s.prod_id = p.prod_id where (p.addwhen >= from_year_month and p.addwhen <= v_to_year_month);
end$$
delimiter ;