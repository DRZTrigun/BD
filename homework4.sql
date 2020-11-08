4.1 Создать на основе запросов, которые вы сделали в ДЗ к уроку 3, VIEW.

Выбрать максимальную зарплату у сотрудника.

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `max_salary_dep` AS
    SELECT 
        `s`.`emp_no` AS `emp_no`,
        CONCAT(`e`.`first_name`, ' ', `e`.`last_name`) AS `full_name`,
        `dep`.`dept_name` AS `dept_name`,
        MAX(`s`.`salary`) AS `MAX(salary)`
    FROM
        (((`salaries` `s`
        LEFT JOIN `employees` `e` ON ((`e`.`emp_no` = `s`.`emp_no`)))
        LEFT JOIN `dept_emp` `d` ON ((`d`.`emp_no` = `s`.`emp_no`)))
        LEFT JOIN `departments` `dep` ON ((`dep`.`dept_no` = `d`.`dept_no`)))
    GROUP BY `dep`.`dept_name`
ORDER BY MAX(`s`.`salary`)
    
Посчитать количество сотрудников во всех отделах

USE `employees`;
CREATE  OR REPLACE VIEW `all_employees` AS
SELECT 
    COUNT(emp_no)
FROM
    employees
WHERE
    emp_no IN (SELECT DISTINCT
            emp_no
        FROM
            titles
        WHERE
            to_date = '9999-01-01');
    
    
4.2 Создать функцию, которая найдет менеджера по имени и фамилии.
    
CREATE DEFINER=`root`@`localhost` FUNCTION `find_manager`(full_name varchar(255)) RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
declare fu_name varchar(255);
SELECT 
    concat(first_name, ' ' ,last_name)
INTO fu_name FROM
    employees
WHERE
    concat(first_name, ' ' ,last_name) = full_name;
RETURN fu_name;
END


4.3 Создать триггер, который при добавлении нового сотрудника будет
 выплачивать ему вступительный бонус, занося запись в таблицу salary.
 
CREATE DEFINER = `root`@`localhost` 
TRIGGER `bonus_salary` 
AFTER INSERT ON `employees` 
FOR EACH ROW 
BEGIN 
insert into salaries set  emp_no = NEW.emp_no, salary = '10000', 
from_date= curdate(), to_date = '9999-01-01';

END

Добавляем нового сотрудника в table employees
Insert into employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
 value ('1', '1991-04-12', 'Alex', 'Petrov', 'M', '2020-11-07');
 
проверяем что триггер сработал делая в table salaries запрос
 SELECT * FROM employees.salaries where salary = 10000;
