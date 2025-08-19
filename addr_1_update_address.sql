Delimiter $$
Create procedure update_addresses(p_id int, p_iind_id int, p_sno int, p_sn1 text, p_sn2 text, p_ccode int, p_scode char(2), p_zip int)
Begin
	insert into addr_1(ID,CITY_CODE,STATE_CODE,IIND_ID,STREET_NUMBER,STREET_NAME_1,STREET_NAME_2, ZIP) 
    values(p_id,p_ccode,p_scode,p_iind_id,p_sno,p_sn1,p_sn2,p_zip);    
end$$
Delimiter ;

drop procedure update_addresses;

call update_addresses(28932,99999999,25,"Burly Avenue","Scoktsgen Rd",2313,"IL",80339);
