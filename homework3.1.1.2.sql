-- 1.1.2 Сделать запрос, в котором мы выберем все данные о городе – регион, страна.

SELECT 
    _countries.title_country AS country,
    _regions.title AS region,
    _cities.title_ru AS city
FROM
    _cities
        LEFT JOIN
    _regions ON _cities.region_id = _regions.id
        LEFT JOIN
    _countries ON _regions.country_id = _countries.id
WHERE
    _cities.title_ru LIKE 'Волгоград'
