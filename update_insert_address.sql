select * from addr_1;
drop procedure update_insert_addresses;-- (18981,289,"IL",89828982,456,"Garage","Marcus",78896);

delimiter $$
create procedure addr.update_insert_addresses(p_id int, p_ccode int, p_scode text, p_iind_id int, p_sno int, p_sn1 text, p_sn2 text, p_zip int)
begin
	
	Declare v_state int;
    Declare v_zip int;
	if (p_ccode is NULL and p_scode is NULL and p_iind_id is NULL and p_sno is NULL and p_sn1 is NULL and p_sn2 is NULL and p_zip is NULL) then
		select STATE_CODE,zip into v_state,v_zip from addr_1 where ID = p_id;
		delete from addr_1 where ID = p_id;
        call addr_zip_count(v_zip,-1);
        call addr_state_count(v_state,-1);
	else
		if exists(select ID from addr_1 where ID = p_id) then
			update addr_1 set CITY_CODE = p_ccode, STATE_CODE = p_scode, IIND_ID = p_iind_id, STREET_NUMBER = p_sno, Street_Name_1 = p_sn1, Street_name_2 = p_sn2, Zip = p_zip where ID = p_id;
            call addr_zip_count(p_zip,1);
            call addr_state_count(p_scode,1);
		else
			insert into addr_1(ID,CITY_CODE,STATE_CODE,IIND_ID,STREET_NUMBER,Street_Name_1,Street_name_2,Zip) values(p_id, p_ccode, p_scode, p_iind_id, p_sno, p_sn1, p_sn2, p_zip);
		end if;
	end if;
end$$
delimiter ;

call addr.update_insert_addresses(30292,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
Create table zip_count(zip int, zip_count int);

delimiter $$
create procedure addr.addr_zip_count(p_zip int, p_count int)#checks existence of zip code if exists
begin
	if exists(select * from zip_count where zip = p_zip) then
		update zip_count set zip_count = zip_count + p_count where zip = p_zip;
	else
		insert into zip_count(zip,zip_count) values(p_zip,p_count);
	end if;
end$$
delimiter ;
create table state_count(state text,state_count int)

delimiter $$
create procedure addr.addr_state_count(p_state text, p_count int)
begin
	if exists(select * from state_count where state = p_state) then
		update state_count set state_count = state_count + p_count where state = p_state;
	else
		insert into state_count(state,state_count) values(p_state,p_count);
	end if;
end$$
delimiter ;
drop procedure addr_zip_count;
drop procedure addr_state_count;
call addr_zip_count(60462,1);
call addr_state_count("CA",-1);

select * from state_count;
select * from zip_count;

call addr.update_insert_addresses(18981,NULL,NULL,89828982,456,"Garage","Marcus",78896)


select * from addr_1 where ID = 18981;


