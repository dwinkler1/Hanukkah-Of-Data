COPY
    (
        SELECT
            'Rat' as sign,
            range(1900, year(current_date) + 1, 12) as years
        UNION ALL
        SELECT
            'Ox' as sign,
            range(1901, year(current_date) + 1, 12) as years
        UNION ALL
        SELECT
            'Tiger' as sign,
            range(1902, year(current_date) + 1, 12) as years
        UNION ALL
        SELECT
            'Rabbit' as sign,
            range(1903, year(current_date) + 1, 12) as years
        UNION ALL
        SELECT
            'Dragon' as sign,
            range(1904, year(current_date) + 1, 12) as years
        UNION ALL
        SELECT
            'Snake' as sign,
            range(1905, year(current_date) + 1, 12) as years
        UNION ALL
        SELECT
            'Horse' as sign,
            range(1906, year(current_date) + 1, 12) as years
        UNION ALL
        SELECT
            'Goat' as sign,
            range(1907, year(current_date) + 1, 12) as years
        UNION ALL
        SELECT
            'Monkey' as sign,
            range(1908, year(current_date) + 1, 12) as years
        UNION ALL
        SELECT
            'Rooster' as sign,
            range(1909, year(current_date) + 1, 12) as years
        UNION ALL
        SELECT
            'Dog' as sign,
            range(1910, year(current_date) + 1, 12) as years    
        UNION ALL
        SELECT
            'Pig' as sign,
            range(1911, year(current_date) + 1, 12) as years
    ) TO 'aux_chinese_zodiac.jsonl' (FORMAT JSON);