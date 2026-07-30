-- 1. Which warehouse has the highest stock discrepancy rate, and what's actually driving it?
select warehouse_id, count(*) frequency from  inventory_movements
where status = 'Discrepancy'
group by warehouse_id
order by frequency desc
limit 1

-- 2. Is there a relationship between unit cost and quantity across suppliers? Which supplier(s), if any, deviate from that pattern — and by how much?
select supplier_id, avg(unit_cost) avg_cost, avg(quantity) avg_quantity
from inventory_movements im 
group by supplier_id order by avg_cost desc

-- 3. Which SKU(s) show signs of frequent stockouts or inventory imbalance (e.g. negative or implausible stock levels)? What would you recommend doing about it?
select avg(quantity) from inventory_movements

select * from (
	select sku_id, count(*) freq from inventory_movements im 
	where stock_after < 247 and stock_after > 0
	group  by im.sku_id
)t order by t.freq desc

select sku_id, stock_after from inventory_movements im 
where stock_after < 0
