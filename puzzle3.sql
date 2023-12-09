CREATE MACRO solution3(CHINESE, ASTRO) AS TABLE
SELECT
    name, phone
FROM read_json_auto('noahs-customers.jsonl.gz')
WHERE citystatezip IN (
    SELECT citystatezip FROM read_csv_auto('solution2.csv', header = true)
)
AND list_contains(
    (SELECT years FROM read_json_auto('aux_chinese_zodiac.jsonl') WHERE sign == CHINESE),
    year(birthdate))
AND list_contains(
    (SELECT days FROM read_json_auto('aux_astrological_signs.jsonl') WHERE sign == ASTRO),
    array_to_string([month(birthdate), day(birthdate)], '-'))
;
FROM solution3('Rabbit', 'Cancer');