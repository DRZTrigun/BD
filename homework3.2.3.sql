-- 2.3. Удалить одного сотрудника, у которого максимальная зарплата.

SELECT 
    e.emp_no,
    CONCAT(first_name, ' ', last_name) AS eployeer,
    MAX(salary) AS max_salary
FROM
    salaries AS s
        LEFT JOIN
    employees e ON e.emp_no = s.emp_no
GROUP BY s.emp_no
ORDER BY max_salary DESC
LIMIT 5;
    
DELETE de , e , dm , s , t FROM dept_emp AS de
        LEFT JOIN
    dept_manager AS dm ON de.emp_no = dm.emp_no
        LEFT JOIN
    employees AS e ON de.emp_no = e.emp_no
        LEFT JOIN
    salaries AS s ON de.emp_no = s.emp_no
        LEFT JOIN
    titles AS t ON de.emp_no = t.emp_no
