-- 3.2.1. Выбрать среднюю зарплату по отделам.

SELECT 
    d.dept_name AS Departament, AVG(salary)
FROM
    salaries as s
        LEFT JOIN
    employees AS e ON s.emp_no = e.emp_no
        LEFT JOIN
    dept_emp ON dept_emp.emp_no = e.emp_no
        LEFT JOIN
    departments AS d ON d.dept_no = dept_emp.dept_no
GROUP BY d.dept_name;
    
