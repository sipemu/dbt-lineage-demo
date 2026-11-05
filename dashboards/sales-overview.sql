-- @title How are sales and customers developing?
-- @description Revenue, order volume and the most valuable customers, read from the dbt marts.
-- @owner analytics@example.com
--
-- anofox-visualization dashboard (https://github.com/DataZooDE/anofox-visualization):
-- every SELECT with ::ROLE casts becomes a panel. The tables it reads are dbt
-- models; `dbt-lineage exposures anofox` turns this file into a dbt exposure.

SELECT 'How are sales and customers developing?'::DASHBOARD_TITLE;

SELECT 'Performance'::GROUP;
SELECT ROUND(SUM(total_amount), 0)::MONEY, 'Revenue'::LABEL FROM orders;
SELECT COUNT(*)::COMPACT, 'Orders'::LABEL FROM orders;
SELECT COUNT(*)::COMPACT, 'Customers'::LABEL FROM customers;
SELECT 1::ENDGROUP;

SELECT order_date::XAXIS, SUM(total_amount)::LINECHART
FROM orders
GROUP BY 1
ORDER BY 1;

SELECT status::CATEGORY, COUNT(*)::BARCHART
FROM orders
GROUP BY 1;

SELECT first_name || ' ' || last_name AS customer, order_count, lifetime_value::MONEY ::TABLE
FROM customers
ORDER BY lifetime_value DESC
LIMIT 10;
