-- Run after 01_tables.sql. Corrected first_name/last_name values.

INSERT INTO MyDepartment (dept_id, name) VALUES (1, 'IT');
INSERT INTO MyDepartment (dept_id, name) VALUES (2, 'Sales');

INSERT INTO Gender (gender_id, name) VALUES (1, 'Male');
INSERT INTO Gender (gender_id, name) VALUES (2, 'Female');

INSERT INTO University (id, name) VALUES (1, 'University of Jordan');
INSERT INTO University (id, name) VALUES (2, 'Yarmouk University');

INSERT INTO MyEmployee
(id, last_name, first_name, hire_date, userid, salary,
 dept_id, gender_id, university_id, manager_id, job_title)
VALUES
(1, 'SCOTT', 'John', DATE '1987-09-09', 101, 4000,
 1, 1, 1, NULL, 'Manager');

INSERT INTO MyEmployee
(id, last_name, first_name, hire_date, userid, salary,
 dept_id, gender_id, university_id, manager_id, job_title)
VALUES
(2, 'Ali', 'Ahmad', DATE '1980-10-10', 102, 1900,
 1, 1, 1, 1, 'Developer');

INSERT INTO MyEmployee
(id, last_name, first_name, hire_date, userid, salary,
 dept_id, gender_id, university_id, manager_id, job_title)
VALUES
(3, 'Hassan', 'Rami', DATE '1986-05-24', 103, 1600,
 2, 1, 2, 1, 'Sales');

INSERT INTO MyEmployee
(id, last_name, first_name, hire_date, userid, salary,
 dept_id, gender_id, university_id, manager_id, job_title)
VALUES
(4, 'Khalil', 'Laila', DATE '1990-03-15', 104, 1800,
 1, 2, 2, 1, 'Developer');

COMMIT;
