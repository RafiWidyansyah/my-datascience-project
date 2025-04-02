use techcorp;
select * from Customers;
select * from Employees;
select * from OrderDetails;
select * from Orders;
select * from Products;
select * from SupportTickets;

-- 1. Top 3 Customers Based On Total Amount Orders --
select c.first_name, c.last_name, sum(o.total_amount) total_amount_orders
from Customers c
join Orders o on o.customer_id = c.customer_id
group by c.customer_id
order by total_amount_orders desc
limit 3;

-- 2. Average Amount Order for Each Customer --
select c.first_name, c.last_name , avg(o.total_amount) average_amount_order
from Customers c
join Orders o on o.customer_id = c.customer_id
group by c.customer_id;

-- 3. Employee had resolved > 4 tickets support --
select e.first_name, e.last_name, count(ticket_id) total_ticket
from Employees e
join SupportTickets s on s.employee_id = e.employee_id
where s.status = "resolved"
group by e.employee_id
having total_ticket > 4;

-- 4. Product had order yet --
select p.product_name
from Products p
left join OrderDetails o on o.product_id = p.product_id
where o.order_id is null;

-- 5. Revenue --
select p.product_name, od.quantity*unit_price revenue
from Products p
join OrderDetails od on od.product_id = p.product_id
;

-- 6. Average Price Each Product Category & Product Category with avg price > 500 --
with avg_price_cat as(
		select category, avg(price) avg_price
        from Products
        group by category
)
select *
from avg_price_cat
where avg_price > 500;

-- 7. Customers Total Amount Order > 500 (Min. 1 Order)
select *
from Customers
where customer_id in (
		select customer_id
        from orders
        where total_amount > 500)
;

-- 8. Category product with revenue more than average revenue for all category product --
with cat_revenue as (
		select p.category, od.quantity*od.unit_price as revenue
        from products p
        join OrderDetails od on od.product_id = p.product_id
)
select *
from cat_revenue
#where revenue > avg(revenue)
#group by category
;

-- 9. Most Issues on the Orders --
select issue, count(distinct(issue)) frequency
from SupportTickets
group by issue;

-- 10. How long product need to be resolved --
select created_at, resolved_at, timestampdiff(day,resolved_at,created_at) duration_day
from SupportTickets
where resolved_at is not null
order by duration_day desc
;

-- 11. What date has the most order --
select o.order_date, count(od.order_id) total_order
from Orders o
join OrderDetails od on od.order_id = o.order_id
group by o.order_date
order by total_order desc
;