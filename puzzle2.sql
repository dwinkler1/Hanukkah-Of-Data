.mode csv
.output solution2.csv
CREATE MACRO solution2(YEAR_, INITIALS_, ITEM_) AS TABLE
SELECT DISTINCT
    name, phone, citystatezip
FROM (
        SELECT
            customerid,
            UNNEST(items).sku as sku
        FROM
            read_json_auto('noahs-orders.jsonl.gz')
        WHERE year(ordered) == YEAR_
    )
    JOIN
    (
        SELECT 
            name, phone,
            customerid, 
            citystatezip,
            split(name, ' ') as n
        FROM read_json_auto('noahs-customers.jsonl.gz')
        WHERE n[1][1] == INITIALS_[1]
        AND n[2][1] == INITIALS_[2]
    ) USING(customerid)
    JOIN
    (
        SELECT 
            sku
        FROM read_json_auto('noahs-products.jsonl.gz')
        WHERE contains(lower("desc"), lower(ITEM_))
    ) USING(sku)
;
FROM solution2(2017, 'JP', 'rug');
