-- test/assert_positive_order_amounts.sql
-- Returns records that fail the test (should be empty)


SELECT 
    order_id,
    order_amount
FROM {{ ref('stg_orders') }}
WHERE order_amount <= 0
