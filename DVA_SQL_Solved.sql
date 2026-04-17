
-- Q1: Top 5 Customers by Number of Orders 

SELECT TOP 5
    USER_ID,
    COUNT(DISTINCT order_id) AS num_orders
FROM transactions
GROUP BY USER_ID
ORDER BY num_orders DESC;

SELECT TOP 10
    USER_ID,
    ROUND(SUM(sale_amount), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sale_amount) / COUNT(DISTINCT order_id), 2)  AS avg_transaction_value
FROM transactions
GROUP BY USER_ID
ORDER BY total_sales DESC;


-- Q3: Top 3 Product Categories by Total Sales + % Contribution 

WITH category_sales AS (
    SELECT
        p.Sub_category_name,
        ROUND(SUM(t.sale_amount), 2) AS total_sales
    FROM transactions t
    JOIN products p
        ON t.product_id  = p.Product_Id
        AND t.merchant_id = p.Merchant_id
    GROUP BY p.Sub_category_name
),
overall AS (
    SELECT SUM(sale_amount) AS grand_total FROM transactions
)
SELECT TOP 3
    cs.Sub_category_name,
    cs.total_sales,
    ROUND(cs.total_sales * 100.0 / o.grand_total, 2) AS contribution_pct
FROM category_sales cs
CROSS JOIN overall o
ORDER BY cs.total_sales DESC;



-- Q4: Number of Customers with Above-Average Total Sales 


WITH customer_sales AS (
    SELECT
        USER_ID,
        SUM(sale_amount) AS total_sales
    FROM transactions
    GROUP BY USER_ID
),
avg_sales AS (
    SELECT AVG(total_sales) AS overall_avg
    FROM customer_sales
)
SELECT
    COUNT(*) AS customers_above_avg,
    ROUND(MAX(a.overall_avg), 2) AS average_sales
FROM customer_sales cs
CROSS JOIN avg_sales a
WHERE cs.total_sales > a.overall_avg;

-- Q5: Month-over-Month Sales Growth for 2012 

WITH monthly_sales AS (
    SELECT
        MONTH(CONVERT(DATE, order_time, 105)) AS mth,
        ROUND(SUM(sale_amount), 2) AS total_sales
    FROM transactions
    WHERE YEAR(CONVERT(DATE, order_time, 105)) = 2012
    GROUP BY MONTH(CONVERT(DATE, order_time, 105))
)
SELECT
    mth,
    DATENAME(MONTH, DATEFROMPARTS(2012, mth, 1)) AS month_name,
    total_sales,
    LAG(total_sales) OVER (ORDER BY mth) AS prev_month_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY mth))
        * 100.0
        / LAG(total_sales) OVER (ORDER BY mth)
    , 2)   AS mom_growth_pct
FROM monthly_sales
ORDER BY mth;



-- Q6 Category with Highest Discount % 

WITH discount_data AS (
    SELECT
        p.Sub_category_name,
        (t.sale_price * t.Quantity) AS gross_value,
        (t.sale_price * t.Quantity) - t.sale_amount AS discount
    FROM transactions t
    JOIN products p
        ON t.product_id  = p.Product_Id
        AND t.merchant_id = p.Merchant_id
    WHERE (t.sale_price * t.Quantity) > 0
)
SELECT TOP 1
    Sub_category_name,
    ROUND(SUM(gross_value), 2)  AS total_gross_value,
    ROUND(SUM(discount), 2)  AS total_discount,
    ROUND(SUM(discount) * 100.0 / SUM(gross_value), 2)  AS discount_pct
FROM discount_data
GROUP BY Sub_category_name
ORDER BY discount_pct DESC;

