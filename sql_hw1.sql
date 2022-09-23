
CREATE TABLE departments (
	--id SERIAL PRIMARY KEY,
    dept_no varchar(20) NOT NULL,
	PRIMARY KEY (dept_no),
    dept_name varchar(20) NOT NULL
)

CREATE TABLE dept_emp (
	--id SERIAL PRIMARY KEY,
    emp_no varchar(20) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
    dept_no varchar(20) NOT NULL
)

CREATE TABLE dept_manager (
	--id SERIAL PRIMARY KEY,
    dept_no varchar(20) NOT NULL,
	emp_no varchar(20) NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
)

CREATE TABLE employees (
	--id SERIAL PRIMARY KEY,
    emp_no varchar(20) NOT NULL,
    emp_title_id varchar(20) NOT NULL,
    birth_date varchar(20) NOT NULL,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    sex varchar(1) NOT NULL,
    hire_date varchar(20) NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
)

CREATE TABLE salaries (
	--id SERIAL PRIMARY KEY,
    emp_no varchar(20) NOT NULL,
    salary int NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
)

CREATE TABLE titles (
	--id SERIAL PRIMARY KEY,
    title_id varchar(10) NOT NULL,
    title varchar(50) NOT NULL,
	PRIMARY KEY (title_id)
	
)



--List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
LEFT OUTER JOIN salaries s on e.emp_no=s.emp_no

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986%'

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT  d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_manager dm ON e.emp_no=dm.emp_no
LEFT OUTER JOIN departments d ON dm.dept_no=d.dept_no

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
LEFT OUTER JOIN dept_emp de ON e.emp_no=de.emp_no
LEFT OUTER JOIN departments d ON d.dept_no=de.dept_no

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name='Hercules' AND last_name LIKE 'B%'

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT  e.emp_no, e.last_name, e.first_name 
FROM employees e
LEFT OUTER JOIN dept_emp de ON e.emp_no=de.emp_no
LEFT OUTER JOIN departments d ON d.dept_no=de.dept_no
WHERE d.dept_no='d007'

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT  e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
LEFT OUTER JOIN dept_emp de ON e.emp_no=de.emp_no
LEFT OUTER JOIN departments d ON d.dept_no=de.dept_no
WHERE d.dept_no='d007' OR d.dept_no='d005'

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(*)
FROM employees 
GROUP BY last_name ORDER BY COUNT DESC