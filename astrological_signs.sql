-- astrological_signs table
COPY (
    SELECT 
        'Aries' as sign,
        array_transform(
            range('2000-03-21'::DATE, '2000-04-21'::DATE, to_days(1)),
            d -> array_to_string([month(d), day(d)], '-')) as days,
    UNION ALL
    SELECT 
        'Taurus' as sign,
        array_transform(
            range('2000-04-21'::DATE, '2000-05-22'::DATE, to_days(1)),
            d -> array_to_string([month(d), day(d)], '-')) as days,
    UNION ALL
    SELECT 
        'Gemini' as sign,
        array_transform(
            range('2000-05-22'::DATE, '2000-06-22'::DATE, to_days(1)),
            d -> array_to_string([month(d), day(d)], '-')) as days,
    UNION ALL
    SELECT 
        'Cancer' as sign,
        array_transform(
            range('2000-06-22'::DATE, '2000-07-23'::DATE, to_days(1)),
            d -> array_to_string([month(d), day(d)], '-')) as days,
    UNION ALL
    SELECT 
        'Leo' as sign,
        array_transform(
            range('2000-07-23'::DATE, '2000-08-23'::DATE, to_days(1)),
            d -> array_to_string([month(d), day(d)], '-')) as days,
    UNION ALL
    SELECT 
        'Virgo' as sign,
        array_transform(
            range('2000-08-23'::DATE, '2000-09-23'::DATE, to_days(1)),
            d -> array_to_string([month(d), day(d)], '-')) as days,
    UNION ALL
    SELECT 
        'Libra' as sign,
        array_transform(
            range('2000-09-23'::DATE, '2000-10-23'::DATE, to_days(1)),
            d -> array_to_string([month(d), day(d)], '-')) as days,
    UNION ALL
    SELECT 
        'Scorpio' as sign,
        array_transform(
            range('2000-10-23'::DATE, '2000-11-22'::DATE, to_days(1)),
            d -> array_to_string([month(d), day(d)], '-')) as days,
    UNION ALL
    SELECT 
        'Sagittarius' as sign,
        array_transform(
            range('2000-11-22'::DATE, '2000-12-22'::DATE, to_days(1)),
            d -> array_to_string([month(d), day(d)], '-')) as days,
    UNION ALL
    SELECT 
        'Capricorn' as sign,
        array_transform(
            range('2000-12-22'::DATE, '2001-01-20'::DATE, to_days(1)),
            d -> array_to_string([month(d), day(d)], '-')) as days,
    UNION ALL
    SELECT 
        'Aquarius' as sign,
        array_transform(
            range('2001-01-20'::DATE, '2001-02-19'::DATE, to_days(1)),
            d -> array_to_string([month(d), day(d)], '-')) as days,
    UNION ALL
    SELECT 
        'Pisces' as sign,
        array_transform(
            range('2001-02-19'::DATE, '2001-03-21'::DATE, to_days(1)),
            d -> array_to_string([month(d), day(d)], '-')) as days
) TO 'aux_astrological_signs.jsonl' (FORMAT JSON);