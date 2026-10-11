# Business Answers

---

## Q1. Which warehouse has the highest stock discrepancy rate, and what's actually driving it?

**Answer:**
WH_06 (Pune) has the highest discrepancy (89).
The common pattern in rows where the status is "Discrepancy" is that they one or more null values.

**How you checked it (query/method):**
I calculated the frequency of "Discrepancy" in status and grouped them by warehouse_id.
---

## Q2. Is there a relationship between unit cost and quantity across suppliers? Which supplier(s) deviate, and by how much?

**Answer:**
There is a very weak inverse relationship between quantity and unit_cost. There are few outliers in suppliers that go against this relationship. The biggest outlier is SUP_09 that deviates from average cost by 9,253 and average quantity -8.

**How you checked it (query/method):**
- First, I checked the correlation between quantity and unit_cost using the corr() function in SQL.
- Then, I calculated the deviation between average quantity and cost by supplier, and overall average quantity and cost using CTE.

---

## Q3. Which SKU(s) show signs of frequent stockouts or inventory imbalance? What would you recommend?

**Answer:**
SKU_0055 shows the highest signs of stockout. I highly recommend restocking the products as soon as stock_after reached below the average stock for that SKU.

**How you checked it (query/method):**
- First, I calculated the average stock_after for each SKU.
- Then, calculated the frequency of each time an SKU stock_after reached below its respective average.
- This helps in identifying SKUs that need restocking before their stock_after reaches 0.

---

## Q4. What data quality issues did you find, and how did you handle them?

**Answer:**
- Empty supplier_ids (3,528)
- Empty expected_date values (75)
- Empty empty movement_date values (74)
- Empty customer_id (3,249)
- Null stock_after (1,118)

I ignored all empty values for the purpose of this assignment due to lack of supporting data regarding the empty/null values.

---

## Q5. If you could track exactly one metric weekly to catch inventory problems early, what would it be and why?

**Answer:**
I would track the stock_after column for each SKU since it would help in preparing the stock before it runs out, hence, allowing smooth operations.

---

## Anything else you'd flag if this were a real dataset at FreightFox?
The data would be easier to understand if the order of the columns was cohesive: 
customer_id -> movement_id -> sku_id -> supplier_id -> warehouse_id -> warehouse_city -> region -> movement_date -> expected_date -> unit_cost -> movement_type -> quantity -> stock_before -> stock_after -> status
