-- 1. exercise
CREATE OR REPLACE PACKAGE cursor_state AS
    CURSOR cur IS
        SELECT e.first_name, e.last_name, 
            d.department_name, e.salary
        FROM employees e INNER JOIN departments d
        ON e.department_id = d.department_id;
    PROCEDURE open_cur;
    PROCEDURE fetch_n_rows(p_n IN NUMBER);
    PROCEDURE close_cur;
END cursor_state;

CREATE OR REPLACE PACKAGE BODY cursor_state AS
    PROCEDURE open_cur AS
        BEGIN
            IF NOT cur%ISOPEN
            THEN
                OPEN cur;
            END IF;
        END open_cur;
    
    PROCEDURE fetch_n_rows(p_n IN NUMBER) AS
        v_first_name employees.first_name%TYPE;
        v_last_name employees.last_name%TYPE;
        v_dep_name departments.department_name%TYPE;
        v_salary employees.salary%TYPE;
        BEGIN
            FOR i IN 1 .. p_n
            LOOP
                FETCH cur INTO v_first_name, v_last_name, v_dep_name, v_salary;
                IF cur%NOTFOUND THEN EXIT;
                END IF;
                
                DBMS_OUTPUT.PUT_LINE(v_first_name || ' ' ||
                    v_last_name || ' ' ||
                    v_dep_name || ' ' ||
                    v_salary);
            END LOOP;
        END fetch_n_rows;
    
    PROCEDURE close_cur AS
        BEGIN
            IF cur%ISOPEN
            THEN
                CLOSE cur;
            END IF;
        END close_cur;
END cursor_state;

BEGIN
    cursor_state.open_cur;
    cursor_state.fetch_n_rows(3);
    cursor_state.close_cur;
END;

-- 2. exercise
CREATE OR REPLACE PROCEDURE display_emp_names AS
    CURSOR names IS
        SELECT last_name
        FROM employees
        WHERE department_id = 80;
BEGIN
    FOR name IN names
    LOOP
        DBMS_OUTPUT.PUT(name.last_name || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
END display_emp_names;

BEGIN
    display_emp_names;
END;

-- 3. exercise
CREATE OR REPLACE PROCEDURE display_emp_names(p_out OUT VARCHAR2) AS
    CURSOR names IS
        SELECT last_name
        FROM employees
        WHERE department_id = 80;
    v_status NUMBER(1);
BEGIN
    FOR name IN names
    LOOP
        DBMS_OUTPUT.PUT(name.last_name || ' ');
    END LOOP;
    
    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.GET_LINE(p_out, v_status);
END display_emp_names;

DECLARE
    v_in VARCHAR2(100) := 'hello';
BEGIN
    display_emp_names(v_in);
    DBMS_OUTPUT.PUT_LINE('New output: ' || v_in);
END;