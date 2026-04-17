# Retail Sales Analysis — SQL Case Study

**Tools:** SQL Server &nbsp;|&nbsp; CTEs &nbsp;|&nbsp; Window Functions &nbsp;|&nbsp; Joins &nbsp;|&nbsp; Aggregations  
**Domain:** E-commerce &nbsp;|&nbsp; Sales Analytics &nbsp;|&nbsp; Customer Behaviour

---

## About This Project

This case study was built to apply and demonstrate SQL skills on a real-world style e-commerce dataset. The dataset covers customer transactions, product categories, and sales records — the kind of data analysts work with regularly in retail and operations environments.

The goal was not just to write queries, but to answer genuine business questions: Who are the top customers? Which categories drive the most revenue? How did sales trend month over month? Every query here has a verified answer from the actual data.

---

## Dataset

The analysis is built on three related tables:

- **transactions** — order-level records including user, product, sale amount, quantity, and order date
- **products** — product details including category, sub-category, and merchant
- **customers** — customer profile information

---

## Questions Answered

**1. Who are the top 5 customers by number of orders?**  
Ranked customers by order frequency using grouped counts. The most active customer placed 167 orders.

**2. What is the average transaction value for the top 10 customers by sales?**  
Calculated average transaction value as total sales divided by total orders. The highest was ₹15,191 per order — a very different profile from the highest order-volume customer, which shows why looking at both metrics matters.

**3. Which 3 product categories contribute the most to overall revenue?**  
Used a CTE and cross join to calculate each category's share of total sales.

| Category | Total Sales | Share of Revenue |
|---|---|---|
| Food | ₹4,24,081 | 14.25% |
| Mobile Phones | ₹3,89,992 | 13.11% |
| Imported Food | ₹3,31,720 | 11.15% |

**4. How many customers have above-average total sales?**  
Used nested CTEs to compute individual customer totals, find the overall average (₹1,190), and count customers who exceeded it. 549 out of all customers cleared the average.

**5. What was the month-over-month sales growth across 2012?**  
Applied the LAG() window function to compare each month's sales against the previous month. November saw the strongest growth at +53%, while August had the sharpest drop at -34% — useful signals for seasonality planning.

**6. Which product category receives the highest discount?**  
Calculated discount as the difference between gross value (price × quantity) and actual sale amount. The Mother and Children category had the highest discount rate at 8.66%.

---

## SQL Concepts Applied

Working through this case study required a range of SQL techniques beyond basic queries:

- **CTEs** to break complex problems into readable, logical steps
- **LAG() window function** for period-over-period comparisons without self-joins
- **Multi-condition JOINs** — joining products on both product_id and merchant_id to avoid duplicates
- **CROSS JOIN** to broadcast a single aggregate value across all rows
- **Date parsing** using CONVERT with style 105 to handle DD-MM-YYYY formatted strings
- **ROUND, TOP, DATENAME, DATEFROMPARTS** for clean, formatted output

---

## Files

| File | Description |
|---|---|
| `DVA_SQL_Solved.sql` | All 6 queries with verified answers included as comments |

---

## Author

**Prerna Rai** — Data Analyst  
📧 prernarai200q@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/prerna-rai-b3a6a828a)
