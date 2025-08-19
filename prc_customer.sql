
create table email_identifiers(identifiers varchar(10));
insert into email_identifiers(identifiers) values(".edu");
insert into email_identifiers(identifiers) values(".gov");
insert into email_identifiers(identifiers) values(".com");
insert into email_identifiers(identifiers) values(".org");
insert into email_identifiers(identifiers) values(".net");
delimiter $$
create procedure prc_customer(p_csid int, p_csname varchar(50), p_billaddr varchar(50), p_shipaddr varchar(50), p_email varchar(50), p_phoneno bigint) 
begin
	if regexp_instr(p_email,"@") = 0 then
		select "Email must have @ symbol";
	elseif regexp_instr(p_email, ".com") = 0 and regexp_instr(p_email, ".edu") = 0 and regexp_instr(p_email, ".gov") = 0 then
		select "Email must have company identifier at the end";
	end if;
	if regexp_instr(p_phoneno, '[^0-9]') > 0 then
		select concat("Phone number ", p_phoneno, " is invalid");
	else
		if (p_csname is NULL and p_billaddr is NULL and p_shipaddr is NULL and p_email is NULL and p_phoneno is NULL) then
			delete from customer where cs_id = p_csid;
		else
			if exists(select * from customer where cs_id = p_csid) then
				update customer set cs_name = p_csname, bill_addr = p_billaddr, ship_addr = p_shipaddr, email = p_email, phone_no = p_phoneno where cs_id = p_csid;
			else 
				insert into customer(cs_id, cs_name, bill_addr, ship_addr, email, phone_no) values(p_csid, p_csname, p_billaddr, p_shipaddr, email, phone_no);
			end if;
		end if;
	end if;
end$$
delimiter ;
delimiter $$

select regexp_instr("fredskink@8.com", ".com");

call prc_customer(1,"Fred","1 abc st","1 abc street", "fredskink@8.com", 8234567890);
call prc_customer(2,"Ryan","2 abc road","2 abc road", "ryan@1.com", 1234567899);
call prc_customer(3,"Jacob","3 abc street","3 abc street", NULL, 1234567899);
call prc_customer(4,"Will","4 abc avenue","4 abc avenue", NULL, 7089710138);
call prc_customer(5,"Bill","5 abc street","5 abc street", NULL, 2313432922);
call prc_customer(6,"Jacob","6 abc street","6 abc street", NULL, 2313432922);
call prc_customer(7,"Angela","7 abc street","7 abc street", NULL, 2313432922);
call prc_customer(8,"Peter","8 abc street","8 abc street", NULL, 2313432922);
call prc_customer(9,"Pranav","9 abc street","9 abc street", NULL, 2313432922);
call prc_customer(10,"Madan","10 abc street","10 abc street", NULL, 2313432922);

select * from customer;
# populate order table check if cs_id exists in customer else reject

select * from email_identifiers
