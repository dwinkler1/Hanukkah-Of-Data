SELECT 
    name, phone 
FROM (
    SELECT
        name, phone,
        split(lower(name), ' ') as n1,
        split(n1[length(n1)], '') as n,
        replace(phone, '-', '') as p,
        map(array_transform(range(97, 97+26)::INT[], num->chr(num)), 
            [2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7,7,8,8,8,9,9,9,9]) as m,
        array_to_string(list_transform(n, x->m[x][1]),'') as np
    FROM read_json_auto('noahs-customers.jsonl.gz')
    where np == p
);
