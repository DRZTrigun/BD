-- 3.2.4. Посчитать количество сотрудников во всех отделах.

SELECT 
    COUNT(emp_no)
FROM
    employees
    where emp_no IN (SELECT DISTINCT emp_no FROM titles WHERE to_date = '9999-01-01');
