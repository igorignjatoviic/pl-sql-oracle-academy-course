-- 1. exercise
CREATE OR REPLACE TRIGGER emp_log_trig
    AFTER INSERT ON my_employees
BEGIN
    INSERT INTO audit_table
    VALUES ('Inserting', 'Igor', SYSDATE);
END emp_log_trig;

-- 2. exercise
CREATE OR REPLACE TRIGGER emp_log_trig
    AFTER INSERT OR DELETE ON my_employees
BEGIN
    IF INSERTING THEN
        INSERT INTO audit_table
        VALUES ('Inserting', 'Igor', SYSDATE);
    ELSIF DELEING THEN
        DELETE FROM audit_table;
    END IF;
END emp_log_trig;

-- 3. exercise
CREATE TABLE dept_count
 AS SELECT department_id dept_id, count(*) count_emps
 FROM employees
 GROUP BY department_id;

CREATE VIEW emp_vu
AS SELECT employee_id, last_name, department_id
FROM employees;

CREATE OR REPLACE TRIGGER emp_trig
    INSTEAD OF INSERT OR DELETE ON emp_vu
BEGIN
    IF INSERTING THEN
        UPDATE dept_count
        SET count_emps = count_emps + 1
        WHERE :NEW.department_id = dept_id;
    ELSIF DELETING THEN
        UPDATE dept_count
        SET count_emps = count_emps - 1
        WHERE :OLD.department_id = dept_id;
    END IF;
END emp_trig;

-- 4. exercise
DROP TRIGGER emp_trig;