-- 1. exercise
CREATE TABLE grocery_items(
    product_id NUMBER NOT NULL,
    brand VARCHAR2(20) NOT NULL,
    description VARCHAR2(20) NOT NULL
);

-- 2. exercise
INSERT INTO grocery_items
VALUES (110, 'Colgate', 'Toothpaste');

INSERT INTO grocery_items
VALUES (111, 'Ivory', 'Soap');

INSERT INTO grocery_items
VALUES (112, 'Heinz', 'Ketchup');

-- 3. exercise
UPDATE grocery_items
SET description = 'tomato catsup'
WHERE brand = 'Heinz';

-- 4. exercise
CREATE TABLE new_items(
    product_id NUMBER NOT NULL,
    brand VARCHAR2(20) NOT NULL,
    description VARCHAR2(20) NOT NULL
);

INSERT INTO new_items
VALUES (110, 'Colgate', 'Dental paste');

INSERT INTO new_items
VALUES (175, 'Dew', 'Soda');

INSERT INTO new_items
VALUES (275, 'Palmolive', 'Dish detergent');

-- 5. exercise
MERGE INTO grocery_items gi
USING new_items ni
ON (gi.product_id = ni.product_id)
WHEN MATCHED THEN
UPDATE SET
    gi.brand = ni.brand,
    gi.description = ni.description
WHEN NOT MATCHED THEN
    INSERT (product_id, brand, description)
    VALUES (ni.product_id, ni.brand, ni.description);
    
-- 6. exercise
DECLARE
    v_max_deptno departments.department_id%TYPE;
BEGIN
    SELECT MAX(department_id) INTO v_max_deptno
    FROM departments;
    DBMS_OUTPUT.PUT_LINE(v_max_deptno);
END;

-- 7. exercise
DECLARE
    v_max_deptno new_depts.department_id%TYPE;
    v_dept_name new_depts.department_name%TYPE := 'A New Department';
    v_dept_id new_depts.department_id%TYPE;
BEGIN
    SELECT MAX(department_id) INTO v_max_deptno
    FROM new_depts;
    v_dept_id := v_max_deptno + 10;
    DBMS_OUTPUT.PUT_LINE('The maximum department id is: ' || v_max_deptno);
    
    INSERT INTO new_depts
    VALUES (v_dept_id, v_dept_name, NULL, NULL);
    DBMS_OUTPUT.PUT_LINE('Rows changed: ' || SQL%ROWCOUNT);
END;

-- 8. exercise
DECLARE
    v_max_deptno new_depts.department_id%TYPE;
    v_dept_name new_depts.department_name%TYPE := 'A New Department';
    v_dept_id new_depts.department_id%TYPE;
BEGIN
    UPDATE new_depts
    SET location_id = 1400
    WHERE location_id = 1700;
END;

-- 9. exercise
CREATE TABLE endangered_species
 (species_id NUMBER(4) CONSTRAINT es_spec_pk PRIMARY KEY,
 common_name VARCHAR2(30) CONSTRAINT es_com_name_nn NOT NULL,
 scientific_name VARCHAR2(30) CONSTRAINT es_sci_name_nn NOT NULL);
 
BEGIN
 INSERT INTO endangered_species
 VALUES (100, 'Polar Bear', 'Ursus maritimus');
 SAVEPOINT sp_100;
 INSERT INTO endangered_species
 VALUES (200, 'Spotted Owl', 'Strix occidentalis');
 SAVEPOINT sp_200;
 INSERT INTO endangered_species
 VALUES (300, 'Asiatic Black Bear', 'Ursus thibetanus');
 ROLLBACK TO sp_100;
 COMMIT;
END;

-- 10. exercise
BEGIN
 INSERT INTO endangered_species
 VALUES (400, 'Blue Gound Beetle', 'Carabus intricatus');
 SAVEPOINT sp_400;
 INSERT INTO endangered_species
 VALUES (500, 'Little Spotted Cat', 'Leopardus tigrinus');
 ROLLBACK;
 INSERT INTO endangered_species
 VALUES (600, 'Veined Tongue-Fern', 'Elaphoglossum nervosum');
 ROLLBACK TO sp_400;
END;
