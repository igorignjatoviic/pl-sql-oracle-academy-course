-- 1. exercise
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World');
END;

-- 2. exercise
DECLARE
    v_date DATE := SYSDATE + 180;
BEGIN
    DBMS_OUTPUT.PUT_LINE('In six months, the date will be: ' || v_date);
END;