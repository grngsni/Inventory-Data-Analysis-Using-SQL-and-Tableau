-- 1. Which warehouse has the highest stock discrepancy rate, and what's actually driving it?
select warehouse_id, count(*) frequency from  inventory_movements
where status = 'Discrepancy'
group by warehouse_id
order by frequency desc
limit 1

select * from inventory_movements im where status = 'Discrepancy'

-- 2. Is there a relationship between unit cost and quantity across suppliers? Which supplier(s), if any, deviate from that pattern — and by how much?
select corr(quantity, unit_cost) correlation
FROM inventory_movements im 

WITH overall AS (
    SELECT
        AVG(unit_cost) AS overall_avg_cost,		-- 1306
        AVG(quantity) AS overall_avg_quantity		-- 247
    FROM inventory_movements
),
supplier_avg AS (
    SELECT
        supplier_id,
        AVG(unit_cost) AS avg_cost,
        AVG(quantity) AS avg_quantity
    FROM inventory_movements
    GROUP BY supplier_id
)
SELECT
    s.supplier_id,
    s.avg_cost,
    o.overall_avg_cost,
    s.avg_cost - o.overall_avg_cost AS cost_deviation,
    s.avg_quantity,
    o.overall_avg_quantity,
    s.avg_quantity - o.overall_avg_quantity AS quantity_deviation
FROM supplier_avg s
CROSS JOIN overall o
ORDER BY ABS(s.avg_cost - o.overall_avg_cost) DESC;


-- 3. Which SKU(s) show signs of frequent stockouts or inventory imbalance (e.g. negative or implausible stock levels)? What would you recommend doing about it?
WITH avg_stock AS (
    SELECT
        sku_id,
        AVG(stock_after) AS avg_stock_after
    FROM inventory_movements
    GROUP BY sku_id
)

SELECT
    im.sku_id,
    COUNT(*) AS below_avg_stock_count
FROM inventory_movements im
INNER JOIN avg_stock a
    ON im.sku_id = a.sku_id
WHERE im.stock_after < a.avg_stock_after
  AND im.stock_after > 0
GROUP BY im.sku_id
ORDER BY below_avg_stock_count DESC;

select sku_id, stock_after from inventory_movements im 
where stock_after < 0


-- 4. Data Quality issues 
select count(*) from inventory_movements im 
where im.supplier_id = ''		-- empty supplier_id values

select count(*) from inventory_movements im 
where im.expected_date = ''				-- empty expected_date values

select count(*) from inventory_movements im 
where im.movement_date = ''				-- empty movement_date values

select count(*) from inventory_movements im 
where im.customer_id = ''		-- empty customer_id values

select count(*) from inventory_movements im 
where im.stock_after is null or stock_after < 0		-- empty/negative stock_after values
