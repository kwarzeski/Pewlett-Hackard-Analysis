SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date, e.birth_date 
INTO retirement_titles
FROM "Employees" as e
LEFT JOIN titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON(emp_no) emp_no, 
first_name, 
last_name, 
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT COUNT(emp_no), title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

SELECT DISTINCT ON(emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title  
INTO mentorship_eligibilty
FROM "Employees" AS e
JOIN  dept_emp AS de
ON e.emp_no = de.emp_no
JOIN titles as t
on e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01' AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp_no, t.to_date DESC