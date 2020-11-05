-- 3.2.5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.

SELECT 
    de.dept_no, COUNT(de.emp_no) as numb
FROM
    dept_emp AS de
        LEFT JOIN
    departments AS d ON d.dept_no = de.dept_no
WHERE
    de.emp_no IN (SELECT DISTINCT
            emp_no
        FROM
            titles
        WHERE
            de.from_date > '1986-01-01'
                AND de.to_date < '9999-01-01')
GROUP BY de.dept_no
order by numb DESC;

SELECT 
    de.dept_no, dpt.dept_name, SUM(s.salary) AS salary_total
FROM
    dept_emp AS de
        LEFT JOIN
    salaries AS s ON s.emp_no = de.emp_no
