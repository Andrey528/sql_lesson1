/* Попробуйте вывести не просто самую высокую зарплату во всей команде, а вывести именно фамилию сотрудника с самой высокой зарплатой. */
SELECT name FROM employees WHERE salary_level=(SELECT MAX(salary_level) FROM employees);

/* Попробуйте вывести фамилии сотрудников в алфавитном порядке */
SELECT name FROM employees ORDER BY name;

/* Рассчитайте средний стаж для каждого уровня сотрудников */
SELECT employee_level, AVG(CURRENT_DATE - start_to_work) AS experience 
    FROM employees GROUP BY employee_level;

/* Выведите фамилию сотрудника и название отдела, в котором он работает */
SELECT emp.department_id, dep.department_name, emp.name FROM employees AS emp
JOIN departments AS dep
ON emp.department_id = dep.department_id;

/* Выведите название отдела и фамилию сотрудника с самой высокой зарплатой в данном отделе и саму зарплату также. */
SELECT emp1.department_id, dep.department_name, emp2.name, emp1.salary_level
FROM departments AS dep
INNER JOIN (SELECT department_id, MAX(salary_level) AS salary_level FROM employees 
	  GROUP BY department_id) AS emp1
ON dep.department_id = emp1.department_id
JOIN (SELECT department_id, name, salary_level FROM employees) AS emp2
ON emp1.salary_level = emp2.salary_level
ORDER BY emp1.department_id;