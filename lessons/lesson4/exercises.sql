-- 1. exercise
DECLARE
    v_country_id countries.country_id%TYPE := 91;
    v_country_name countries.country_name%TYPE;
    v_population countries.population%TYPE;
BEGIN
    SELECT country_id, country_name, population
    INTO v_country_id, v_country_name, v_population
    FROM countries
    WHERE v_country_id = country_id;
    
    IF v_population < 1000000000
    THEN
        DBMS_OUTPUT.PUT_LINE('Population of ' || v_country_name || ' is less than billion.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Population of ' || v_country_name || ' is more than billion.');
    END IF;
END;

-- 2. exercise
DECLARE
    v_country_id countries.country_id%TYPE := 15;
    v_country_name countries.country_name%TYPE;
    v_population countries.population%TYPE;
BEGIN
    SELECT country_id, country_name, population
    INTO v_country_id, v_country_name, v_population
    FROM countries
    WHERE v_country_id = country_id;
    
    IF v_population > 1000000000
    THEN
        DBMS_OUTPUT.PUT_LINE('Population of ' || v_country_name || ' is greater than billion.');
    ELSIF v_population > 0
    THEN
        DBMS_OUTPUT.PUT_LINE('Population of ' || v_country_name || ' is greater than than zero.');
    ELSIF v_population = 0
    THEN
        DBMS_OUTPUT.PUT_LINE('Population of ' || v_country_name || ' is zero.');
    ELSIF v_population IS NULL
    THEN
        DBMS_OUTPUT.PUT_LINE('No data for this country.');
    END IF;
END;

-- 3. exercise
DECLARE
    v_year NUMBER(4) := 2028;
BEGIN
    IF MOD(v_year, 4) = 0 AND MOD(v_year, 100) <> 0
    THEN
        DBMS_OUTPUT.PUT_LINE('Leap year.');
    ELSIF MOD(v_year, 400) = 0
    THEN
        DBMS_OUTPUT.PUT_LINE('Leap year.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Not a leap year.');
    END IF;
END;

-- 4. exercise
DECLARE
    v_country_id countries.country_id%TYPE;
    v_country_name countries.country_name%TYPE;
    v_counter NUMBER := 1;
BEGIN
    LOOP
        SELECT country_id, country_name
        INTO v_country_id, v_country_name
        FROM countries
        WHERE v_counter = country_id;
        v_counter := v_counter + 1;
        
        DBMS_OUTPUT.PUT_LINE(v_country_id || ' ' || v_country_name);
        
        IF v_counter > 3 THEN EXIT;
        END IF;
    END LOOP;
END;

-- 5. exercise
DECLARE
    v_counter NUMBER(2) := 1;
BEGIN
    LOOP
        IF v_counter NOT IN (6, 8)
        THEN
            INSERT INTO messages
            VALUES (v_counter);
        END IF;
        
        v_counter := v_counter + 1;
        IF v_counter > 10 THEN EXIT;
        END IF;
    END LOOP;
END;

-- 6. exercise
DECLARE
    v_country_id countries.country_id%TYPE;
    v_country_name countries.country_name%TYPE;
    v_counter NUMBER(2) := 51;
BEGIN
    WHILE v_counter < 56 LOOP
        SELECT country_id, country_name
        INTO v_country_id, v_country_name
        FROM countries
        WHERE country_id = v_counter;
        
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_country_id || ' Country: ' || v_country_name);
        
        v_counter := v_counter + 1;
    END LOOP;
END;

-- 7. exercise
DECLARE
    v_country_id countries.country_id%TYPE;
    v_country_name countries.country_name%TYPE;
BEGIN
    FOR i IN REVERSE 51..55 LOOP
        SELECT country_id, country_name
        INTO v_country_id, v_country_name
        FROM countries
        WHERE country_id = i;
        
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_country_id || ' Country: ' || v_country_name);
    END LOOP;
END;

-- 8. exercise
DECLARE
    v_emp_id new_emps.employee_id%TYPE := 200;
    v_emp_salary new_emps.salary%TYPE;
    v_stars VARCHAR2(50) := '';
    v_length NUMBER(3) := 0;
BEGIN
    SELECT employee_id, salary
    INTO v_emp_id, v_emp_salary
    FROM new_emps
    WHERE v_emp_id = employee_id;
    
    v_length := v_emp_salary / 1000;
    
    FOR i IN 1..v_length LOOP
        v_stars := v_stars || '*';
    END LOOP;
    
    UPDATE new_emps
    SET stars = v_stars
    WHERE employee_id = v_emp_id;
END;

-- 9. exercise
DECLARE
    v_plate VARCHAR2(7) := '';
BEGIN
    FOR i IN 60..65 LOOP
        FOR j IN 100..110 LOOP
            v_plate := i || '-' || j;
            DBMS_OUTPUT.PUT_LINE(v_plate);
        END LOOP;
    END LOOP;
END;

-- 10. exercise
DECLARE
    v_sum NUMBER(3) := 0;
BEGIN
    <<outer>>
    FOR i IN 60..65 LOOP
        <<inner>>
        FOR j IN 100..110 LOOP
            v_sum := i + j;
            DBMS_OUTPUT.PUT_LINE(v_sum);
            
            IF v_sum > 172
            THEN
                DBMS_OUTPUT.PUT_LINE('Greater than 172!');
                EXIT outer;
            END IF;
        END LOOP;
    END LOOP;
END;