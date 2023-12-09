.mode csv
.output solution0.csv
SELECT
    hy 
FROM 
    read_json_auto('https://www.hebcal.com/converter?cfg=json&date=2017-01-01&g2h=1&strict=1');