-----Deliverable 1------------------------------

-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT employees.emp_no,
	employees.first_name,
employees.last_name
FROM employees;

 -- Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT titles.emp_no,
	titles.title,
 	titles.from_date,
titles.to_date
FROM titles;

-- Create a new table using the INTO clause.
SELECT employees.emp_no,
	employees.first_name,
employees.last_name
INTO info_of_emp
FROM employees;

SELECT titles.emp_no,
	titles.title,
 	titles.from_date,
titles.to_date
INTO emp_titles
FROM titles;

-- Join both tables on the primary key.
Select employees.emp_no,
	employees.first_name,
	employees.last_name,
	emp_titles.title,
	emp_titles.from_date,
emp_titles.to_date
FROM employees
JOIN emp_titles
ON employees.emp_no = emp_titles.emp_no;

--Filter the data on the birth_date column to retrieve the 
--employees who were born between 1952 and 1955. Then, order by the employee number.
Select employees.emp_no,
	employees.first_name,
	employees.last_name,
	emp_titles.title,
	emp_titles.from_date,
emp_titles.to_date
INTO retirement_titles
FROM employees
JOIN emp_titles
ON employees.emp_no = emp_titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, 
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE (retirement_titles.to_date = '9999-01-01')
ORDER BY retirement_titles.emp_no, retirement_titles.to_date DESC;

--Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(unique_titles.title), title
INTO retiring_titles
FROM unique_titles
GROUP BY unique_titles.title 
Order BY COUNT(title) DESC;


-----Deliverable 2----------------------------------

--Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
SELECT employees.emp_no,
	employees.first_name,
	employees.last_name,
birth_date
FROM employees;

--Retrieve the from_date and to_date columns from the Department Employee table.
SELECT dept_emp.from_date,
	dept_emp.to_date
FROM dept_emp;

--Retrieve the title column from the Titles table.
SELECT titles.title
FROM titles;

--Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.

SELECT DISTINCT ON (employees.emp_no) employees.emp_no, 
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	dept_emp.from_date,
	dept_emp.to_date,
	titles.title
INTO mentorship_eligibility
FROM employees
Join dept_emp
ON (employees.emp_no = dept_emp.emp_no)
Join titles
ON (employees.emp_no = titles.emp_no)
WHERE (dept_emp.to_date = '9999-01-01') 
	AND (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31') 
ORDER BY employees.emp_no;


