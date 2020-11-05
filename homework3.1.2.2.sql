-- 1.2.2 Выбрать все города из Московской области

SELECT 
    _cities.title_ru AS `Город`,
    _regions.title AS `Область`
FROM
    _cities
        LEFT JOIN
    _regions ON _cities.region_id = _regions.id
WHERE
    _regions.title LIKE 'Московская область'
ORDER BY _cities.title_ru ASC
