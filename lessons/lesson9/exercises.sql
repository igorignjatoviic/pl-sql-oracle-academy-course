-- 1. exercise
CREATE OR REPLACE FUNCTION full_name (
    first_name employees.first_name%TYPE,
    last_name employees.last_name%TYPE)
RETURN VARCHAR2 AS
    output VARCHAR2(100);
BEGIN
    output := (last_name || ', ' || first_name);
    RETURN output;
END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(full_name('Igor', 'Ignjatovic'));
END;

-- 2. exercise
CREATE OR REPLACE FUNCTION divide (
    first_num NUMBER,
    second_num NUMBER)
RETURN NUMBER AS
    output NUMBER;
BEGIN
    IF second_num = 0 THEN
        RAISE ZERO_DIVIDE;
    END IF;

    output := ROUND(first_num / second_num);
    RETURN output;
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Can not divide with zero');
        RETURN 0;
END;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Division: ' || divide(4, 0));
END;

-- 3. exercise
CREATE OR REPLACE FUNCTION reverse (
    input VARCHAR2)
RETURN VARCHAR2 AS
    output VARCHAR2(100);
BEGIN
    output := '';
    FOR i IN REVERSE 1 .. LENGTH(input)
    LOOP
        output := output || SUBSTR(input, i, 1);
    END LOOP;
    
    RETURN output;
END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(reverse('Igor'));
END;

-- 4. exercise
CREATE OR REPLACE FUNCTION sal_increase (
    p_salary f_emps.salary%TYPE,
    p_percent_incr NUMBER)
RETURN NUMBER AS
BEGIN
    RETURN (p_salary + (p_salary * p_percent_incr / 100));    
END;

SELECT last_name, sal_increase(salary, 5)
FROM f_emps
WHERE sal_increase(salary, 5) > 10000
ORDER BY sal_increase(salary, 5) DESC;

-- 5. exercise
SELECT department_id, sal_increase(SUM(salary), 5)
FROM f_emps
GROUP BY department_id
HAVING sal_increase(SUM(salary), 5) > 20000;

-- 6. exercise
CREATE OR REPLACE PROCEDURE add_my_dept
 (p_dept_id IN VARCHAR2, p_dept_name IN VARCHAR2) IS
BEGIN
 INSERT INTO my_depts (department_id, department_name)
 VALUES (p_dept_id, p_dept_name);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Department with this id already exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Other exception.');
END add_my_dept;

BEGIN
    add_my_dept(10, 'sta_god');
END;