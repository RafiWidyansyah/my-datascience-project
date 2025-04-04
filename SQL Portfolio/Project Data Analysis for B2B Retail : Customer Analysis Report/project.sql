-- Understand Table --
select * from orders_1 limit 5;

select * from orders_2 limit 5;

select * from customer limit 5;

-- Total Sales and Revenue for Quarter-1 (Jan-Mar) and Quarter-2 (Apr-Jun) --
## Quarter-1
SELECT SUM(quantity) AS total_penjualan, SUM(priceEach * quantity) as revenue 
FROM orders_1 
WHERE status = "Shipped";
## Quarter-2
SELECT SUM(quantity) AS total_penjualan, SUM(priceEach * quantity) as revenue
FROM orders_2 
WHERE status = "Shipped";

-- Total Sales Percentage --
select tabel_a.quarter, sum(tabel_a.quantity) as total_penjualan, sum(tabel_a.quantity*tabel_a.priceeach) as revenue
from (select orderNumber, status, quantity, priceeach , 1 as quarter from orders_1
			union
			select orderNumber, status, quantity, priceeach, 2 as quarter from orders_2) as tabel_a
where status = 'Shipped'
group by 1;

-- is xyz.com gain more customers? --
select tabel_b.quarter, count(distinct tabel_b.customerID) as total_customers
from (select customerID, createDate, quarter(createDate) as quarter
	    from customer
	    where createDate between '2004-01-01' and '2004-06-30') as tabel_b
group by 1;

-- How many customers already make transaction? --
select tabel_b.quarter, count(distinct tabel_b.customerID) as total_customers
from (select customerID, createDate, quarter(createDate) as quarter
	    from customer
	    where createDate between '2004-01-01' and '2004-06-30') as tabel_b
where customerID in (select distinct customerID
				             from orders_1
				             union
				             select distinct customerID
				             from orders_2)
group by 1;

-- The most order of product category in Quarter-2 --
SELECT * 
FROM (SELECT categoryID, COUNT(DISTINCT orderNumber) AS total_order, SUM(quantity) AS total_penjualan
      FROM (SELECT productCode, orderNumber, quantity, status, LEFT(productCode,3) AS categoryID
	          FROM orders_2
	          WHERE status = "Shipped") tabel_c
      GROUP BY categoryID) a 
ORDER BY total_order DESC;

-- How many customers make a transaction after their first transaction  --
-- count unique customer in quarter 1 --
SELECT COUNT(DISTINCT customerID) as total_customers FROM orders_1;
-- output : 25
select 1 as quarter, (count(distinct customerID)*100)/25 as Q2
from orders_1
where customerID in(select distinct customerID
				            from orders_2);
