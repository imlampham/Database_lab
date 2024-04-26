--BASIC SELECT STATEMENT
--1. Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name" from the employees.
SELECT first_name AS "First Name", last_name AS "Last Name"
FROM employees

--2. Write a query to get unique department ID from employee table.
SELECT employee_id FROM employees

--3. Write a query to get all employee details (from employee table) who are hired in 2022.
SELECT * FROM employees
WHERE DATE_PART('year', hire_date) = 2022;

--4. Write a query to get the names (first_name, last_name), salary, PF of the employees (PF is calculated as 15% of salary).
SELECT first_name, last_name, salary, salary * 0.15 AS "PF"
FROM employees

--5. Write a query to get the names (first_name, last_name), salary, PF of the employees if PF is greater than 10000.
SELECT first_name, last_name, salary, salary * 0.15 AS "PF"
FROM employees
WHERE (salary * 0.15 > 10000);

--6. Write a query to get the list of employees and full information of their department 
SELECT e.*, d.*
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id;

--7. Write a query to calculate 171*214+625.
SELECT 171*214+625 AS result

--8. Write a query to get the names (for example Ellen Abel, Sundar Ande etc.) of all the employees from employees table.
SELECT first_name || ' ' || last_name AS name
FROM employees

--9. Write a query to get first name from employees table after removing white spaces from both side. 
SELECT TRIM(first_name) AS trimmed_first_name
FROM employees

--10. Write a query to select first 10 records from a table. 
SELECT * FROM employees
LIMIT 10;

/* 11. Write a query to get monthly salary (round 2 decimal places) of each employee
Note : Assume the salary field provides the 'annual salary' information. */
SELECT ROUND(salary / 12, 2) AS monthly_salary
FROM employees

--12. Write a query to get monthly salary (round 2 decimal places) of each employee if monthly salary is smaller than 5000 
SELECT ROUND(salary / 12, 2) AS monthly_salary
FROM employees
WHERE (salary / 12 < 5000);


--JOIN
--1. Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.
SELECT l.location_id, l.street_address, l.city, l.state_province, c.country_name
FROM locations l INNER JOIN countries c
ON l.country_id = c.country_id;

--2. Write a query to find the name (first_name, last name), department ID and department name of all the employees.
SELECT e.first_name || ' ' || e.last_name AS name,
	d.department_id, d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id;

--3. Write a query to find the name (first_name, last_name), job_title, department ID and department name of the employees who work in London.
SELECT e.first_name || ' ' || e.last_name AS name, j.job_title, d.department_id, d.department_name
FROM employees e 
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id WHERE l.city IN ('London');

--4. Write a query to find the employee id, name (last_name) along with their manager (manager_id, last_name).
SELECT e1.employee_id, e1.last_name AS name, e2.manager_id || ' - ' || e2.last_name AS manager
FROM employees e1 INNER JOIN employees e2
ON e1.manager_id = e2.manager_id;

--5. Write a query to find the name (first_name, last_name) and hire date of the employees who were hired after 'Jones'.
SELECT e1.first_name || ' ' || e1.last_name AS name, e1.hire_date
FROM employees e1 INNER JOIN employees e2
ON e1.hire_date > e2.hire_date WHERE e2.first_name || ' ' || e2.last_name LIKE '%Jones%';

--6. Write a query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department having id 90.
SELECT e.employee_id, j.job_title, jh.end_date - jh.start_date AS job_duration_days
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN job_history jh ON e.job_id = jh.job_id
WHERE jh.department_id = 90;

--7. Write a query to display the department name, manager name, and city.
SELECT d.department_name, e.manager_id, l.city
FROM departments d
JOIN employees e ON d.manager_id = e.manager_id
JOIN locations l ON d.location_id = l.location_id;

--8. Write a query to display job title, employee (id, name), and the difference between the salary of the employee and minimum salary for the job.
SELECT j.job_title, e.employee_id || ' - ' || e.first_name || ' ' || e.last_name AS employee,
	e.salary - j.min_salary AS salary_difference
FROM employees e JOIN jobs j
ON e.job_id = j.job_id;

--9. Write a query to display the job history that was done by any employee who is currently drawing more than 10000 of salary.
SELECT jh.*
FROM job_history jh JOIN employees e
ON jh.job_id = e.job_id WHERE e.salary > 10000;