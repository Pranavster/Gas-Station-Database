create table supplier(su_id int
, su_name varchar(50)
, su_addr varchar(50)
, su_email varchar(50)
, su_phone bigint
, eff_date date
, exp_date date
, Primary key (su_id));

insert into supplier values(1,"Pranav","13279 s ave","pmadan1@hawk.iit.edu",2893822229,"2025-02-14","2025-06-17");
drop procedure p_supplier;
delimiter $$
create procedure p_supplier(p_suid int, p_suname varchar(50), p_suaddr varchar(50), p_suemail varchar(50), p_suphone bigint, p_effdate date, p_expdate date)
begin
	if(p_suname is NULL and p_suaddr is NULL and p_suemail is NULL and p_suphone is NULL and p_effdate is NULL and p_expdate is NULL) then
		delete from supplier where su_id = p_suid;
	else
		if exists(select * from supplier where su_id = p_suid) then
			update supplier set su_name = p_suname, su_addr = p_suaddr, su_email = p_suemail, su_phone = p_suphone, eff_date = p_effdate, exp_date = p_expdate;
		else
			insert into supplier(su_id,su_name,su_addr,su_email,su_phone,eff_date,exp_date) values(p_suid,p_suname,p_suaddr,p_suemail,p_suphone,p_effdate,p_expdate);
		end if;
	end if;
end$$
delimiter ;

call p_supplier(1,"Pranav","13279 s ave","pmadan1@hawk.iit.edu",2893822229,"2025-02-14","2025-06-17");
call p_supplier(2,"Ryan","13289 s ave","ryan@hawk.iit.edu",7367373384,"2025-03-14","2025-06-17");
call p_supplier(3,"Adam","13299 s ave","adam@hawk.iit.edu",2182424852,"2025-05-14","2025-06-17");
call p_supplier(4,"Tim","13309 s ave","tim@hawk.iit.edu",1234566789,"2025-02-15","2025-06-17");
call p_supplier(5,"Sumanth","13279 s ave","sumanth@hawk.iit.edu",3849527592,"2024-02-14","2025-06-17");
call p_supplier(6,"Krishnan","13289 s ave","krishnan@hawk.iit.edu",3894839583,"2025-01-14","2025-06-17");
call p_supplier(7,"Eddie","13279 s ave","eddie@hawk.iit.edu",39573828573,"2025-05-14","2025-06-17");
call p_supplier(8,"Ashok","13289 s ave","ashok@hawk.iit.edu",9502759216,"2025-06-14","2025-06-17");
call p_supplier(9,"Naren","13279 s ave","naren@hawk.iit.edu",3850284950,"2025-01-19","2025-06-17");
call p_supplier(10,"Geetha","13289 s ave","geetha@hawk.iit.edu",5647382910,"2025-01-24","2025-06-17");
select * from supplier;
delete from supplier where su_email like "%@%";

