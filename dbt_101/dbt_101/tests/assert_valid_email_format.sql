-- test/assert_valid_email_format.sql
-- All emails must contain @ symbol

SELECT 
    customer_id, 
    email
FROM {{ ref('stg_customers') }}
WHERE email NOT LIKE '%@%'
