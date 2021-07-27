SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
INTO retirement_info
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Retirement eligibility
SELECT COUNT (first_name)
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as di
ON ri.emp_no = de.emp_no;


SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO 
	current_emp
FROM 
	retirement_info as ri
LEFT JOIN 
	dept_emp as de
ON 
	ri.emp_no = de.emp_no
WHERE
	de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT
	(ce.emp_no),
	de.dept_no
INTO
	dept_count
FROM 
	current_emp as ce
LEFT JOIN 
	dept_emp as de
ON 
	ce.emp_no = de.emp_no
GROUP BY 
	de.dept_no
ORDER BY
	de.dept_no;



-- Create employee info table
SELECT 
	e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO 
	emp_info
	 
FROM 
	employees as e
INNER JOIN
	salaries as s
ON 
	(e.emp_no = s.emp_no)
INNER JOIN 
	dept_emp as de
ON 
	(e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO 
	manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

-- List of department retirees
SELECT 
	ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

SELECT * FROM  dept_info;
-- Create a tailored list of people in the sales department
SELECT 
	di.emp_no,
	di.first_name,
	di.last_name,
	di.dept_name
INTO sales_dept
FROM 
	dept_info as di
WHERE
	di.dept_name = ('Sales');
-- Create a tailored list of people in the sales AND 
SELECT 
	di.emp_no,
	di.first_name,
	di.last_name,
	di.dept_name
INTO sales_dev_depts
FROM 
	dept_info as di
WHERE
	di.dept_name IN ('Sales', 'Development');	