-- 1.2.1 Выбрать все города из Московской области region_id = 1053480

SELECT 
    title_ru as `Города Московской области`
FROM
    _cities
WHERE
    region_id = 1053480
