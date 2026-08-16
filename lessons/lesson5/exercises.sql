-- 1. exercise
DECLARE
    CURSOR currencies_cur IS
        SELECT currency_code, currency_name
        FROM currencies
        ORDER BY currency_name ASC;
    v_currency_code currencies.currency_code%TYPE;
    v_currency_name currencies.currency_name%TYPE;
BEGIN
    OPEN currencies_cur;
    LOOP
        FETCH currencies_cur INTO v_currency_code, v_currency_name;
        DBMS_OUTPUT.PUT_LINE(v_currency_code || '   ' || v_currency_name);
        
        IF currencies_cur%NOTFOUND
        THEN EXIT;
        END IF;
    END LOOP;
    CLOSE currencies_cur;
END;

-- 2. exercise
DECLARE
    CURSOR countries_cur IS
        SELECT country_name, national_holiday_date, national_holiday_name
        FROM countries
        WHERE region_id = 5 AND national_holiday_date IS NOT NULL;
    v_country_name countries.country_name%TYPE;
    v_nat_hol_date countries.national_holiday_date%TYPE;
    v_nat_hol_name countries.national_holiday_name%TYPE;
BEGIN
    OPEN countries_cur;
    LOOP
        FETCH countries_cur INTO v_country_name, v_nat_hol_date, v_nat_hol_name;
        DBMS_OUTPUT.PUT_LINE(v_country_name || ' ' || v_nat_hol_date || ' ' || v_nat_hol_name);
        
        IF countries_cur%NOTFOUND
        THEN EXIT;
        END IF;
    END LOOP; 
END;

-- 3. exercise
DECLARE
    CURSOR region_cur IS
        SELECT r.region_name, COUNT(c.country_id)
        FROM regions r INNER JOIN countries c
        ON r.region_id = c.region_id
        GROUP BY r.region_name
        HAVING COUNT(c.country_id) > 9
        ORDER BY r.region_name ASC;
    v_region_name regions.region_name%TYPE;
    v_count NUMBER;
BEGIN
    OPEN region_cur;
    LOOP
        FETCH region_cur INTO v_region_name, v_count;
        DBMS_OUTPUT.PUT_LINE(v_region_name || ' ' || v_count);
        
        IF region_cur%NOTFOUND
        THEN EXIT;
        END IF;
    END LOOP;
    CLOSE region_cur;
END;

-- 4. exercise
DECLARE
    CURSOR countries_cur IS
        SELECT country_name, national_holiday_date, national_holiday_name
        FROM countries
        WHERE region_id = 5 AND national_holiday_date IS NOT NULL;
    v_countries_record countries_cur%ROWTYPE;
BEGIN
    OPEN countries_cur;
    LOOP
        FETCH countries_cur INTO v_countries_record;
        DBMS_OUTPUT.PUT_LINE(v_countries_record.country_name || ' ' || 
           v_countries_record.national_holiday_date || ' ' || v_countries_record.national_holiday_name);
        
        IF countries_cur%NOTFOUND
        THEN EXIT;
        END IF;
    END LOOP; 
END;

-- 4. exercise
DECLARE
    CURSOR employees_cur IS
        SELECT * FROM employees
        ORDER BY salary;
    v_emp_record employees_cur%ROWTYPE;
BEGIN
    OPEN employees_cur;
    LOOP
        IF employees_cur%ROWCOUNT > 6
        THEN EXIT;
        END IF;
        
        FETCH employees_cur INTO v_emp_record;
        
        DBMS_OUTPUT.PUT_LINE(v_emp_record.first_name 
            || ' ' || v_emp_record.last_name
            || ' ' || v_emp_record.job_id
            || ' ' || v_emp_record.salary);
    END LOOP;
    CLOSE employees_cur;
END;

-- 5. exercise
BEGIN
    FOR rec IN (
        SELECT country_name, national_holiday_name, national_holiday_date
        FROM countries
        WHERE region_id = 5)
    LOOP
        DBMS_OUTPUT.PUT_LINE(rec.country_name || ' '
            || rec.national_holiday_name || ' '
            || rec.national_holiday_date);
    END LOOP;
END;

-- 6. exercise
BEGIN
    FOR rec IN (
        SELECT * FROM countries WHERE highest_elevation > 8000)
    LOOP
        DBMS_OUTPUT.PUT_LINE(rec.country_name || ' '
            || rec.highest_elevation || ' '
            || rec.climate);
    END LOOP;
END;

-- 7. exercise
select * from spoken_languages;

DECLARE
    CURSOR cur IS
        SELECT c.country_name, COUNT(*) AS lang_counter
        FROM countries c INNER JOIN spoken_languages sl
        ON c.country_id = sl.country_id
        GROUP BY c.country_name
        HAVING COUNT(*) > 6;
    v_rows_counter NUMBER := 0;
BEGIN
    FOR rec IN cur LOOP
        DBMS_OUTPUT.PUT_LINE(rec.country_name || ' ' || rec.lang_counter);
        v_rows_counter := v_rows_counter + 1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Number of fetched rows: ' || v_rows_counter);
END;

-- 8. exercise
DECLARE
    CURSOR countries_cur (p_region_id countries.region_id%TYPE) IS
        SELECT country_name, area
        FROM countries
        WHERE region_id = p_region_id;
    v_country_name countries.country_name%TYPE;
    v_area countries.area%TYPE;
BEGIN
    OPEN countries_cur (30);
    LOOP
        IF countries_cur%NOTFOUND
        THEN EXIT;
        END IF;
        
        FETCH countries_cur INTO v_country_name, v_area;
        
        DBMS_OUTPUT.PUT_LINE(v_country_name || ' ' || v_area);
    END LOOP;
END;

-- 9. exercise
DECLARE
    CURSOR countries_cur (p_region_id countries.region_id%TYPE, 
                          p_area countries.area%TYPE) IS
        SELECT country_name, area
        FROM countries
        WHERE region_id = p_region_id AND area = p_area;
BEGIN
    FOR rec IN countries_cur(5, 1000000)
    LOOP
        DBMS_OUTPUT.PUT_LINE(rec.country_name || ' ' || rec.area);
    END LOOP;
END;

-- 10. exercise
DECLARE
    CURSOR cur(p_salary employees.salary%TYPE) IS
        SELECT * FROM employees
        WHERE salary < p_salary FOR UPDATE NOWAIT;
BEGIN
    FOR rec IN cur(5000)
    LOOP
        INSERT INTO proposed_raises
        VALUES (SYSDATE, NULL, rec.employee_id, NULL, rec.salary, rec.salary * 0.5);
    END LOOP;
END;

-- 11. exercise
DECLARE
    CURSOR cur IS
        SELECT * FROM proposed_raises
        FOR UPDATE NOWAIT;
BEGIN
    FOR rec in cur
    LOOP
        UPDATE proposed_raises
        SET date_approved = SYSDATE
        WHERE CURRENT OF cur;
    END LOOP;
END;