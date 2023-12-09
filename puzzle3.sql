SELECT
    name, phone
FROM read_json_auto('noahs-customers.jsonl.gz')
WHERE citystatezip IN (
    SELECT citystatezip FROM read_csv_auto('solution2.csv', header = true)
)
AND list_contains(
    (SELECT years from read_json_auto('aux_chinese_zodiac.jsonl') WHERE sign == 'Rabbit'),
    year(birthdate))
AND list_contains(
    (SELECT days from read_json_auto('aux_astrological_signs.jsonl') WHERE sign == 'Cancer'),
    array_to_string([month(birthdate), day(birthdate)], '-'))
;
