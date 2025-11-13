-- models/staging/stg_orders.sql
-- This model cleans and standardizes raw order data

SELECT
    order_id,
    customer_id,
    order_date,
    order_amount,
    LOWER(status) AS status
FROM raw_data.orders
WHERE status != 'cancelled'  -- Exclude cancelled orders
