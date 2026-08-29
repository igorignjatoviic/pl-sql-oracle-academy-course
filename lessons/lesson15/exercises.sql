-- 1. exercise
CREATE OR REPLACE PROCEDURE testproc IS
 v_count INTEGER := 1;
BEGIN
 IF v_count = 1 THEN
 DBMS_OUTPUT.PUT_LINE('The count is one.');
 ELSE
 DBMS_OUTPUT.PUT_LINE('The count is not one.');
 END IF;
 FOR i IN 1..500000 LOOP
 SELECT COUNT(*) INTO v_count FROM employees;
 END LOOP;
END testproc;

-- 2. exercise
BEGIN
    DBMS_OUTPUT.PUT_LINE(DBMS_WARNING.GET_WARNING_SETTING_STRING);
END;

-- 3. exercise
ALTER SESSION SET PLSQL_CCFLAGS = 'debugFlag:FALSE';

CREATE OR REPLACE PROCEDURE my_debug_proc AS
    v_count NUMBER(3);
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM departments;
    
    $IF $$debugFlag $THEN
        DBMS_OUTPUT.PUT_LINE('True: ' || v_count);
    $ELSE
        DBMS_OUTPUT.PUT_LINE('False');
    $END
END my_debug_proc;

BEGIN
    my_debug_proc;
END;

-- 4. exercise
CREATE OR REPLACE PROCEDURE sample_proc
 IS BEGIN
 DBMS_OUTPUT.PUT_LINE ('Source code is hidden.');
END sample_proc;

BEGIN
    DBMS_DDL.CREATE_WRAPPED
        ('CREATE OR REPLACE PROCEDURE sample_proc
          IS BEGIN
          DBMS_OUTPUT.PUT_LINE (''Source code is hidden.'');
          END sample_proc;');
END;