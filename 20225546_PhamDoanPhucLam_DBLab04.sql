--Restricting and Sorting data
--1. Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000.
SELECT first_name || ' ' || last_name AS name, salary
FROM employees WHERE salary NOT BETWEEN 10000 AND 15000;

--2. Write a query to display the name (first_name, last_name) and department ID of all employees in departments 30 or 100 in ascending order.
SELECT first_name || ' ' || last_name AS name, department_id
FROM employees WHERE department_id IN (30, 100)
ORDER BY department_id;

--3. Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100.
SELECT first_name || ' ' || last_name AS name, salary
FROM employees WHERE salary NOT BETWEEN 10000 AND 15000
AND department_id IN (30, 100);

--4. Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987.
SELECT first_name || ' ' || last_name AS name, hire_date
FROM employees WHERE EXTRACT(YEAR FROM hire_date) = 1987;

--5. Write a query to display the first_name of all employees who have both "b" and "c" in their first name.
SELECT first_name FROM employees
WHERE first_name ILIKE '%b%' AND first_name ILIKE '%c%';

--6. Write a query to display the last name, job, and salary for all employees whose job is that of a Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000.
SELECT e.last_name, j.job_title, e.salary
FROM employees e JOIN jobs j
ON e.job_id = j.job_id
WHERE j.job_title IN ('Programmer', 'Shipping Clerk')
AND e.salary NOT IN (4500, 10000, 15000);

--7. Write a query to display the last name of employees whose names have exactly 6 characters.
SELECT last_name FROM employees
WHERE LENGTH(last_name) = 6;

--8. Write a query to display the last name of employees having 'e' as the third character.
SELECT last_name FROM employees
WHERE last_name LIKE '__e%';

--9. Write a query to display the jobs/designations available in the employees table.
SELECT DISTINCT j.job_title 
FROM employees e JOIN jobs j
ON e.job_id = j.job_id;

--10. Write a query to display the name (first_name, last_name), salary and PF (15% of salary) of all employees.
SELECT first_name || ' ' || last_name AS name, salary, salary * 0.15 AS PF
FROM employees

--11. Write a query to select all record from employees where last name in 'BLAKE', 'SCOTT', 'KING' and 'FORD'.
SELECT * FROM employees
WHERE last_name IN ('Blake', 'Scott', 'King', 'Ford');


--Subquery
--1. Write a query to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Bull'.
SELECT first_name || ' ' || last_name AS name, salary
FROM employees WHERE salary > (
	SELECT salary FROM employees
	WHERE last_name = 'Bull');

--2. Write a query to find the name (first_name, last_name) of all employees who work in the IT department (‘IT’ is the name of the department).
SELECT e.first_name || ' ' || e.last_name AS name
FROM employees e
JOIN (
    SELECT department_id
    FROM departments
    WHERE department_name = 'IT') AS it_departments 
ON e.department_id = it_departments.department_id;

--3. Write a query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA based department (country_name is ‘United States of America’ and country_id is ‘US’).
SELECT e.first_name || ' ' || e.last_name AS name 
FROM employees e 
JOIN (
    SELECT d.department_id
    FROM departments d
    JOIN locations l ON d.location_id = l.location_id
    JOIN countries c ON l.country_id = c.country_id
    WHERE c.country_name = 'United States of America' AND c.country_id = 'US') AS usa_departments 
ON e.department_id = usa_departments.department_id
WHERE e.manager_id IS NOT NULL;

--4. Write a query to find the name (first_name, last_name) of the employees who are managers.
SELECT DISTINCT e.first_name || ' ' || e.last_name AS name
FROM employees e
WHERE e.employee_id IN (
    SELECT DISTINCT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL);

--5. Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary of all employees.
SELECT first_name || ' ' || last_name AS name, salary
FROM employees WHERE salary > (
	SELECT AVG(salary) FROM employees);

--6. Write a query to find the name (first_name, last_name), and salary of the employees who earn more than the average salary and works in any of the IT departments (they have name start with ‘IT’).
SELECT e.first_name || ' ' || e.last_name AS name, e.salary
FROM employees e JOIN (
    SELECT department_id
    FROM departments
    WHERE department_name = 'IT') AS it_departments 
ON e.department_id = it_departments.department_id
WHERE e.salary > (
	SELECT AVG(e.salary) FROM employees e);

--7. Write a query to find the name (first_name, last_name), and salary of the employees who earn more than the earning of Mr. Bell (Bell is his last name).
SELECT first_name || ' ' || last_name AS name, salary
FROM employees WHERE salary > (
	SELECT salary
    FROM employees
    WHERE last_name = 'Bell');

--8. Write a query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary of the corresponding departments they’re working at.
SELECT e.first_name || ' ' || e.last_name AS name, e.salary
FROM employees e
JOIN (
    SELECT department_id, MIN(salary) AS min_salary
    FROM employees
    GROUP BY department_id) AS dept_mins 
ON e.department_id = dept_mins.department_id AND e.salary = dept_mins.min_salary;

--9. Write a query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest.
SELECT first_name || ' ' || last_name AS name, salary
FROM employees 
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE job_id = 'SH_CLERK')
ORDER BY salary ASC;

--10. Write a query to find the name (first_name, last_name) of the employees who are not supervisors/managers.
SELECT first_name || ' ' || last_name AS name
FROM employees WHERE employee_id NOT IN (
    SELECT DISTINCT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL);

--11. Write a query to display the employee ID, first name, last name, salary of all employees whose salary is above average of their corresponding departments.
SELECT e.employee_id, e.first_name, e.last_name, e.salary
FROM employees e
INNER JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id) AS dept_avgs 
ON e.department_id = dept_avgs.department_id
WHERE e.salary > dept_avgs.avg_salary;

--12. Write a query to fetch even numbered records from employees table.
SELECT *
FROM employees
WHERE employee_id % 2 = 0;

--13. Write a query to find the 5th maximum salary in the employees table.
SELECT DISTINCT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rank
    FROM employees) AS rankTable
WHERE rank = 5;

--14. Write a query to find the 4th minimum salary in the employees table.
SELECT DISTINCT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary) AS rank
    FROM employees) AS rankTable
WHERE rank = 4;

--15. Write a query to select every record excep the last 10 records from employees table.
SELECT * FROM employees
ORDER BY employee_id
OFFSET 10;

--16. Write a query to list the department ID and name of all the departments where no employee is working.
SELECT department_id, department_name
FROM departments
WHERE department_id NOT IN (
    SELECT DISTINCT department_id
    FROM employees);

--17. Write a query to get 3 maximum salaries.
SELECT salary FROM employees
ORDER BY salary DESC
LIMIT 3;

--18. Write a query to get 3 minimum salaries.
SELECT salary FROM employees
ORDER BY salary
LIMIT 3;

--19. Write a query to get nth max salaries of employees.
SELECT DISTINCT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rank
    FROM employees) AS rankTable
WHERE rank = 6; --with n = 6
