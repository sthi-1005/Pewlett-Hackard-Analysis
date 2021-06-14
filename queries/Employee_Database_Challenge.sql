-- SECTION 1: The Number of Retiring Employees by Title 
-- Obtain Retiring Employees by Title
SELECT e.emp_no,
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date

INTO retirement_titles
FROM employees as e
LEFT JOIN titles as ti on e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no asc;

 select * from retirement_titles;
--  drop table retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no asc, rt.to_date desc;

select * from unique_titles;
--  drop table unique_titles;

-- Retrieve # of employees by most recent job title who are about to retire
SELECT COUNT(emp_no) as count,
title
into retiring_titles
from unique_titles as ut

group by title
order by count desc
;
select * from retiring_titles;
-- DROP TABLE retiring_titles;


-- SECTION 2 
SELECT DISTINCT ON (emp_no)
e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title

INTO mentorship_eligibility
FROM employees as e

INNER JOIN dept_emp as de on de.emp_no = e.emp_no
INNER JOIN titles as ti on ti.emp_no = e.emp_no

WHERE (ti.to_date > now()) AND	(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
order by emp_no
;
select * from mentorship_eligibility;