drop table Salespeople;
CREATE TABLE Salespeople (snum int primary key, Sname char(2048),City char(2048),Comm decimal (8,2));
DESCRIBE TABLE Salespeople;

insert into Salespeople values 
(1001,'Peel','London',.12),
(1002,'Serres','San Jose',.13),
(1004,'Motika','London',.11),
(1007,'Rifkin','Barcelona ',.15),
(1003,'AxelRod','New York',.10),
(1005,'Fran','London',.26);
select * from Salespeople;


drop table customers;
CREATE TABLE customers (cnum int primary key, cname char(2048),City char(2048) not null,rating char(2048),Snum int,
constraint Snum_fk foreign key (snum) references salespeople(snum));
DESCRIBE TABLE customers;

insert into customers values 
(2001,'Hoffman','London',100,1001),
(2002,'Giovani','Rome',200,1003),
(2003,'Lui','San Jose',200,1002),
(2004,'Grass','Berlin',300,1002),
(2006,'Clemens','London',100,1001),
(2007,'Cisneros','San Jose',300,1007),
(2008,'Pereira','Rome',100,1004);

select * from customers;


drop table orders;
CREATE TABLE orders (onum int, amt decimal(7,2),Odate date,cnum int,
constraint cnum_fk foreign key (cnum) references customers(cnum),snum int,
constraint snum_fk foreign key (snum) references Salespeople(snum));
DESCRIBE TABLE orders;

insert into orders values 
(3001,18.69,'1996-03-10',2008,1007),
 (3003,767.19,'1996-03-10',2001,1001),
(3002,1900.10,'1996-03-10',2007,1004),
(3005,5160.45,'1996-03-10',2003,1002),
(3006,1098.16,'1996-03-10',2008,1007),
(3009,1713.23,'1996-04-10',2002,1003),
(3007,75.75,'1996-04-10',2002,1003),
(3008,4723.00,'1996-05-10',2006,1001),
(3010,1309.95,'1996-06-10',2004,1002),
(3011,9891.88,'1996-03-10',2006,1001); 

select * from orders;


--1--List all the columns of the Salespeople table. 
Describe table salespeople;    


--2--List all customers with a rating of 100.
select cnum,cname,rating from Customers 
where Rating = 100; 

--3--Find all records in the Customer table with NULL values in the city column. 
select * from Customers 
where city is null;


--4--Find the largest order taken by each salesperson on each date. 
SELECT odate,MAX(AMT) FROM orders GROUP BY odate;



--5--Arrange the Orders table by descending customer number. 
select * from orders order by cnum desc;


--6--Find which salespeople currently have orders in the Orders table.
SELECT s.sname,o.snum FROM Salespeople s inner join orders o on s.snum = o.snum group by o.snum,s.sname order by o.snum;


--7--List names of all customers matched with the salespeople serving them. 
SELECT c.cnum,c.cname,s.sname FROM customers c inner join Salespeople s on c.snum = s.snum;

--8--Find the names and numbers of all salespeople who had more than one customer.
SELECT s.sname,c.Snum,count (c.snum) FROM customers c inner join Salespeople s on c.snum = s.snum GROUP BY c.snum,s.Sname HAVING count(c.snum) > 1;

--9--Count the orders of each of the salespeople and output the results in descending order. 
SELECT s.snum,s.Sname,count(s.snum) FROM Salespeople s inner join orders o on s.snum = o.snum group by s.snum,s.sname order by count(s.Snum) DESC;

