
-- Create a table of employees born between 1952 and 1955 with their respective titles
SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	ts.title,
	ts.from_date,
	ts.to_date
INTO retirement_titles
FROM
	employees as e
INNER JOIN
	titles as ts
ON 
	(e.emp_no = ts.emp_no)
WHERE 
	(birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY
	e.emp_no;
	
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON 
(rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- Create a count of people retiring by title
SELECT
	COUNT(ut.title),
	ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;


-- Create a Mentorship Eligibility table.
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ts.title
INTO mentorship_eligibilty
FROM employees as e
LEFT OUTER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
LEFT OUTER JOIN titles as ts
	ON (e.emp_no = ts.emp_no)
WHERE
	(e.birth_date BETWEEN '01-01-1965' AND '12-31-1965')
AND
	(de.to_date = '9999-01-01')	
ORDER BY e.emp_no;

