-- Top 5 buyer with highest total amount --
select buyer_id, nama_user, sum(total) as total_amount
from orders
join users on orders.buyer_id = users.user_id
group by 1, 2
order by 3 desc
limit 5;

-- Top 5 Frequent Buyer --
select buyer_id, nama_user, count(order_id) as total_transaction
from orders
join users on orders.buyer_id = users.user_id
where discount = 0
group by 1, 2
order by 3 desc
limit 5;

-- Big Frequent Buyer in 2020 (Min. 1 Transaction and average total amount >= 1000000) --
select buyer_id, email, average, month_count
from (select trx.buyer_id, average, jumlah_order, month_count
		from (select buyer_id, round(avg(total),2) average from orders
		      where date_format(created_at, '%Y') = '2020'
                      group by 1
                      having average > 1000000
                      order by 1) trx
		join (select buyer_id, count(order_id) as jumlah_order, count(distinct date_format(created_at, '%M')) month_count
		      from orders
                      where date_format(created_at, '%Y') = '2020'
                      group by 1
                      having month_count >= 5 and jumlah_order >= month_count
                      order by 1) months
on trx.buyer_id = months.buyer_id) bfq
join users on buyer_id = user_id;

-- Top 5 Product in December 2019 --
select sum(quantity) total_qty, desc_product
from order_details a
join products b
on a.product_id = b.product_id
join orders c
on a.order_id = c.order_id
where created_at between '2019-12-01' and '2019-12-31'
group by 2
order by 1 desc
limit 5;

-- Top 10 highest transaction from user = 12476 --
select seller_id, buyer_id, total as nilai_transaksi, created_at as tanggal_transaksi
from orders
where buyer_id = 12476
order by 3 desc
limit 10;

-- Transaction Summary per Month in 2020 --
select EXTRACT(YEAR_MONTH FROM created_at) as tahun_bulan, count(1) as jumlah_transaksi, sum(total) as total_nilai_transaksi
from orders
where created_at >='2020-01-01'
group by 1
order by 1;

-- Top 10 Customers with Highest Average Transaction Amount in January 2020 --
select buyer_id, count(1) as jumlah_transaksi, avg(total) as avg_nilai_transaksi
from orders
where created_at >='2020-01-01' and created_at<'2020-02-01'
group by 1
having count(1)>= 2 
order by 3 desc
limit 10;

-- List of High Transaction Amount in December 2019 --
select nama_user as nama_pembeli, total as nilai_transaksi, created_at as tanggal_transaksi
from orders
inner join users on buyer_id = user_id
where created_at >='2019-12-01' and created_at < '2020-01-01'
and total >= 20000000
order by 1;

-- Top 5 Product Category by Quantity in 2020 --
select category, sum(quantity) as total_quantity, sum(price) as total_price
from orders
inner join order_details using(order_id)
inner join products using(product_id)
where created_at>='2020-01-01'
and delivery_at is not null
group by 1
order by 2 desc
limit 5;

-- Customers with High Amount Transaction --
select nama_user as nama_pembeli, count(1) as jumlah_transaksi, sum(total) as total_nilai_transaksi, min(total) as min_nilai_transaksi
from orders
inner join users on buyer_id = user_id
group by user_id, nama_user
having count(1) > 5 and min(total) > 2000000
order by 3 desc;

-- List customers as Dropshipper --
select
	nama_user as nama_pembeli,
	count(1) as jumlah_transaksi,
	count(distinct orders.kodepos) as distinct_kodepos,
	sum(total) as total_nilai_transaksi,
	avg(total) as avg_nilai_transaksi
from orders
inner join users on buyer_id = user_id
group by user_id, nama_user
having count(1) >= 10 and count(1) = count(distinct orders.kodepos)
order by 2 desc;

-- List Offline Resellers --
select
	nama_user as nama_pembeli,
	count(1) as jumlah_transaksi,
	sum(total) as total_nilai_transaksi,
	avg(total) as avg_nilai_transaksi,
	avg(total_quantity) as avg_quantity_per_transaksi
from orders
inner join users on buyer_id = user_id
inner join (select order_id,
	    sum(quantity) as total_quantity
	    from order_details
	    group by 1) as summary_order using(order_id)
where orders.kodepos = users.kodepos
group by user_id, nama_user
having count(1) >= 8 and avg(total_quantity) > 10
order by 3 desc;

-- List Customers = Resellers --
select
	nama_user as nama_pengguna,
	jumlah_transaksi_beli,
	jumlah_transaksi_jual
from users
inner join (select buyer_id, count(1) as jumlah_transaksi_beli
		   from orders
		   group by 1) as buyer on buyer_id = user_id
inner join (select seller_id, count(1) as jumlah_transaksi_jual
		   from orders
		   group by 1) as seller on seller_id = user_id
where jumlah_transaksi_beli >= 7
order by 1;

-- Transaction Duration Time --
select
	extract(year_month from created_at) as tahun_bulan,
	count(1) as jumlah_transaksi,
	avg(datediff(paid_at, created_at)) as avg_lama_dibayar,
	min(datediff(paid_at, created_at)) as min_lama_dibayar,
	max(datediff(paid_at, created_at)) as max_lama_dibayar
from orders
where paid_at is not null
group by 1
order by 1;
