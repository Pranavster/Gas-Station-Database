SELECT REGEXP_INSTR("abc", '^[0-9]');
SELECT REGEXP_INSTR("781", '^[0-9]');
SELECT REGEXP_INSTR("!@#", '^[0-9]') = 0;
select regexp_instr("8234567890", '[^0-9]');


select * from gas_stn.supply_order;

desc gas_stn.supply_order;