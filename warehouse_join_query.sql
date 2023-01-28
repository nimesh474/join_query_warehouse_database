-- create database
create database warehouse;

/* 1. create a table named Laptop to store the details of laptop.
	The table should contain the columns Brand, Model, unit_price, bought_date.
*/
create table laptop(
	id int primary key identity(1,1),
	brand varchar(50) not null,
	model varchar(50) not null constraint model_unique unique(model),
	unit_price decimal(10,2) constraint price_check check(unit_price>0),
	bought_date date default getdate()
);

-- insert data in laptop table
insert into laptop(brand, model, unit_price, bought_date)
values('Dell', 'XPS 13 9310', 150990, '2020-09-28'),
('Dell', 'G3 15 3500', 73990, '2020-07-23'),
('Dell', 'G5 15 5500', 8259090, '2020-07-23'),
('Dell', 'Alianware 17 R5', 320000, '05-17-2020'),
('Dell', 'Alianware 15 R1', 280000, '05-17-2020'),
('Apple', 'MacBook Air M1', 92900, '2020-11-02'),
('Apple', 'MacBook Pro', 179800, '2020-11-02'),
('HP', 'ProBook 11 G3 EE', 47000, '2021-01-23');


-- Show the brand of maximum priced laptop 
select brand, max(unit_price)Price from laptop
	group by brand
	order by price desc;

-- show the laptop whose minimum price is less than equals to 50,000
select brand, model, min(unit_price)Price from laptop
	group by brand, model
	having min(unit_price)<=50000
	order by model;

-- show the laptop's brand having minimum price greater than 40,000
select brand, min(unit_price)Price from laptop
	group by brand
	having min(unit_price)>=40000
	order by price desc;

-- show the average price of the laptop brand having price greater than 50,000
select brand, avg(unit_price)Price from laptop
	group by brand
	having avg(unit_price)>50000
	order by price desc;

-- show the number of brands available
select brand, count(id)counting from laptop
	group by brand
	order by counting desc;




/* 1. create a table named shipment to store the details of shipped laptop.
	The table should contain the columns LaptopID(FK referencing the PK of Laptop table),
	country, shipping date, shipping charges.
*/
create table shipment(
	ship_id int primary key identity(1,1),
	laptopID int not null,
	country varchar(20),
	shipping_date date not null,
	shipping_Charge decimal(10,2) not null,
	constraint laptop_FK foreign key(laptopID) references laptop(id)
);

-- insert some data
insert into shipment(laptopID, country, shipping_date, shipping_charge)
values(1, 'Nepal', '2020-10-15', 5000.60),
(1, 'India', '2020-08-10', 7000.50),
(2, 'China', '2020-09-10', 10000),
(5, 'Nepal', '2020-05-30', 9000),
(8, 'Nepal', '2021-02-05', 3000);

-- show the list of brands that have already been shipped.
select p.brand, p.bought_date, s.shipping_date from laptop p
	inner join shipment s
	on p.id=s.laptopID

-- show the list of brands and the countries that are shipped to. 
-- If the laptops are not shipped yet, show "not shipped yet".
select l.brand, l.bought_date, s.country,
	isnull(convert(varchar(20),s.shipping_date,120),'not shipped yet')shipping_date
	from laptop as l
	full join shipment as s
	on l.id=s.laptopID

select * from shipment;
select * from laptop;