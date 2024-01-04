with orders AS (
    SELECT
        customerid,
        ordered,
        UNNEST(items).sku as sku
    FROM read_json_auto('noahs-orders.jsonl.gz')
    
), order_descs AS (
    SELECT
        * EXCLUDE(descs)
    FROM orders
    JOIN (
        SELECT
            sku,
            string_split("desc", '(') as descs,
            descs[1] as item,
            descs[2] as color
        FROM read_json_auto('noahs-products.jsonl.gz')
        where length(descs) >= 2
        ) 
    USING(sku)
), her_orders AS (
    SELECT
        *
    FROM order_descs
    WHERE customerid IN (
        SELECT
            customerid
        FROM read_csv_auto('solution6.csv', header = true)
    )
)
SELECT
    name, phone
FROM read_json_auto('noahs-customers.jsonl.gz')
JOIN (
    SELECT
        argMin(o.customerid, abs(date_diff('minute', h.ordered, o.ordered))) as customerid,
    FROM her_orders h
    JOIN (FROM order_descs) o
        USING(item)
    WHERE o.color != h.color
) 
USING(customerid)
;
