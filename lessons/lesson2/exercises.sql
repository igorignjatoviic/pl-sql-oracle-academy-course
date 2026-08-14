-- 1. exercise
DECLARE
    fname VARCHAR2(25);
    lname VARCHAR2(25) DEFAULT 'fernandez';
BEGIN
    DBMS_OUTPUT.PUT_LINE(fname || ' ' || lname);
END;

-- 2. exercise
CREATE FUNCTION num_characters (p_string IN VARCHAR2)
RETURN INTEGER AS
    v_num_characters INTEGER;
BEGIN
    SELECT LENGTH (p_string) INTO v_num_characters FROM dual;
    RETURN v_num_characters;
END;

DECLARE
    v_length_of_string INTEGER;
BEGIN
    v_length_of_string := num_characters('Oracle corporation');
    DBMS_OUTPUT.PUT_LINE(v_length_of_string);
END;

-- 3. exercise
DECLARE
    v_country_name VARCHAR2(50) := 'Japan';
    v_low_elev INTEGER;
    v_high_elev INTEGER;
BEGIN
    SELECT lowest_elevation, highest_elevation INTO v_low_elev, v_high_elev
    FROM countries
    WHERE country_name = v_country_name;
    DBMS_OUTPUT.PUT_LINE('Country: ' || v_country_name || ' Low: ' || v_low_elev || ' High: ' || v_high_elev);
END;

-- 4. exercise
DECLARE
    v_today DATE := SYSDATE;
    v_tomorrow v_today%TYPE;
BEGIN
    v_tomorrow := v_today + 1;
    DBMS_OUTPUT.PUT_LINE('Tomorrow: ' || v_tomorrow);
END;

-- 5. exercise
DECLARE
    v_name VARCHAR2(15) := 'Igor';
BEGIN
    DBMS_OUTPUT.PUT_LINE(LENGTH(v_name));
END;

-- 6. exercise
DECLARE
    v_my_date DATE := SYSDATE;
    v_formatted VARCHAR2(20) := TO_CHAR(v_my_date, 'Month DD, YYYY');
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_formatted);
END;

-- 7. exercise
DECLARE
    v_my_date DATE := SYSDATE;
    v_new_date DATE := v_my_date + 45;
    v_num_of_months INTEGER;
BEGIN
    v_num_of_months := 45 / 30 - 1;
    DBMS_OUTPUT.PUT_LINE('Months: ' || v_num_of_months);
END;
