create table supply_order_product(or_id int
, prod_id int
, rate decimal(5,2)
, order_qty int
, order_value int
, delivery_qty int
, delivery_date date
, delivery_value int
, status_ text
, primary key (or_id,prod_id) # 4 same order and product can't be the same line
, foreign key (or_id) references supply_order(or_id)
, foreign key (prod_id) references product(prod_id) );
