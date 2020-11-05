-- 3.2.2.1 Выбрать максимальную зарплату у сотрудника.

SELECT 
s.emp_no, concat(first_name, ' ', last_name) as full_name , max(salary)
FROM
    salaries as s
    left join employees e on e.emp_no = s.emp_no
    left join dept_emp d on d.emp_no = s.emp_no
    
