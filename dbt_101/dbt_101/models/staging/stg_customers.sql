-- models/staging/stg_customers.sql
-- This model cleans and standardizes raw customer data

SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    LOWER(email) AS email,
    signup_date
FROM raw_data.customers
