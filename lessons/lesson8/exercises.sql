-- 1. exercise
CREATE OR REPLACE PROCEDURE name_change IS
BEGIN
 UPDATE employees_dup
 SET first_name = 'Susan'
 WHERE department_id = 80;
END name_change;

BEGIN
 name_change;
END;

SELECT * FROM employees_dup
WHERE department_id = 80;

-- 2. exercises
CREATE OR REPLACE PROCEDURE pay_raise AS
BEGIN
    UPDATE employees_dup
    SET salary = 30000;
END;

BEGIN
    pay_raise;
END;

SELECT * FROM employees_dup;

-- 3. exercise
CREATE OR REPLACE PROCEDURE update_salary AS
    CURSOR emp_cur IS
        SELECT * FROM employees_dup
        FOR UPDATE NOWAIT;
BEGIN
    FOR rec in emp_cur
    LOOP
        IF rec.department_id = 80 THEN
            UPDATE employees_dup
            SET salary = 1000
            WHERE CURRENT of emp_cur;
        ELSIF rec.department_id = 50 THEN
            UPDATE employees_dup
            SET salary = 2000
            WHERE CURRENT of emp_cur;
        ELSE
            UPDATE employees_dup
            SET salary = 3000
            WHERE CURRENT of emp_cur;
        END IF;
    END LOOP;
END;

BEGIN
    update_salary;
END;

SELECT * FROM employees_dup WHERE department_id = 80;

-- 4. exercise
CREATE OR REPLACE PROCEDURE get_country_info(p_country_id IN NUMBER) AS
    v_country_name countries.country_name%TYPE;
BEGIN
    SELECT country_name INTO v_country_name
    FROM countries
    WHERE country_id = p_country_id;
    
    DBMS_OUTPUT.PUT_LINE(v_country_name);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
END;

BEGIN
    get_country_info(95);
END;

-- 5. exercise
CREATE OR REPLACE PROCEDURE country_counter(p_region_id IN NUMBER, 
        p_elev_value IN NUMBER) AS
    v_counter NUMBER(3);
BEGIN
    SELECT COUNT(*) INTO v_counter
    FROM countries
    WHERE region_id = p_region_id AND highest_elevation > p_elev_value;
    
    DBMS_OUTPUT.PUT_LINE(v_counter);
END;

BEGIN
    country_counter(5, 2000);
END;

-- 6. exercise
-- procedures exercises not done...