with noahs_coll AS (
    SELECT
        sku
    FROM read_json_auto('noahs-products.jsonl.gz')
    WHERE starts_with("desc", 'Noah') 
), orders AS (
    SELECT
        * EXCLUDE(items),
        UNNEST(items) as item
    FROM read_json_auto('noahs-orders.jsonl.gz')
), noahs_orders AS (
    SELECT
        customerid
    FROM orders
    WHERE item.sku IN (
        SELECT
            sku
        FROM noahs_coll
    )
    GROUP BY customerid
    ORDER BY sum(item.qty) DESC
    LIMIT 1
)
SELECT 
    name, phone
FROM read_json_auto('noahs-customers.jsonl.gz')
WHERE customerid = (FROM noahs_orders);