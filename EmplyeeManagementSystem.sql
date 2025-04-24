create database employeemanagement;
use employeemanagement;

create table employee(
employee_id INT primary KEY auto_increment,
employee_name VARCHAR(50),
age INT CHECk (age >= 18),
salary decimal(10,4),
hier_date date,
dept_id INT,
 FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

create table department(
dept_id INT PRIMARY KEY auto_increment,
dept_name varchar(50)
);

INSERT INTO employee (employee_name, age, salary, hier_date, dept_id) VALUES
('Alice', 28, 55000.00, '2022-03-10', 1),
('Bob', 35, 62000.50, '2021-07-15', 2),
('Charlie', 42, 75000.75, '2019-11-20', 3),
('David', 30, 58000.25, '2023-01-05', 4),
('Eve', 27, 53000.00, '2022-06-18', 5),
('Frank', 40, 70000.00, '2020-09-23', 1),
('Grace', 29, 56000.90, '2021-04-12', 2),
('Hank', 33, 60000.45, '2018-12-07', 3),
('Ivy', 26, 52000.30, '2023-08-30', 4),
('Jack', 31, 59000.80, '2019-05-25', 5);

INSERT INTO department(dept_name) VALUES
('HR'),
('Finance'),
('IT'),
('Marketing'),
('Sales'),
('Operations'),
('Research'),
('Support'),
('Legal'),
('Admin');

select * from employee;

select employee_name,salary 
from employee
where dept_id=3;

select e.employee_id,e.employee_name,e.dept_id,e.salary
FROM employee as e
JOIN department as d
ON e.dept_id=d.dept_id
WHERE dept_name='IT';

select employee_name,salary,employee_id
FROM employee
ORDER BY salary desc;

select dept_id,count(employee_id) AS employee_count
FROM department
left join employee
ON department.dept_id=employee.dept_id;

select d.dept_id, count(employee_id) AS employee_count
FROM department as d
JOIN employee as e
ON d.dept_id=e.dept_id
group by dept_id;

UPDATE employee
SET salary=100.0000
WHERE employee_id=3;

UPDATE employee
SET employee_name='shri'
WHERE employee_id=2;

UPDATE employee
SET hier_date = '2025-03-19'
WHERE employee_id=2;

select * from employee;

UPDATE employee
SET salary =
CASE
WHEN employee_id=1 THEN 60000.00
WHEN employee_id=2 THEN 65000.00
WHEN employee_id=3 THEN 70000.00
END
WHERE employee_id IN (1,2,3);

create table project(
project_id INT PRIMARY KEY auto_increment,
project_name VARCHAR(50),
start_date date,
end_date date
);

create table employee_project(
employee_Project_id INT PRIMARY KEY auto_increment,
employee_id INT,
project_id Int,
role VARCHAR(50),
foreign key (employee_id) REFERENCES employee(employee_id),
foreign key (project_id) REFERENCES project(project_id)
);

insert into project(project_name,start_date,end_date)
values('Inventory Management System', '2023-01-15', '2023-08-30'),
('E-commerce Website', '2022-05-01', '2023-04-15'),
('HR Management System', '2021-09-10', '2022-12-20'),
('Customer Support Portal', '2024-02-01', '2024-11-30'),
('Financial Dashboard', '2023-07-20', '2024-03-10');

insert into employee_project(employee_id,project_id,role) 
values (1, 1, 'Developer'),
(2, 2, 'Tester'),
(3, 3, 'Project Manager'),
(4, 1, 'Designer'),
(5, 4, 'Support Engineer'),
(6, 2, 'Developer'),
(7, 3, 'Analyst'),
(8, 5, 'Finance Expert'),
(9, 4, 'Support Engineer'),
(10, 5, 'Analyst');

select e.employee_id,project_id,e.employee_name,p.project_name,ep.role
FROM employee as e 
JOIN employee_project as ep 
ON ep.employee_id=e.employee_id
join project as p 
ON ep.project_id=p.project_id;

