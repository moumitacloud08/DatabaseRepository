use sakila;
SELECT * FROM sakila.customer;
desc sakila.customer;

SELECT * FROM sakila.customer 
where email = 'PATRICIA.JOHNSON@sakilacustomer.org';

SELECT * FROM sakila.address 
where address_id = 6;

DROP PROCEDURE IF EXISTS update_address;
DELIMITER //
CREATE PROCEDURE update_address(phone BIGINT(20),  v_email VARCHAR(70), OUT success INT)
BEGIN 
    DECLARE v_out INT DEFAULT 0;
    DECLARE v_address_id INT DEFAULT 0;
    SELECT address_id INTO v_address_id FROM customer WHERE email=v_email;
    IF v_address_id != 0 THEN
        UPDATE address SET phone=v_phone WHERE address_id=v_address_id;
        SET success=1;
    ELSE
        SET success=0;
    END IF;
END
//
DELIMITER ;

call update_address(838635286611,'PATRICIA.JOHNSON@sakilacustomer.org',@v_out);

select @v_out;


DROP PROCEDURE IF EXISTS FETCH_CUSTOMER_PAYMENT;
DELIMITER //
CREATE PROCEDURE FETCH_CUSTOMER_PAYMENT(IN v_customer_id INT,OUT v_amount INT) 
BEGIN
    SELECT amount INTO v_amount FROM PAYMENT WHERE customer_id=v_customer_id limit 1;
END;
//
DELIMITER ;

CALL FETCH_CUSTOMER_PAYMENT(1,@result);
SELECT @result;


DROP PROCEDURE IF EXISTS FETCH_CUSTOMER_PAYMENT_ALL_DATA;
DELIMITER //
CREATE PROCEDURE FETCH_CUSTOMER_PAYMENT_ALL_DATA(IN v_customer_id INT,OUT v_amount INT) 
BEGIN
    SELECT amount INTO v_amount FROM PAYMENT WHERE customer_id=v_customer_id limit 1;
END;
//
DELIMITER ;

CALL FETCH_CUSTOMER_PAYMENT_ALL_DATA(1,@result);

DROP FUNCTION IF EXISTS CALCULATE_TOTAL_SALARY_ONE_EMPLOYEE;
DELIMITER //
CREATE FUNCTION CALCULATE_TOTAL_SALARY_ONE_EMPLOYEE(v_emp_id INT)
RETURNS INT
BEGIN
    DECLARE total_salary  INT;    
    SELECT sum(amount)  INTO total_salary FROM SALARY where emp_no = v_emp_id group by emp_no;
RETURN total_salary;
END;
//
DELIMITER ;

SELECT CALCULATE_TOTAL_SALARY_ONE_EMPLOYEE(10001);

