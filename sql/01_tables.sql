-- ProgressSoft assignment, SQL Q1. Run once in a fresh Oracle schema.
-- manager_id and job_title support Q2 and Q3.

CREATE TABLE MyDepartment (
    dept_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL
);

CREATE TABLE Gender (
    gender_id NUMBER PRIMARY KEY,
    name VARCHAR2(30) NOT NULL
);

CREATE TABLE University (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(150) NOT NULL
);

CREATE TABLE MyEmployee (
    id NUMBER PRIMARY KEY,
    last_name VARCHAR2(100) NOT NULL,
    first_name VARCHAR2(100) NOT NULL,
    hire_date DATE NOT NULL,
    userid NUMBER NOT NULL,
    salary NUMBER(10,2) NOT NULL,
    dept_id NUMBER NOT NULL,
    gender_id NUMBER NOT NULL,
    university_id NUMBER,
    manager_id NUMBER,
    job_title VARCHAR2(100) NOT NULL,
    emp_image BLOB,
    CONSTRAINT chk_employee_salary CHECK (salary >= 0),
    CONSTRAINT fk_employee_department FOREIGN KEY (dept_id)
        REFERENCES MyDepartment(dept_id),
    CONSTRAINT fk_employee_gender FOREIGN KEY (gender_id)
        REFERENCES Gender(gender_id),
    CONSTRAINT fk_employee_university FOREIGN KEY (university_id)
        REFERENCES University(id),
    CONSTRAINT fk_employee_manager FOREIGN KEY (manager_id)
        REFERENCES MyEmployee(id)
);
