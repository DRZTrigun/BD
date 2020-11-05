-- 3.2.2.2 Выбрать максимальную зарплату у сотрудника.
-- указываем департамент

SELECT 
    s.emp_no,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    dep.dept_name,
    MAX(salary)
FROM
    salaries AS s
        LEFT JOIN
    employees e ON e.emp_no = s.emp_no
        LEFT JOIN
    dept_emp d ON d.emp_no = s.emp_no
        LEFT JOIN
    departments AS dep ON dep.dept_no = d.dept_no
GROUP BY dep.dept_name
ORDER BY MAX(salary)
