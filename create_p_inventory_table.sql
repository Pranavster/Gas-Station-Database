create table inventory(prod_id int
, curr_quantity int
, max_quantity int
, min_quantity int
, entered_date datetime
, asof_date datetime
, primary key(prod_id, asof_date) );