create table customer(cs_id int
, cs_name varchar(50)
, bill_addr varchar(50)
, ship_addr varchar(50)
, primary key (cs_id));

create table sales_order(cs_id int
, or_id int
, order_date date
, shipping_date date
, order_status varchar(50)
, primary key (or_id)
, foreign key (cs_id) references customer(cs_id));

