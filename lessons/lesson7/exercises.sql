-- 1. exception
DECLARE
    v_jobid employees.job_id%TYPE;
BEGIN
    SELECT job_id INTO v_jobid
    FROM employees
    WHERE department_id = 80;
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Server fetched more than 1 row.');
END;

-- 2. exercise
BEGIN
    INSERT INTO departments (department_id, department_name,
        manager_id, location_id)
    VALUES (50, 'A new department', 100, 1500);
    DBMS_OUTPUT.PUT_LINE('The new department was inserted');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE ('An exception has occurred.');
END;

-- 3. exercise
DECLARE
    v_number NUMBER(2);
BEGIN
    v_number := 9999;
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An exception has occurred');
END;

-- 4. exercise
DECLARE
    v_number NUMBER(4);
BEGIN
    v_number := 1234;
    DECLARE
        v_number NUMBER(4);
    BEGIN
        v_number := 5678;
        v_number := 'A character string';
    END;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An exception has occurred');
        DBMS_OUTPUT.PUT_LINE('The number is: ' || v_number);
END;

-- 5. excercise
DECLARE
    e_zero_division EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_zero_division, -1476);
    
    v_number NUMBER(6, 2) := 100;
    v_region_id regions.region_id%TYPE;
    v_region_name regions.region_name%TYPE;
BEGIN
    SELECT region_id, region_name INTO v_region_id, v_region_name
    FROM regions
    WHERE region_id = 29;
    DBMS_OUTPUT.PUT_LINE('Region: ' || v_region_id || ' is: ' || v_region_name);
    v_number := v_number / 0;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
    WHEN e_zero_division THEN
        DBMS_OUTPUT.PUT_LINE('Zero division.');
END;

-- 6. exercise
DECLARE
    e_cursor EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_cursor, -01001);

    CURSOR regions_curs IS
    SELECT * FROM regions
    WHERE region_id < 20
    ORDER BY region_id;
    regions_rec regions_curs%ROWTYPE;
    v_count NUMBER(6);
BEGIN
    LOOP
        FETCH regions_curs INTO regions_rec;
        EXIT WHEN regions_curs%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Region: ' || regions_rec.region_id
            || ' Name: ' || regions_rec.region_name);
    END LOOP;
    CLOSE regions_curs;
    SELECT COUNT(*) INTO v_count
    FROM regions
    WHERE region_id = 1;
    DBMS_OUTPUT.PUT_LINE('The number of regions is: ' || v_count);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
    WHEN e_cursor THEN
        DBMS_OUTPUT.PUT_LINE('Cursor not found.');
END;

-- 7. exercise
DECLARE
    CURSOR emp_cur(p_dep_id excep_emps.department_id%TYPE) IS
        SELECT * FROM employees
        WHERE department_id = p_dep_id
        FOR UPDATE NOWAIT;
    
    e_no_rows EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_no_rows, -01410);
BEGIN
    FOR rec in emp_cur(10)
    LOOP
        UPDATE excep_emps
        SET salary = 10000
        WHERE CURRENT OF emp_cur;
    END LOOP;
EXCEPTION
    WHEN e_no_rows THEN
        DBMS_OUTPUT.PUT_LINE('Too big.');
END;
