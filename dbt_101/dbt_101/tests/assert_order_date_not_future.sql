-- test/assert_order_date_not_future.sql
-- Orders should not have future dates

SELECT 
    order_id,
    order_date,
    CURRENT_DATE AS today
FROM {{ ref('stg_orders') }}
WHERE order_date > CURRENT_DATE
