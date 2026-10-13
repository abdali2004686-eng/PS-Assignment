-- Q2: Employee details, including the manager's name.
SELECT
    e.first_name || ' ' || e.last_name AS employee_name,
    e.salary,
    d.name AS department_name,
    m.first_name || ' ' || m.last_name AS manager_name,
    g.name AS gender_name,
    u.name AS university_name
FROM MyEmployee e
JOIN MyDepartment d ON d.dept_id = e.dept_id
JOIN Gender g ON g.gender_id = e.gender_id
LEFT JOIN University u ON u.id = e.university_id
LEFT JOIN MyEmployee m ON m.id = e.manager_id
ORDER BY e.id;

-- Q3: Monthly payroll by job title, excluding sales employees.
SELECT
    e.job_title,
    SUM(e.salary) AS total_monthly_salary
FROM MyEmployee e
JOIN MyDepartment d ON d.dept_id = e.dept_id
WHERE UPPER(d.name) <> 'SALES'
  AND UPPER(e.job_title) <> 'SALES'
GROUP BY e.job_title
HAVING SUM(e.salary) > 2500
ORDER BY total_monthly_salary DESC;

-- Q4: Standard Oracle EMP uses SAL for the salary column.
-- Execute only if an EMP table with these columns exists.
-- SELECT empno, ename, sal * 12 AS "ANNUAL SALARY" FROM emp;
