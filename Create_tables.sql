DROP DATABASE project_i;
CREATE DATABASE project_i;
USE project_i; 


CREATE TABLE financial_info(
fin_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
home_ownership VARCHAR(20),
annual_inc INT,
inq_last_6mths INT,
total_acc INT,
delinq_2yrs INT,
earliest_cr_line VARCHAR(10));

INSERT INTO financial_info(home_ownership,annual_inc,inq_last_6mths,total_acc,delinq_2yrs,earliest_cr_line) 
VALUES ('MORTGAGE',500000,2,4,1,4),
		('RENT',100000,0,5,0,5);



CREATE TABLE address(
address_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
zip_code VARCHAR(10),
addr_state VARCHAR(5));

INSERT INTO address(zip_code,addr_state) 
VALUES (19774, 'PD'),
	   (16894, 'SD');

CREATE TABLE branch(
branch_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
address_id INT,
branch_name VARCHAR(20),
FOREIGN KEY(address_id) REFERENCES address(address_id) ON DELETE CASCADE);

INSERT INTO branch(address_id, branch_name)
VALUES (1,'branch1'),
       (2,'branch2');


CREATE TABLE loan(
loan_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
branch_id INT,
loan_amnt INT,
funded_amnt INT,
term VARCHAR(10),
int_rate FLOAT,
installment FLOAT,
loan_status VARCHAR(30),
issue_d VARCHAR(10),
FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE);

INSERT INTO loan(branch_id,loan_amnt,funded_amnt,term,int_rate,installment,loan_status,issue_d)
VALUES (1,50000,36000,'36 months',11.4,1230.03,'Fully paid','Dec-19'),
	   (2,22400,22400, '60 months',12.88,508.3,'Current', 'Nov-20');

CREATE TABLE accounts(
account_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
date_opened VARCHAR(20),
date_closed VARCHAR(20),
current_balance FLOAT); 

INSERT INTO accounts(date_opened,date_closed,current_balance)
VALUES ('2018-07-05','2021-07-05',12000),
	   ('2019-11-15','2020-11-15',6600);

CREATE TABLE transactions(
trans_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
account_id INT,
branch_id INT,
date_trans VARCHAR(20),
amount INT,
actions VARCHAR(20),
FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE,
FOREIGN KEY(account_id ) REFERENCES accounts(account_id ) ON DELETE CASCADE);

INSERT INTO transactions(account_id,branch_id,date_trans,amount,actions)
VALUES (1,1,'2020-11-13',3000,'Send'),
	   (2,2,'2019-11-20',2000,'Receive');	

CREATE TABLE customer(
member_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
address_id INT,
account_id INT,
loan_id INT,
fin_id INT,
emp_title VARCHAR(20),
emp_length VARCHAR(20),
FOREIGN KEY(address_id) REFERENCES address(address_id) ON DELETE CASCADE,
FOREIGN KEY(account_id) REFERENCES accounts(account_id) ON DELETE CASCADE,
FOREIGN KEY(loan_id) REFERENCES loan(loan_id) ON DELETE CASCADE,
FOREIGN KEY(fin_id) REFERENCES financial_info(fin_id) ON DELETE CASCADE);

INSERT INTO customer(address_id,account_id,loan_id,fin_id,emp_title,emp_length)
VALUES (1,1,1,1,'Engineer','+10 years'),
	   (2,2,2,2,'Teacher','4 years');



