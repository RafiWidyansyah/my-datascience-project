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

