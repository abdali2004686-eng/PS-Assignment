-- Q5: Employees hired after SCOTT
CREATE OR REPLACE FUNCTION F_HR_QUERY
RETURN SYS_REFCURSOR
IS
    employee_results SYS_REFCURSOR;
BEGIN
    OPEN employee_results FOR
        SELECT first_name || ' ' || last_name AS employee_name,
               hire_date
        FROM MyEmployee
        WHERE hire_date > (
            SELECT hire_date
            FROM MyEmployee
            WHERE UPPER(last_name) = 'SCOTT'
        )
        ORDER BY hire_date;
    RETURN employee_results;
END;
/

-- Run the function
DECLARE
    results SYS_REFCURSOR;
BEGIN
    results := F_HR_QUERY;
    DBMS_SQL.RETURN_RESULT(results);
END;
/

-- Q6: Copy employees
CREATE TABLE MyEmployee_update AS
SELECT * FROM MyEmployee WHERE 1 = 0;

CREATE OR REPLACE PROCEDURE P_COPY_EMPLOYEE
IS
BEGIN
    DELETE FROM MyEmployee_update;
    INSERT INTO MyEmployee_update SELECT * FROM MyEmployee;
END;
/

BEGIN
    P_COPY_EMPLOYEE;
END;
/
COMMIT;

-- Check row counts
SELECT COUNT(*) AS original_rows FROM MyEmployee;
SELECT COUNT(*) AS copied_rows FROM MyEmployee_update;
