1. Реализовать практические задания на примере других таблиц и запросов.

use geodata;     

 select * from _cities limit 3;
 
 lock table _cities read;
 
 use geodata;
 
 insert into _cities set id = 10050, country_id = 1, region_id = null, title_ru = 'Новая Москва';
 
 show processlist;
 
 unlock tables;
 
 Query OK, 1 row affected (14.39 sec)
 
  lock table _cities write;
Query OK, 0 rows affected (0.00 sec)

select * from _cities limit 3;

mysql> unlock tables;
Query OK, 0 rows affected (0.00 sec)

3 rows in set (14.66 sec)


--EXPLAIN 

explain select count(*) from geodata._cities where id = 10050;
explain select * from _cities;
explain select _regions.title as Region, count(_cities.id) from _regions left join _cities on _regions.id = _cities.region_id group by _regions.title;



2. Подумать, какие операции являются транзакционными, и написать несколько примеров с транзакционными запросами.

-- В MySQL транзакции поддерживаются только таблицами innoDB. Таблицы MyISAM транзакции не поддерживают.
-- В innoDB по умолчанию включен autocommit, это значит, что по умолчанию каждый запрос эквивалентен одной транзакции.

Start transaction;
INSERT INTO _countries (id, title_country) VALUES (330, 'My country');
INSERT INTO _regions (id, country_id, title) VALUES (222222, 330, 'Centr');
INSERT INTO _cities (id, country_id, important, region_id, title_ru) VALUES (211414, 330, 1, 222222, 'Новый Свет'); 
commit;

SELECT * FROM _countries WHERE title_country = 'My country';
1 row in set (0.00 sec)



3. Проанализировать несколько запросов с помощью EXPLAIN.

Делаем запрос и смотрим  результат

explain select * from employees as e
join salaries  as s on e.emp_no = s.emp_no
where s.salary > 10000 and e.first_name like 'Gr%';

Далее устанавливаем ключ на first_name

ALTER TABLE `employees`.`employees` 
;
ALTER TABLE `employees`.`employees` ALTER INDEX `fk_first_name` VISIBLE;

и повторяем запрос и видим что количество проходимых строк уменьшилось более чем в 250 раз и фильтр равен 100%

далее вешаем ключ на salary в талблице salsries

ALTER TABLE `employees`.`salaries` 
ADD INDEX `fk_salary` (`salary` ASC) VISIBLE;
;

и видим что уповысилась эффективность выборки.

Вывод: ключи надо страраться вешать на те столбцы которые учавствуют в условиях(where) выборки,
для ускорения поиска и оптимизации запросов и уменьшения назрузки на БД

