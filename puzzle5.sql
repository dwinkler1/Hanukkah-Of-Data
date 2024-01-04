WITH orders AS (
    SELECT
        * EXCLUDE(items),
        UNNEST(items) as item
    FROM read_json_auto('noahs-customers.jsonl.gz')
    JOIN 
    (FROM read_json_auto('noahs-orders.jsonl.gz'))
    USING(customerid)
)
SELECT
    name, phone
FROM orders 
WHERE starts_with(citystatezip, 'Staten Island')
AND item.sku IN (
    SELECT 
        sku
    FROM read_json_auto('noahs-products.jsonl.gz')
    WHERE contains(lower("desc"), 'cat')
)
GROUP BY name, phone
ORDER BY sum(item.qty) DESC
LIMIT 1;

