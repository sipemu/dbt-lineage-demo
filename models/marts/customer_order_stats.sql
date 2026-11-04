SELECT
    c.customer_id,
    count(o.order_id) AS order_count,
    sum(o.total_amount) AS lifetime_value
FROM {{ ref('customers') }} c
LEFT JOIN {{ ref('orders') }} o ON c.customer_id = o.customer_id
GROUP BY 1
