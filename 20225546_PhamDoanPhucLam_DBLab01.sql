CREATE TABLE job_grades (
    grade_level VARCHAR(2),
    lowest_sal INT,
    highest_sal INT,
    PRIMARY KEY (grade_level)
);

CREATE TABLE jobs (
    job_id VARCHAR(10),
    job_title VARCHAR(35),
    min_salary INT,
    max_salary INT,
    PRIMARY KEY (job_id)
);

CREATE TABLE regions (
    region_id INT,
    region_name VARCHAR(25),
    PRIMARY KEY (region_id)
);

CREATE TABLE countries (
    country_id char(2),
    country_name VARCHAR(40),
    region_id INT,
    PRIMARY KEY(country_id),
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE locations (
    location_id INT,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(25),
    country_id char(2),
    PRIMARY KEY (location_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE departments (
    department_id INT,
    department_name VARCHAR(30),
    manager_id INT,
    location_id INT,
    PRIMARY KEY (department_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    email VARCHAR(25),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary INT,
    commission_pct NUMERIC(18,3),
    manager_id INT,
    department_id INT,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE job_history (
    employee_id INT,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id INT,
    PRIMARY KEY (employee_id, start_date),
	FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments (department_id)
);
