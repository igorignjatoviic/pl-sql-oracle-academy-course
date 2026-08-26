-- 1. exericse
SELECT object_name
FROM user_objects
WHERE object_type = 'PACKAGE';

-- 2. exercise
CREATE OR REPLACE PACKAGE check_emp_pkg AS
    g_max_length_of_service NUMBER(38);
    PROCEDURE chk_hiredate(p_var1 IN employees.hire_date%TYPE);
    PROCEDURE chk_dept_mgr(
        p_var1 IN employees.employee_id%TYPE,
        p_var2 IN employees.manager_id%TYPE);
END check_emp_pkg;

CREATE OR REPLACE PACKAGE BODY check_emp_pkg AS
    PROCEDURE chk_hiredate(p_var1 IN employees.hire_date%TYPE) IS
    BEGIN
        IF p_var1 < SYSDATE - 365 * 100
        THEN
            RAISE_APPLICATION_ERROR(-20201, 'Hiredate Too Old');
        END IF;
    END chk_hiredate;
    
    PROCEDURE chk_dept_mgr(
        p_var1 IN employees.employee_id%TYPE,
        p_var2 IN employees.manager_id%TYPE) AS
        
        v_name employees.first_name%TYPE;
    BEGIN
        SELECT e.first_name INTO v_name
        FROM employees e
        INNER JOIN departments d
        ON e.department_id = d.department_id
        WHERE e.manager_id = p_var2;
        
        IF SQL%NOTFOUND
        THEN
            RAISE_APPLICATION_ERROR(-20202, 'Not found');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Success');
        END IF;
    END chk_dept_mgr;
END check_emp_pkg;

-- 3. exercise
CREATE OR REPLACE PACKAGE hellofrom AS
    PROCEDURE proc1;
    PROCEDURE proc2;
    PROCEDURE proc3;
END hellofrom;

CREATE OR REPLACE PACKAGE BODY hellofrom AS
    PROCEDURE proc1 IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Hello from 1.');
        proc2;
    END proc1;
    
    PROCEDURE proc2 IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Hello from 2.');
        proc3;
    END proc2;
    
    PROCEDURE proc3 IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Hello from 3.');
    END proc3;
END hellofrom;

BEGIN
    hellofrom.proc3;
END;

-- 4. exercise
CREATE OR REPLACE PACKAGE overload AS
    PROCEDURE what_am_i(p_in IN VARCHAR2);
    PROCEDURE what_am_i(p_in IN NUMBER);
    PROCEDURE what_am_i(p_in IN DATE);
END overload;

CREATE OR REPLACE PACKAGE BODY overload AS
    PROCEDURE what_am_i(p_in IN VARCHAR2) AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Varhcar2');
    END what_am_i;
    
    PROCEDURE what_am_i(p_in IN NUMBER) AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Number');
    END what_am_i;
    
    PROCEDURE what_am_i(p_in IN DATE) AS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Date');
    END what_am_i;
END overload;

BEGIN
    overload.what_am_i(1);
END;