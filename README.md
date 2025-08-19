# Gas-Station-Database
This schema involves various triggers, stored procedures, cursors on a gas station database including tables for customers, orders, and sales.
___________________________________________________________
## CRUD procedures
Many of the procedures in this database inserted, updated, and deleted rows from tables based on whether or not non-primary keys existed in the table for a given primary key.
Generally, they included parameters for each of the fields in the table, and initially checked if the only entries in a row were primary keys, and if so, that row would be deleted.
If there were other values for a row given a primary key, then the row would be updated with new parameters; otherwise, the values of the parameters would be inserted into the table.
_____________________________________________________________
## Example of Cursors
Cursors were used to iterate through entire tables and fetch the largest values.
_____________________________________________________________

## How to access this database
1:Download the files contained in this repo <br>
2:Create a schema in mysql, and upload all files to the database as mysql -u USER -p schema_name < File_name.
