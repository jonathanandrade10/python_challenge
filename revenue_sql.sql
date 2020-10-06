--https://dbfiddle.uk/?rdbms=sqlserver_2019&fiddle=8861e426039794d2be9aa2315cf31ebf

CREATE TABLE prices (
  product nvarchar(255) NOT NULL,
    price int,
  price_effective_date date
);

CREATE TABLE sales (
  product nvarchar(255) NOT NULL,
  quantity int,
  sales_date date
);



insert into prices (product, price, price_effective_date)
values 
('product_1',50,'2018-01-01')
,('product_2',40,'2018-01-01')
,('product_1',25,'2018-01-03')
,('product_2',20,'2018-01-05')
,('product_1',50,'2018-01-10')
,('product_2',40,'2018-01-12')
;

insert into sales (product, quantity, sales_date)
values 
('product_1',10,'2018-01-01')
,('product_2',12,'2018-01-02')
,('product_1',50,'2018-01-04')
,('product_2',70,'2018-01-06')
,('product_1',8,'2018-01-12')
,('product_2',9,'2018-01-15')
;



with 
prices_end_date as (
select 
	product
	,price
	,price_effective_date
	, LEAD(DATEADD(DAY,-1, price_effective_date),1, getdate()) OVER (PARTITION BY product ORDER BY price_effective_date) as price_end
from prices
)


,final_dataset as (
select
	s.product
	,s.quantity
	,s.sales_date
	,p.price
	,p.price_effective_date
	,p.price_end
from sales s

inner join 
prices_end_date p on s.product = p.product

where s.sales_date >= p.price_effective_date and s.sales_date <= p.price_end
)


select
	SUM(revenues.rev) as total_revenue
from
(
	select
	quantity,
	price,
	quantity*price as rev
	from final_dataset f
)revenues







