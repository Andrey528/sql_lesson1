/* Создать таблицу с основной информацией о сотрудниках: ФИО, дата рождения, дата начала работы, должность, уровень сотрудника 
(jun, middle, senior, lead), уровень зарплаты, идентификатор отдела, наличие/отсутствие прав(True/False). При этом в таблице 
обязательно должен быть уникальный номер для каждого сотрудника. */
CREATE TABLE IF NOT EXISTS public.employees
(
	Id SERIAL PRIMARY KEY,
	Name CHARACTER VARYING(150),
	Birthday DATE,
	Start_to_work DATE,
	Post CHARACTER VARYING(50),
	Employee_level CHARACTER VARYING(50),
	Salary_level MONEY,
	Department_id INTEGER,
	Driver_license BOOLEAN
);

INSERT INTO employees 
(Name, Birthday, Start_to_work, Post, Employee_level, Salary_level, Department_id, Driver_license) 
VALUES
('Иванов Иван Иванович', '1999-12-12', '2020-12-24', 'Developer', 'Junior', '35000', 1, FALSE),
('Петров Петр Петрович', '1990-11-15', '2010-01-14', 'Developer', 'Senior', '160000', 1, TRUE),
('Кирилов Кирил Кирилович', '1995-12-14', '2014-09-12', 'Developer', 'Middle', '125000', 1, FALSE),
('Сидоров Николай Николаевич', '1993-11-16', '2012-07-17', 'Developer', 'Middle', '120000', 2, FALSE),
('Попов Дмитрий Евгеньевич', '1992-04-11', '2011-11-15', 'Developer', 'Middle', '130000', 2, TRUE),
('Зябко Антон Дмитриевич', '1990-02-27', '2012-05-04', 'Developer', 'Senior', '200000', 3, FALSE),
('Коробков Ильдар Сергеевич', '1991-03-21', '2013-04-25', 'Developer', 'Middle', '140000', 3, TRUE);

/* Для будущих отчетов аналитики попросили вас создать еще одну таблицу с информацией по отделам – в таблице должен быть 
идентификатор для каждого отдела, название отдела (например. Бухгалтерский или IT отдел), ФИО руководителя и количество сотрудников. */

CREATE TABLE IF NOT EXISTS public.departments
(
	Department_id SERIAL PRIMARY KEY,
	Department_name CHARACTER VARYING(50),
	Managers_name CHARACTER VARYING(150),
	Employees_count INTEGER
);

INSERT INTO departments 
(Department_name, Managers_name, Employees_count) 
VALUES
('Application Development', 'Петров Петр Петрович', 3),
('Product Support', 'Кирилов Кирил Кирилович', 2),
('Cyber Security', 'Зябко Антон Дмитриевич', 2);

ALTER TABLE employees
ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);

/* Для будущих отчетов аналитики попросили вас создать еще одну таблицу с информацией по отделам – в таблице должен быть идентификатор 
для каждого отдела, название отдела (например. Бухгалтерский или IT отдел), ФИО руководителя и количество сотрудников. */

CREATE TABLE IF NOT EXISTS public.employees_marks
(
	Id SERIAL PRIMARY KEY,
	PersonID INTEGER,
	quarter1 CHARACTER VARYING(1),
	quarter2 CHARACTER VARYING(1),
	quarter3 CHARACTER VARYING(1),
	quarter4 CHARACTER VARYING(1),
	FOREIGN KEY (PersonID) REFERENCES employees(id)
);

INSERT INTO employees_marks 
(PersonID, quarter1, quarter2, quarter3, quarter4) 
VALUES
(1, 'A', 'B', 'A', 'B'),
(2, 'B', 'A', 'B', 'A'),
(3, 'A', 'A', 'B', 'A'),
(4, 'B', 'C', 'E', 'B'),
(5, 'F', 'E', 'C', 'C'),
(6, 'A', 'C', 'C', 'B'),
(7, 'E', 'F', 'C', 'C');

/* Ваша команда расширяется и руководство запланировало открыть новый отдел – отдел Интеллектуального анализа данных. На начальном этапе в 
команду наняли одного руководителя отдела и двух сотрудников. Добавьте необходимую информацию в соответствующие таблицы. */

INSERT INTO departments 
(Department_name, Managers_name, Employees_count) 
VALUES
('Data mining', 'Олегов Петр Петрович', 3);

INSERT INTO employees 
(Name, Birthday, Start_to_work, Post, Employee_level, Salary_level, Department_id, Driver_license) 
VALUES
('Киримов Иван Иванович', '1997-12-12', '2022-12-06', 'Developer', 'Junior', '42000', 4, FALSE),
('Олегов Петр Петрович', '1991-11-15', '2022-12-06', 'Developer', 'Senior', '210000', 4, TRUE),
('Ништяков Кирил Кирилович', '1994-12-14', '2022-12-06', 'Developer', 'Middle', '123000', 4, FALSE);

INSERT INTO employees_marks 
(PersonID, quarter1, quarter2, quarter3, quarter4) 
VALUES
(8, '', '', '', ''),
(9, '', '', '', ''),
(10, '', '', '', '');

/* Уникальный номер сотрудника, его ФИО и стаж работы – для всех сотрудников компании */

SELECT id, name, (CURRENT_DATE - start_to_work) AS experience 
    FROM employees;

/* Уникальный номер сотрудника, его ФИО и стаж работы – только первых 3-х сотрудников */	

SELECT id, name, (CURRENT_DATE - start_to_work) AS experience 
    FROM employees LIMIT 3;

/* Уникальный номер сотрудников - водителей */

SELECT id FROM employees WHERE (driver_license = TRUE);

/* Выведите номера сотрудников, которые хотя бы за 1 квартал получили оценку D или E */

SELECT personid FROM employees_marks WHERE (quarter1 = 'D') OR (quarter1 = 'E');

/* Выведите самую высокую зарплату в компании. */

SELECT MAX(salary_level) FROM employees;