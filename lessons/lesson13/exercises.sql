-- 1. exercise
CREATE OR REPLACE TRIGGER emp_log_trig
    AFTER INSERT ON my_employees
BEGIN
    INSERT INTO audit_table
    VALUES ('Inserting', 'Igor', SYSDATE);
END emp_log_trig;