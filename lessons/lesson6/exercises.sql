-- 1. exercise
DECLARE
    TYPE dep_type IS RECORD(
        dept_id departments.department_id%TYPE,
        dept_name departments.department_name%TYPE,
        mgr_id departments.manager_id%TYPE,
        loc_id departments.location_id%TYPE);
    v_dep_rec dep_type;
BEGIN
    SELECT department_id, department_name, manager_id, location_id
    INTO v_dep_rec.dept_id, v_dep_rec.dept_name, v_dep_rec.mgr_id, v_dep_rec.loc_id
    FROM departments
    WHERE department_id = 80;
    DBMS_OUTPUT.PUT_LINE(v_dep_rec.dept_id || ' ' || v_dep_rec.dept_name
        || ' ' || v_dep_rec.mgr_id || ' ' || v_dep_rec.loc_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('This department does not exist');
END;

-- 2. exercise
DECLARE
    TYPE t_count IS TABLE OF countries.country_name%TYPE
    INDEX BY BINARY_INTEGER;
    v_count_tab t_count;
BEGIN
    FOR rec IN (
        SELECT country_id, country_name
        FROM countries
        WHERE region_id = 5)
    LOOP
        v_count_tab(rec.country_id) := rec.country_name;
        
        DBMS_OUTPUT.PUT_LINE(rec.country_id || ' ' || rec.country_name);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Test: ' || v_count_tab(54));
END;

-- 3. exercise
DECLARE
    TYPE t_count IS TABLE OF countries.country_name%TYPE
    INDEX BY BINARY_INTEGER;
    v_count_tab t_count;
    i BINARY_INTEGER;
BEGIN
    FOR rec IN (
        SELECT country_id, country_name
        FROM countries
        WHERE region_id = 5
        ORDER BY country_id)
    LOOP
        v_count_tab(rec.country_id) := rec.country_name;
    END LOOP;
    
    i := v_count_tab.FIRST;
    WHILE i IS NOT NULL
    LOOP
        DBMS_OUTPUT.PUT_LINE('Index: ' || i || ' Value: ' || v_count_tab(i));
        i := v_count_tab.NEXT(i);
    END LOOP;
END;

-- 4. exercise
DECLARE
    CURSOR emp_cur IS
        SELECT * FROM employees
        ORDER BY employee_id ASC;
    
    TYPE t_emp IS TABLE OF employees%ROWTYPE
    INDEX BY BINARY_INTEGER;
    
    t_emp_rec t_emp;
BEGIN
    FOR rec in emp_cur
    LOOP
        t_emp_rec(rec.employee_id).last_name := rec.last_name;
        t_emp_rec(rec.employee_id).job_id := rec.job_id;
        t_emp_rec(rec.employee_id).salary := rec.salary;
    END LOOP;
END;

-- 5. exercise
DECLARE
    CURSOR emp_cur IS
        SELECT * FROM employees
        ORDER BY employee_id ASC;
    
    TYPE t_emp IS TABLE OF employees%ROWTYPE
    INDEX BY BINARY_INTEGER;
    
    t_emp_rec t_emp;
    i BINARY_INTEGER;
BEGIN
    FOR rec in emp_cur
    LOOP
        t_emp_rec(rec.employee_id).last_name := rec.last_name;
        t_emp_rec(rec.employee_id).job_id := rec.job_id;
        t_emp_rec(rec.employee_id).salary := rec.salary;
    END LOOP;
    
    i := t_emp_rec.FIRST;
    WHILE i IS NOT NULL
    LOOP
        DBMS_OUTPUT.PUT_LINE(t_emp_rec(i).last_name || ' '
            || t_emp_rec(i).job_id || ' '
            || t_emp_rec(i).salary);
        i := t_emp_rec.NEXT(i);
    END LOOP;
END;