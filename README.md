# Simple-Data-Management-of-Banking-System-: Overview 
* Create a simple data warehouse for banking system
* Create some procedures, functions and triggers to allow an executive serve their customer such as deposit money, withdraw money and check whether or not they applicable for a loan. 

**MySQL Server:** 8.0

**MySQL Workbench:** 8.0 CE

#### EDR 
![alt text](https://github.com/DamHTran/Simple-Data-Management-of-Banking-System-/blob/master/ERD.png)

#### Procedures
* insert_into_loan (add loan information)
* check_loan_info (Check loan information of a customer)
* check_financial_info (Check customer's financial infomation)

#### Functions
* get_installment
* get_finded_amnt

#### Trigger
* trig_upd_loan (dismiss any value < 0 when inserting into loan table)
* deposit_balance (automate update balance when customer deposit money)
* withdraw_balance (automate update balance when customer withdraw money)

