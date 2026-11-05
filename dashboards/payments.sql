-- @title Which payment methods do customers use?
-- @description Payment mix and amounts per method, from the staging layer.
-- @owner finance@example.com

SELECT 'Which payment methods do customers use?'::DASHBOARD_TITLE;

SELECT payment_method::CATEGORY, SUM(amount)::DONUTCHART
FROM stg_payments
GROUP BY 1;

SELECT payment_method, COUNT(*) AS payments, ROUND(AVG(amount), 2) AS avg_amount ::TABLE
FROM stg_payments
GROUP BY 1
ORDER BY 2 DESC;
