# SQL assignment answers

Run the scripts in `sql/` in number order using Oracle FreeSQL.

## Concepts

**SQL and PL/SQL.** SQL defines tables and reads or changes data. PL/SQL is Oracle's extension to SQL for writing programs with variables, conditions, loops, functions, procedures, and error handling.

**DDL, DML, and DCL.** DDL defines database objects, for example `CREATE`, `ALTER`, and `DROP`. DML reads or changes table rows, for example `SELECT`, `INSERT`, `UPDATE`, and `DELETE`. DCL controls permissions with `GRANT` and `REVOKE`. `COMMIT` and `ROLLBACK` control transactions.

**JOINs.** `INNER JOIN` returns matching rows. `LEFT JOIN` keeps all rows from the left table and fills unmatched right-side columns with `NULL`; `RIGHT JOIN` does the reverse. `FULL OUTER JOIN` keeps rows from both sides. `CROSS JOIN` returns every combination. A self join matches rows in a table to other rows in that same table, such as an employee to their manager.

**RDBMS and NoSQL.** An RDBMS stores related data in tables and uses keys and SQL; Oracle and PostgreSQL are examples. NoSQL databases use other models, including documents, key-value pairs, graphs, and wide columns.

**Aggregate functions.** `COUNT` counts rows, `SUM` adds values, `AVG` finds the average, and `MIN` and `MAX` find the lowest and highest values. `GROUP BY` groups rows, and `HAVING` filters the results.

**Date and string functions.** Oracle date functions include `SYSDATE`, `ADD_MONTHS`, `MONTHS_BETWEEN`, and `TO_CHAR`. String functions include `UPPER`, `LOWER`, `SUBSTR`, `LENGTH`, and `TRIM`; `||` joins strings.

**Constraints and indexes.** A primary key identifies a row. `NOT NULL` prevents empty values. A foreign key links a row to another table, and `CHECK` sets a rule for allowed values. Indexes can make searches faster, but use space and need updating when the data changes.

## Questions

**Q1.** `01_tables.sql` creates `MyDepartment`, `Gender`, `University`, and `MyEmployee`. The tables have primary key, not-null, foreign-key, and check constraints. `manager_id` and `job_title` are included for the later questions.

**Q2.** The query in `03_queries.sql` joins the employee table to department, gender, university, and itself for the manager. Left joins keep employees who do not have a manager or university.

**Q3.** The query excludes employees in the Sales department or with the Sales job title, groups the remaining rows by job title, and returns totals above $2,500. With the supplied data, Manager totals $4,000 and Developer totals $3,700.

**Q4.** In the standard Oracle `EMP` table, the four errors are `salary` instead of the column `sal`, `x` instead of the multiplication operator `*`, the unquoted two-word alias, and the semicolon before `FROM`. Corrected statement:

```sql
SELECT empno, ename, sal * 12 AS "ANNUAL SALARY"
FROM emp;
```

**Q5.** `04_plsql.sql` defines `F_HR_QUERY`, which returns employees hired after SCOTT as a cursor containing their names and hire dates. The sample result is Laila Khalil, hired 15-MAR-1990.

**Q6.** `04_plsql.sql` creates `MyEmployee_update` and defines `P_COPY_EMPLOYEE` to copy the rows from `MyEmployee`. The procedure clears the destination before copying. With the sample data, both tables then contain four rows.

The scripts use Oracle SQL and PL/SQL. The Linux task separately installs MySQL; Oracle PL/SQL code does not run unchanged in MySQL.
