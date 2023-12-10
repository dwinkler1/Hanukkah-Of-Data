CREATE MACRO solution4(CATEGORY) AS TABLE
WITH orders AS (
    SELECT
        customerid,
        make_time(hour(ordered), minute(ordered), second(ordered)) as order_time,
        date_trunc('day', ordered) as order_day,
        UNNEST(items).sku as sku
    FROM read_json_auto('noahs-orders.jsonl.gz')
    WHERE hour(ordered) < 5
), first_customer AS (
    SELECT 
        arg_min(customerid, order_time) as customerid 
    FROM orders
    WHERE starts_with(sku, CATEGORY)
    GROUP BY order_day
), top_customer AS (
    SELECT
        customerid 
    FROM first_customer
    GROUP BY customerid 
    ORDER BY count() DESC
    LIMIT 1
)
SELECT 
    name, phone 
FROM read_json_auto('noahs-customers.jsonl.gz')
WHERE customerid = (FROM top_customer)
;
FROM solution4('BKY');