.mode csv
.output solution6.csv
with orders AS (
    SELECT
        * EXCLUDE(items),
        UNNEST(items) as item
    FROM read_json_auto('noahs-orders.jsonl.gz')
), min_custs AS (
    SELECT
        argMin(customerid, item.unit_price) as min_customerid,
        item.sku as sku,
    FROM orders
    GROUP BY sku
), cust_id_sol AS (
    SELECT
       min_customerid as customerid,
    FROM min_custs
    GROUP BY min_customerid
    ORDER BY count() DESC
    LIMIT 1
)
SELECT
    name, phone, customerid
FROM read_json_auto('noahs-customers.jsonl.gz')
JOIN cust_id_sol
USING(customerid)
;