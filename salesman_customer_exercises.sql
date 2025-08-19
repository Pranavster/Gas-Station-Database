desc employee;
select * from employee;
select * from project;
select * from employee e join project p on e.EmpID = p.empID;

select Employee.empID, Employee.EmpFname, Employee.EmpLname, Project.ProjectID, Project.ProjectName
from Employee
inner join project on Employee.EmpID=Project.EmpID;

Select Employee.EmpFname, Employee.EmpLname, Project.ProjectID, Project.ProjectName 
FROM Employee
LEFT JOIN Project On Employee.EmpID=Project.EmpID;

-- EmpFname 

create table salesman(salesman_id decimal, name_ varchar(50),city varchar(50),commision decimal(5,2), primary key (salesman_id));
insert into salesman(salesman_id, name_, city, commision) values(5001,'James Hood','New York',.15),(5002,'Nail Knite','Paris',.13),(5005,'Pit Alex', 'London',.11),(5006,'Mc Lyon', 'Paris', .14),(5007,'Paul Adam','Rome',.13),(5003,'Lauson Hen','San Jose',.12);
create table customer(customer_id int, cust_name varchar(50),city varchar(50),grade int, salesman_id int);
insert into customer(customer_id, cust_name, city, grade, salesman_id) values(3002, 'Nick Rimando','New York',100,5001),
(3007,'Brad Davis','New York',200,5001),(3005,'Graham Zusi','California',200,5002),(3008,'Julian Green','London',300,5002),
(3004,'Fabian Johnson','Paris',300,5006),(3009,'Geoff Cameron','Berlin',100,5003),(3003,'Jozy Altidor','Moscow',200,5007),(3001,'Brad Guzan','London',null,5005);
-- select salesman.name_ s,c.cust_name,c.city from salesman s join customer c on s.city = c.city;
select s.name_ as Salesman,c.cust_name,c.city from salesman s, customer c where s.city = c.city;


