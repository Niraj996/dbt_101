-- models/marts/customer_orders_summary.sql
-- This model creates a summary of customer order behavior

WITH customer_orders AS (
    SELECT
        c.customer_id,
        c.full_name,
        c.email,
        c.signup_date,
        o.order_id,
        o.order_date,
        o.order_amount,
        o.status
    FROM {{ ref('stg_customers') }} c
    LEFT JOIN {{ ref('stg_orders') }} o
        ON c.customer_id = o.customer_id
)

SELECT
    customer_id,
    full_name,
    email,
    signup_date,
    COUNT(order_id) AS total_orders,
    COALESCE(SUM(order_amount), 0) AS total_spent,
    COALESCE(AVG(order_amount), 0) AS avg_order_value,
    MAX(order_date) AS last_order_date
FROM customer_orders
GROUP BY customer_id, full_name, email, signup_date
