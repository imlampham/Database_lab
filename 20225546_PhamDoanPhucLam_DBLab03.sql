--Function Date and Time
--1. Write a query to get the first name and hire date from the employees table where hire date is between '1987-06-01' and '1987-07-30'.
SELECT first_name, hire_date FROM employees 
WHERE hire_date BETWEEN '1987-06-01' AND '1987-07-30';

--2. Write a query to get the first name, last name who joined in the month of June.
SELECT first_name, last_name FROM employees
WHERE EXTRACT(MONTH FROM hire_date) = '06';

--3. Write a query to get the first name of employees who joined in 1987.
SELECT first_name FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = '1987';

--4. Write a query to get department name, manager name, and salary of the manager for all managers whose experience is more than 5 years.
SELECT d.department_name, e.manager_id, e.salary
FROM employees e JOIN departments d
ON e.manager_id = d.manager_id
WHERE AGE(CURRENT_DATE, e.hire_date) > INTERVAL '5 years';

--5. Write a query to get an employee’s ID, last name, and date of first salary of the employees (assuming employees receive salary on the first day of the next month).
SELECT employee_id, last_name, 
	(DATE_TRUNC('MONTH', hire_date) + INTERVAL '1 MONTH') :: DATE as date_of_first_salary
FROM employees

--6. Write a query to get first name, hire date and years of experience of the employees.
SELECT first_name, hire_date, EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) AS years_of_experience
FROM employees

--7. Write a query to get the different department IDs, hire years, and number of employees who have joined corresponding department in corresponding year.
SELECT department_id, 
       EXTRACT(YEAR FROM hire_date) AS hire_year, 
       COUNT(employee_id) AS number_of_employees
FROM employees
GROUP BY department_id, hire_year
ORDER BY department_id, hire_year;

--Function String
--1. Write a query to get every phone number in the employees table, within the phone number the substring ‘124’ will be replaced by ‘999’.
SELECT REPLACE(phone_number, '124', '999') AS updated_phone_number 
FROM employees

--2. Write a query to append '@example.com' to email field.
SELECT email || '@example.com' AS updated_email 
FROM employees

--3. Write a query to get the employee id, name (first name + last name) and hire month.
SELECT employee_id, first_name || ' ' || last_name AS name, EXTRACT(MONTH FROM hire_date) AS hire_month
FROM employees

--4. Write a query to get the employee id, email id (discard the last three characters).
SELECT employee_id, LEFT(email, LENGTH(email) - 3) AS email_id
FROM employees

--5. Write a query to find all employees where first names are in the upper case.
SELECT * FROM employees
WHERE first_name = UPPER(first_name);

--6. Write a query to extract the last 4 characters of phone numbers.
SELECT RIGHT(phone_number, 4) AS result
FROM employees

--7. Write a query to get the last word of the street address.
SELECT RIGHT(street_address, 1) AS result
FROM locations

--8. Write a query to get the locations that have minimum street address length.
SELECT * FROM locations
WHERE LENGTH(street_address) = (
	SELECT MIN(LENGTH(street_address))
	FROM locations);

--9. Write a query to display the first word from those job titles which contain more than one word.
SELECT SPLIT_PART(job_title, ' ', 1) AS first_word
FROM jobs
WHERE job_title LIKE '% %';

--10. Write a query to display the length of first name for employees where the last name contains character 'c' after 2nd position.
SELECT LENGTH(first_name) FROM employees
WHERE last_name LIKE '__%c%';

--11. Write a query that displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Sort the results by the employees' first names.
SELECT first_name, LENGTH(first_name) FROM employees
WHERE first_name LIKE 'A%' 
	OR first_name LIKE 'J%' 
	OR first_name LIKE 'M%'
ORDER BY first_name;

--12. Write a query to display the first name and salary for all employees. Format the salary to be 10 characters long, left-padded with the $ symbol. Label the column SALARY.
SELECT first_name, LPAD(salary::text, 10, '$') AS SALARY
FROM employees

--13. Write a query to display the first eight characters of the employees' first names and indicate the amounts of their salaries with '$' sign. Each '$' sign signifies a thousand dollars. Sort the data in descending order of salary.
SELECT SUBSTR(first_name, 1, 8) AS first_name,
       REPEAT('$', salary / 1000) AS salary_representation
FROM employees
ORDER BY salary DESC;

--14. Write a query to display the employees with their code, first name, last name and hire date who hired either on seventh day of any month or seventh month in any year.
SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(DAY FROM hire_date) = '07'
	OR EXTRACT(MONTH FROM hire_date) = '07';