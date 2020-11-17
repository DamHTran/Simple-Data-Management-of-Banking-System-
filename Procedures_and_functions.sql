
USE project_i;

-- Procedure

DROP PROCEDURE IF EXISTS insert_into_loan;
DELIMITER $$ 
CREATE PROCEDURE insert_into_loan ( IN p_branch_id INT, IN p_loan_amnt INT, IN p_funded_amnt INT, IN p_term VARCHAR(10), IN p_int_rate FLOAT, IN p_installment FLOAT, IN p_loan_status VARCHAR(30), IN p_issue_d VARCHAR(10))
BEGIN 
	INSERT INTO loan(branch_id,loan_amnt,funded_amnt,term,int_rate,installment,loan_status,issue_d)
    VALUES (p_branch_id,p_loan_amnt,p_funded_amnt,p_term,p_int_rate,p_installment,p_loan_status,p_issue_d);
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS check_financial_info;
DELIMITER $$ 
CREATE PROCEDURE check_financial_info ( IN p_member_id INT)
BEGIN 
	SELECT member_id,emp_title,emp_length,home_ownership,annual_inc,inq_last_6mths,total_acc,delinq_2yrs,earliest_cr_line
    FROM customer, financial_info
    WHERE customer.fin_id = financial_info.fin_id
    AND member_id = p_member_id;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS check_loan_info;
DELIMITER $$ 
CREATE PROCEDURE check_loan_info ( IN p_member_id INT)
BEGIN 
	SELECT member_id,loan_amnt,funded_amnt,term,int_rate,installment,loan_status,issue_d
    FROM customer, loan
    WHERE customer.loan_id = loan.loan_id
    AND member_id = p_member_id;
END $$
DELIMITER ;

-- functions

DELIMITER $$ 
CREATE FUNCTION get_installment (p_member_id INT) RETURNS FLOAT
DETERMINISTIC
BEGIN 
DECLARE v_installment FLOAT;
SELECT installment INTO v_installment
FROM loan,customer
WHERE customer.loan_id = loan.loan_id
AND customer.member_id = p_member_id;
RETURN v_installment;
END $$
DELIMITER ;

SET @v_member_id = 1;
SELECT get_installment(@v_member_id);

DELIMITER $$ 
CREATE FUNCTION get_funded_amnt (p_member_id INT) RETURNS FLOAT
DETERMINISTIC
BEGIN 
DECLARE v_funded_amnt FLOAT;
SELECT funded_amnt INTO v_funded_amnt
FROM loan,customer
WHERE customer.loan_id = loan.loan_id
AND customer.member_id = p_member_id;
RETURN v_funded_amnt;
END $$
DELIMITER ;

SELECT get_funded_amnt(@v_member_id);

COMMIT;


-- Trigger 

DELIMITER $$ 
CREATE TRIGGER trig_upd_loan
BEFORE UPDATE ON loan
FOR EACH ROW 
BEGIN 
	IF NEW.funded_amnt < 0 THEN 
		SET NEW.funded_amnt = OLD.funded_amnt;
	END IF;
END $$
DELIMITER ;


DELIMITER $$ 
CREATE TRIGGER deposit_balance
AFTER INSERT ON transactions
FOR EACH ROW 
BEGIN 
	IF NEW.actions = 'deposit' THEN 
		UPDATE accounts
        SET current_balance = current_balance + NEW.amount
        WHERE accounts.account_id= NEW.account_id;
	END IF;
END $$
DELIMITER ;

DELIMITER $$ 
CREATE TRIGGER withdraw_balance
AFTER INSERT ON transactions
FOR EACH ROW 
BEGIN 
	IF NEW.actions = 'withdraw' THEN 
		UPDATE accounts
        SET current_balance = current_balance - NEW.amount
        WHERE accounts.account_id= NEW.account_id;
	END IF;
END $$
DELIMITER ;










