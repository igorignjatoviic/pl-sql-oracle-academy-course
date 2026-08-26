-- 1. exercise
CREATE OR REPLACE PROCEDURE find_dep(p_table_name IN VARCHAR2) AS
    v_query VARCHAR2(200);
    v_dep employees.department_id%TYPE;
    BEGIN
        v_query := '
            SELECT department_id 
            FROM ' || p_table_name || '
             WHERE manager_id = 205';
        
        EXECUTE IMMEDIATE v_query INTO v_dep;
        
        DBMS_OUTPUT.PUT_LINE(v_dep);
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            DBMS_OUTPUT.PUT_LINE('Data not found.');
    END find_dep;

BEGIN
    find_dep('departments');
END;

-- 2. exercise
CREATE OR REPLACE PROCEDURE del_countries AS
    v_query VARCHAR2(200);
    BEGIN
        v_query := 'DELETE FROM copy_countries';
        EXECUTE IMMEDIATE v_query;
        
        DBMS_OUTPUT.PUT_LINE('Rows deleted: ' || SQL%ROWCOUNT);
    END del_countries;
    
BEGIN
    del_countries;
END;

-- 3. exercise
CREATE OR REPLACE PACKAGE nocopy_test AS
TYPE EmpTabTyp IS TABLE OF employees%ROWTYPE;
emp_tab EmpTabTyp := EmpTabTyp(NULL);
PROCEDURE get_time (t OUT NUMBER);
PROCEDURE do_nothing1 (tab IN OUT EmpTabTyp);
PROCEDURE do_nothing2 (tab IN OUT NOCOPY EmpTabTyp);
END nocopy_test;
CREATE OR REPLACE PACKAGE BODY nocopy_test AS
PROCEDURE get_time (t OUT NUMBER) IS
BEGIN
t := DBMS_UTILITY.get_time;
END;
PROCEDURE do_nothing1 (tab IN OUT EmpTabTyp) IS
BEGIN
NULL;
END;
PROCEDURE do_nothing2 (tab IN OUT NOCOPY EmpTabTyp) IS
BEGIN
NULL;
END;
END nocopy_test;
DECLARE
t1 NUMBER;
t2 NUMBER;
t3 NUMBER;
BEGIN
SELECT * INTO nocopy_test.emp_tab(1) FROM EMPLOYEES
WHERE employee_id = 100;
nocopy_test.emp_tab.EXTEND(49999, 1); -- Copy element 1 into 2..50000
nocopy_test.get_time(t1);
nocopy_test.do_nothing1(nocopy_test.emp_tab); -- Pass IN OUT parameter
nocopy_test.get_time(t2);
nocopy_test.do_nothing2(nocopy_test.emp_tab); -- Pass IN OUT NOCOPY parameter
nocopy_test.get_time(t3);
DBMS_OUTPUT.PUT_LINE ('Call Duration (secs)');
DBMS_OUTPUT.PUT_LINE ('--------------------');
DBMS_OUTPUT.PUT_LINE ('Just IN OUT: ' || TO_CHAR((t2 - t1)/100.0));
DBMS_OUTPUT.PUT_LINE ('With NOCOPY: ' || TO_CHAR((t3 - t2))/100.0);
END;
