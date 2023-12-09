SELECT DISTINCT
    name, phone 
FROM (
        SELECT
            customerid,
            UNNEST(items).sku as sku
        FROM
            read_json_auto('noahs-orders.jsonl.gz')
        WHERE year(ordered) == 2017
    )
    JOIN
    (
        SELECT 
            name, phone,
            customerid, 
            split(name, ' ') as n
        FROM read_json_auto('noahs-customers.jsonl.gz')
        WHERE n[1][1] == 'J'
        AND n[2][1] == 'P'
    ) USING(customerid)
    JOIN
    (
        SELECT 
            sku
        FROM read_json_auto('noahs-products.jsonl.gz')
        WHERE contains(lower("desc"), 'rug')
    ) USING(sku)
;

