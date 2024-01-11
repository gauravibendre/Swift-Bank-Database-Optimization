 /*************************IF TABLES EXIST ALREADY**************************/ 

drop table Customer CASCADE CONSTRAINTS; 
drop table Login CASCADE CONSTRAINTS; 
drop table Accounts CASCADE CONSTRAINTS; 
drop table Checking CASCADE CONSTRAINTS; 
drop table Savings CASCADE CONSTRAINTS; 
drop table Transactions CASCADE CONSTRAINTS; 
drop table Merchant CASCADE CONSTRAINTS; 
Commit; 
  
  
/*CREATION OF TABLES STARTED*/ 
 
/*********************CREATING CUSTOMER Table*******************************/ 
  
CREATE TABLE Customer ( 
    CustomerID INT NOT NULL, 
    CustomerFullName VARCHAR(50) NOT NULL, 
    CustomerJoiningDate DATE NOT NULL, 
    PhoneNumber VARCHAR(20) UNIQUE, 
    CustomerEmail VARCHAR(50) UNIQUE, 
    CustomerStreet VARCHAR(100) NOT NULL, 
    CustomerCity VARCHAR(50) NOT NULL, 
    CustomerState VARCHAR(2) NOT NULL, 
    CustomerZipcode VARCHAR(10) NOT NULL, 
    CONSTRAINT PK_Customer PRIMARY KEY (CustomerID), 
    CONSTRAINT phone_number_format CHECK (PhoneNumber LIKE '(___) ___-____'), 
    CONSTRAINT email_format CHECK (CustomerEmail LIKE '%@%.%'), 
    CONSTRAINT zip_format CHECK (CustomerZipcode LIKE '_____'), 
    CONSTRAINT state_format CHECK (CustomerState LIKE '__'), 
    CONSTRAINT street_not_empty CHECK (CustomerStreet <> ''), 
    CONSTRAINT city_not_empty CHECK (CustomerCity <> '') 
); 

/************************** CREATING LOGIN Table**********************************/ 
  
CREATE TABLE Login ( 
    CUsername VARCHAR(50) NOT NULL PRIMARY KEY, 
    CustomerID INT NOT NULL, 
    CPassword VARCHAR(50) NOT NULL, 
    CONSTRAINT FK_Login_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID), 
    CONSTRAINT CK_Login_Password CHECK (LENGTH(CPassword) >= 8) 
); 
  
/**************************CREATING ACCOUNTS Table****************************/ 
  
CREATE TABLE Accounts ( 
    AccountID INT NOT NULL PRIMARY KEY, 
    CustomerID INT NOT NULL, 
    AccountName VARCHAR(50) NOT NULL, 
    AccountBalance DECIMAL(10,2) NOT NULL, 
    RoutingNumber VARCHAR(20) DEFAULT '123456789' NOT NULL, 
    AccountOpeningDate DATE NOT NULL, 
    AccountType VARCHAR(20) NOT NULL, 
    CONSTRAINT FK_Account_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID), 
    CONSTRAINT CK_Account_AccountBalance CHECK (AccountBalance >= 0), 
    CONSTRAINT CK_Account_AccountType CHECK (AccountType IN ('Savings', 'Checking')) 
); 
  
/************************** CREATING CHECKING Table*************************/ 
  
CREATE TABLE Checking ( 
    CAccountID INT NOT NULL PRIMARY KEY, 
    ATMWithdrawalCAP DECIMAL(10,2) NOT NULL, 
    DebitCardNumber VARCHAR(50) NOT NULL, 
    PIN VARCHAR(10) NOT NULL, 
    CONSTRAINT FK_Checking_Account FOREIGN KEY (CAccountID) REFERENCES Accounts (AccountID), 
    CONSTRAINT CK_Checking_ATMWithdrawalCAP CHECK (ATMWithdrawalCAP > 0), 
    CONSTRAINT CK_Checking_PIN CHECK (LENGTH(PIN) = 4), 
    CONSTRAINT UQ_Checking_DebitCardNumber UNIQUE (DebitCardNumber) 
); 
  
  
/************************** CREATING SAVINGS Table*******************************/ 
  
CREATE TABLE Savings ( 
    SAccountID INT NOT NULL, 
    InterestRate DECIMAL(4,2) NOT NULL, 
    CONSTRAINT FK_Savings_AccountID FOREIGN KEY (SAccountID) REFERENCES Accounts(AccountID), 
    CONSTRAINT CK_Savings_InterestRate CHECK (InterestRate >= 0), 
    CONSTRAINT PK_Saving PRIMARY KEY (SAccountID) 
); 
  
  
  
/************************** CREATING MERCHANT Table******************************/ 
  
CREATE TABLE Merchant ( 
    MerchantID INT NOT NULL PRIMARY KEY, 
    MerchantName VARCHAR(50) NOT NULL, 
    MerchantEmail VARCHAR(50) NOT NULL, 
    MerchantPhone VARCHAR(20) NOT NULL, 
    MerchantStreet VARCHAR(50) NOT NULL, 
    MerchantCity VARCHAR(50) NOT NULL, 
    MerchantState VARCHAR(2) NOT NULL, 
    MerchantZipcode VARCHAR(10) NOT NULL, 
    CONSTRAINT CHK_MerchantState CHECK (LENGTH(MerchantState) = 2), 
    CONSTRAINT CHK_MerchantEmail CHECK (MerchantEmail LIKE '%@%.%'), 
    CONSTRAINT CHK_MerchantZipcode CHECK (MerchantZipcode LIKE '_____'), 
    CONSTRAINT CHK_MerchantPhone CHECK (MerchantPhone LIKE '(___) ___-____') 
); 
  
/************************ CREATING TRANSACTIONS Table***************************/ 
  
  
CREATE TABLE Transactions ( 
    TransactionID INT NOT NULL PRIMARY KEY, 
    MerchantID INT NOT NULL, 
    AccountID INT NOT NULL, 
    TransactionDate DATE NOT NULL, 
    TransactionStatus VARCHAR(30) NOT NULL CHECK (TransactionStatus IN ('Cancelled', 'Successful', 'Disputed', 'Disputed then Resolved', 'Declined')), 
    TransactionAmount DECIMAL(10,2) NOT NULL, 
    CONSTRAINT FK_Transaction_MerchantID FOREIGN KEY (MerchantID) REFERENCES Merchant(MerchantID), 
    CONSTRAINT FK_Transaction_AccountID FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID) 
); 
  
  
/********************INSERTING VALUES IN CUSTOMER TABLE  **************************/ 
  
  
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1001, 'Gauravi Bendre', TO_DATE('2022-01-01', 'YYYY-MM-DD'), '(123) 456-7890', 'john.smith@gmail.com', '123 Main St', 'Anytown', 'CA', '12345'); 
  
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1002, 'Maria Secaira', TO_DATE('2022-02-15', 'YYYY-MM-DD'), '(234) 567-8901', 'mary.johnson@yahoo.com', '456 Oak Ave', 'Smallville', 'NY', '67890'); 
  
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1003, 'Sahil Suhag', TO_DATE('2022-03-20', 'YYYY-MM-DD'), '(345) 678-9012', 'bob.smith@hotmail.com', '789 Elm St', 'Bigtown', 'TX', '34567'); 
  
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1004, 'Maria Fernanda', TO_DATE('2022-04-05', 'YYYY-MM-DD'), '(456) 789-0123', 'jane.doe@gmail.com', '321 Maple St', 'Hometown', 'IL', '45678'); 
  
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1005, 'Tom Johnson', TO_DATE('2022-05-10', 'YYYY-MM-DD'), '(567) 890-1234', 'tom.johnson@yahoo.com', '654 Pine St', 'Suburbia', 'WA', '89012'); 
  
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1006, 'Samantha Lee', TO_DATE('2022-06-15', 'YYYY-MM-DD'), '(678) 901-2345', 'samantha.lee@hotmail.com', '987 Cedar St', 'Cityville', 'FL', '23456'); 
  
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1007, 'David Garcia', TO_DATE('2022-07-20', 'YYYY-MM-DD'), '(789) 012-3456', 'david.garcia@gmail.com', '753 Oak St', 'Townsville', 'AZ', '78901'); 
  
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1008, 'Emily Davis', TO_DATE('2023-01-29', 'YYYY-MM-DD'), '(890) 123-4567', 'emily.davis@yahoo.com', '246 Pine St', 'Villageville', 'OH', '12345'); 
  
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1009, 'Ryan Brown', TO_DATE('2023-02-25', 'YYYY-MM-DD'), '(901) 234-5678', 'ryan.brown@hotmail.com', '864 Maple St', 'Countrytown', 'TN', '67890'); 
  
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1010, 'Megan Perez', TO_DATE('2023-03-15', 'YYYY-MM-DD'), '(012) 345-6789', 'megan.perez@gmail.com', '975 Cedar St', 'Seaside', 'CA', '34567'); 
  
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1011, 'Andrew Johnson', TO_DATE('2023-04-20', 'YYYY-MM-DD'), '(123) 496-7890', 'andrew.johnson@gmail.com', '123 Main St', 'Anytown', 'CA', '12345'); 
 
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1012, 'Sophie Garcia', TO_DATE('2023-05-10', 'YYYY-MM-DD'), '(234) 067-8901', 'sophie.garcia@yahoo.com', '456 Oak Ave', 'Smallville', 'NY', '67890'); 
 
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1013, 'Alex Nguyen', TO_DATE('2023-06-15', 'YYYY-MM-DD'), '(345) 978-9012', 'alex.nguyen@hotmail.com', '789 Elm St', 'Bigtown', 'TX', '34567'); 
 
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1014, 'Grace Lee', TO_DATE('2023-07-05', 'YYYY-MM-DD'), '(456) 787-0123', 'grace.lee@gmail.com', '321 Maple St', 'Hometown', 'IL', '45678'); 
 
INSERT INTO Customer (CustomerID, CustomerFullName, CustomerJoiningDate, PhoneNumber, CustomerEmail, CustomerStreet, CustomerCity, CustomerState, CustomerZipcode) 
VALUES (1015, 'Daniel Kim', TO_DATE('2023-08-10', 'YYYY-MM-DD'), '(567) 850-1234', 'daniel.kim@yahoo.com', '654 Pine St', 'Suburbia', 'WA', '89012');
 
 
 /*************************INSERTING VALUES IN LOGIN TABLE  **************************/ 
 
 
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('gauravibendre', 1001, 'Password123'); 
  
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('mariasecaira', 1002, 'SecurePassword1'); 
  
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('sahilsuhag', 1003, 'StrongPassword123'); 
  
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('mariafernanda', 1004, 'Password4567'); 
  
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('tomjohnson', 1005, 'MyPasswordIsSecure1'); 
  
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('samanthalee', 1006, 'Password12345'); 
  
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('davidgarcia', 1007, 'SecurePassword12'); 
  
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('emilydavis', 1008, 'StrongPassword1234'); 
  
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('ryanbrown', 1009, 'Password5678'); 
  
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('meganperez', 1010, 'MySecurePassword123'); 
  
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('andrewjohnson', 1011, 'MyPassw0rd456 '); 
 
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('sophiegarcia', 1012, 'ElephantsAreCool123'); 
 
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('alexnguyen', 1013, 'Tr0ub4dor3'); 
 
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('gracelee', 1014, 'F1shingIsFun99'); 
 
INSERT INTO Login (CUsername, CustomerID, CPassword) 
VALUES ('danielkim', 1015, '7Horses8Running'); 
 

/*************************INSERTING VALUES IN Accounts TABLE  **********************/ 
  
  
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType) 
VALUES (1, 1001, 'Gauravi Bendre - Checking', 5000.00, '123456789', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'Checking'); 
  
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType) 
VALUES (2, 1006, 'Samantha Lee - Savings', 10000.00, '123456789', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'Savings'); 
  
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType) 
VALUES (3, 1002, 'Maria Secaira - Checking', 2500.00, '123456789', TO_DATE('2022-02-15', 'YYYY-MM-DD'), 'Checking'); 
  
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType) 
VALUES (4, 1002, 'Maria Secaira - Savings', 15000.00, '123456789', TO_DATE('2022-02-15', 'YYYY-MM-DD'), 'Savings'); 
  
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType) 
VALUES (5, 1003, 'Sahil Suhag - Checking', 1000.00, '123456789', TO_DATE('2022-03-20', 'YYYY-MM-DD'), 'Checking'); 
  
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType) 
VALUES (6, 1007, 'David Garcia - Savings', 5000.00, '123456789', TO_DATE('2022-03-20', 'YYYY-MM-DD'), 'Savings'); 
  
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType) 
VALUES (7, 1008, 'Emily Davis - Checking', 7000.00, '123456789', TO_DATE('2023-02-05', 'YYYY-MM-DD'), 'Checking'); 
  
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType) 
VALUES (8, 1004, 'Maria Fernanda - Savings', 12000.00, '123456789', TO_DATE('2022-04-05', 'YYYY-MM-DD'), 'Savings'); 
  
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType) 
VALUES (9, 1009, 'Ryan Brown - Checking', 1500.00, '123456789', TO_DATE('2023-03-27', 'YYYY-MM-DD'), 'Checking'); 
  
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType) 
VALUES (10, 1005, 'Tom Johnson - Savings', 20000.00, '123456789', TO_DATE('2022-05-10', 'YYYY-MM-DD'), 'Savings'); 
  
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType) 
VALUES (11, 1010, 'Megan Perez - Checking', 1500.00, '123456789', TO_DATE('2023-03-16', 'YYYY-MM-DD'), 'Checking'); 
  
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType)  
VALUES (12, 1011, 'Andrew Johnson - Savings', 1000.00, '123456789', TO_DATE('2023-04-20', 'YYYY-MM-DD'), 'Savings'); 
 
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType)  
VALUES (13, 1011, 'Andrew Johnson - Checking', 5000.00, '123456789', TO_DATE('2023-04-20', 'YYYY-MM-DD'), 'Checking'); 
 
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType)  
VALUES (14, 1012, 'Sophie Garcia - Savings', 2500.00, '123456789', TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'Savings'); 
 
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType)  
VALUES (15, 1012, 'Sophie Garcia - Checking', 7500.00, '123456789', TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'Checking'); 
 
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType)  
VALUES (16, 1013, 'Alex Nguyen - Savings', 5000.00, '123456789', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 'Savings'); 
 
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType)  
VALUES (17, 1014, 'Grace Lee - Checking', 10000.00, '123456789', TO_DATE('2023-07-05', 'YYYY-MM-DD'), 'Checking'); 
 
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType)  
VALUES (18, 1015, 'Daniel Kim - Savings', 7500.00, '123456789', TO_DATE('2023-08-10', 'YYYY-MM-DD'), 'Savings'); 
 
INSERT INTO Accounts (AccountID, CustomerID, AccountName, AccountBalance, RoutingNumber, AccountOpeningDate, AccountType)  
VALUES (19, 1015, 'Daniel Kim - Checking', 5000.00, '123456789', TO_DATE('2023-08-10', 'YYYY-MM-DD'), 'Checking'); 
 
 
/*************************INSERTING VALUES IN Checking TABLE **************************/ 
  
INSERT INTO Checking (CAccountID, ATMWithdrawalCAP, DebitCardNumber, PIN) 
VALUES (1, 1000.00, '1111222233334444', '1234'); 
  
INSERT INTO Checking (CAccountID, ATMWithdrawalCAP, DebitCardNumber, PIN) 
VALUES (3, 500.00, '5555666677778888', '4321'); 
  
INSERT INTO Checking (CAccountID, ATMWithdrawalCAP, DebitCardNumber, PIN) 
VALUES (5, 200.00, '9999000011112222', '7890'); 
  
INSERT INTO Checking (CAccountID, ATMWithdrawalCAP, DebitCardNumber, PIN) 
VALUES (7, 500.00, '3333444455556666', '5678'); 
  
INSERT INTO Checking (CAccountID, ATMWithdrawalCAP, DebitCardNumber, PIN) 
VALUES (9, 100.00, '7777888899990000', '2468'); 
  
INSERT INTO Checking (CAccountID, ATMWithdrawalCAP, DebitCardNumber, PIN) 
VALUES (11, 200.00, '8787222233345444', '1357'); 
  
INSERT INTO Checking (CAccountID, ATMWithdrawalCAP, DebitCardNumber, PIN) 
VALUES (13, 2000.00, '1299222233345444', '1907'); 
 
INSERT INTO Checking (CAccountID, ATMWithdrawalCAP, DebitCardNumber, PIN) 
VALUES (15, 8200.00, '9876762233345444', '1567'); 
 
INSERT INTO Checking (CAccountID, ATMWithdrawalCAP, DebitCardNumber, PIN) 
VALUES (17, 90.00, '1555422233345444', '3357'); 
 
INSERT INTO Checking (CAccountID, ATMWithdrawalCAP, DebitCardNumber, PIN) 
VALUES (19,3900.00, '1333222233345444', '0987'); 
  
 
 
/*************************INSERTING VALUES IN Savings TABLE **************************/ 
  
INSERT INTO Savings (SAccountID, InterestRate) 
VALUES (2, 2.50); 
  
INSERT INTO Savings (SAccountID, InterestRate) 
VALUES (4, 3.00); 
  
INSERT INTO Savings (SAccountID, InterestRate) 
VALUES (6, 2.00); 
  
INSERT INTO Savings (SAccountID, InterestRate) 
VALUES (8, 2.75); 
  
INSERT INTO Savings (SAccountID, InterestRate) 
VALUES (10, 3.25); 
  
INSERT INTO Savings (SAccountID, InterestRate) 
VALUES (12, 3.95); 
 
INSERT INTO Savings (SAccountID, InterestRate) 
VALUES (14, 2.25); 
 
INSERT INTO Savings (SAccountID, InterestRate) 
VALUES (16, 1.25); 
 
INSERT INTO Savings (SAccountID, InterestRate) 
VALUES (18, 1.55); 
 
 
  
/*************************INSERTING VALUES IN MERCHANT TABLE************************/ 
  
  
INSERT INTO Merchant (MerchantID, MerchantName, MerchantEmail, MerchantPhone, MerchantStreet, MerchantCity, MerchantState, MerchantZipcode) 
VALUES (1, 'Harry Potter', 'harrypotter@gmail.com', '(123) 456-7890', '123 Main St', 'Buffalo', 'NY', '14201'); 
  
INSERT INTO Merchant (MerchantID, MerchantName, MerchantEmail, MerchantPhone, MerchantStreet, MerchantCity, MerchantState, MerchantZipcode) 
VALUES (2, 'Jane Smith', 'janesmith@yahoo.com', '(555) 555-5555', '456 Oak Ave', 'Sunnyvale', 'CA', '94043'); 
  
INSERT INTO Merchant (MerchantID, MerchantName, MerchantEmail, MerchantPhone, MerchantStreet, MerchantCity, MerchantState, MerchantZipcode) 
VALUES (3, 'Bob Johnson', 'johnsonbob@hotmail.com', '(999) 999-9999', '789 Elm St', 'Boston', 'MA', '02129'); 
  
  
/*************************INSERTING VALUES IN Transaction TABLE ************************/ 
  
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (1, 1, 1, TO_DATE('2023-01-23', 'YYYY-MM-DD'), 'Successful', 20.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (2, 1, 1, TO_DATE('2023-03-02', 'YYYY-MM-DD'), 'Declined', 50.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (3, 1, 3, TO_DATE('2023-01-28', 'YYYY-MM-DD'), 'Disputed', 10.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (4, 1, 5, TO_DATE('2023-02-04', 'YYYY-MM-DD'), 'Successful', 100.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (5, 3, 7, TO_DATE('2023-01-05', 'YYYY-MM-DD'), 'Cancelled', 30.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (13, 1, 7,TO_DATE('2023-03-11', 'YYYY-MM-DD'), 'Successful', 45.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (14, 1, 9, TO_DATE('2023-02-12', 'YYYY-MM-DD'), 'Disputed then Resolved', 75.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (15, 1, 11, TO_DATE('2023-03-12', 'YYYY-MM-DD'), 'Cancelled', 120.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (16, 1, 5, TO_DATE('2023-03-13', 'YYYY-MM-DD'), 'Successful', 25.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (17, 2, 1, TO_DATE('2023-03-13', 'YYYY-MM-DD'), 'Declined', 85.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (18, 1, 3, TO_DATE('2023-03-13', 'YYYY-MM-DD'), 'Disputed', 60.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (19, 2, 11, TO_DATE('2023-03-14', 'YYYY-MM-DD'), 'Successful', 40.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (20, 3, 9, TO_DATE('2023-03-14', 'YYYY-MM-DD'), 'Cancelled', 90.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (21, 1, 5, TO_DATE('2023-03-14', 'YYYY-MM-DD'), 'Successful', 55.00); 
  
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (22, 1, 7, TO_DATE('2023-03-14', 'YYYY-MM-DD'), 'Disputed then Resolved', 100.00); 
 
 INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (23, 1, 1, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Successful', 35.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (24, 1, 3, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Disputed', 70.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (25, 1, 7, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Cancelled', 25.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (26, 1, 9, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Successful', 80.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
VALUES (27, 1, 5, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Declined', 90.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (28, 1, 11, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Successful', 65.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount) 
 VALUES (29, 1, 7, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Disputed then Resolved', 55.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (30, 1, 3, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Cancelled', 15.00); 

INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (31, 1, 5, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Successful', 30.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (32, 2, 9, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Disputed', 95.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (33, 1, 13, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Successful', 24.99); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (34, 2, 15, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Successful', 50.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (35, 1, 17, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Declined', 10.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (36, 1, 19, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Successful', 100.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (37, 1, 13, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Successful', 75.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (38, 1, 15, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Disputed', 200.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (39, 1, 17, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Successful', 12.50); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (40, 2, 19, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Successful', 50.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (41, 1, 13, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Disputed then Resolved', 150.00); 
 
INSERT INTO Transactions (TransactionID, MerchantID, AccountID, TransactionDate, TransactionStatus, TransactionAmount)  
VALUES (42, 1, 15, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 'Successful', 8.99); 

/*************************VIEWING DATA FROM THE TABLES **************************/ 
Select * from Login; 
Select * from Customer; 
Select * from Accounts; 
Select * from Savings;  
Select * from Checking; 
Select * from Transactions; 
Select * from Merchant; 

/*************************BUSINESS QUESTIONS QUERIES **************************/ 

--1: Number of records per transaction status 
SELECT TRANSACTIONSTATUS as "Transaction Status", 
COUNT(*) AS "Transactions Per Status" 
FROM TRANSACTIONS
GROUP BY TRANSACTIONSTATUS;
 
--2: Number of transactions that each merchant is involved in (joining 2 tables)
SELECT T.MERCHANTID AS "Merchant ID", 
M.MERCHANTNAME AS "Merchant Name",
COUNT(T.MerchantID) AS "Transactions per merchant"
FROM TRANSACTIONS T
INNER JOIN MERCHANT M
ON M.MERCHANTID = T.MERCHANTID
GROUP BY T.MERCHANTID, M.MERCHANTNAME
ORDER BY COUNT(T.MerchantID)DESC; 

--3:Customers who possess both savings and checking accounts with the bank
SELECT DISTINCT A1.CUSTOMERID AS "Customer ID" , 
C.CUSTOMERFULLNAME AS "Customer Name"
FROM ACCOUNTS A1
INNER JOIN ACCOUNTS A2 ON A1.CUSTOMERID = A2.CUSTOMERID
INNER JOIN CUSTOMER C ON A1.CUSTOMERID = C.CUSTOMERID
WHERE A1.ACCOUNTTYPE = 'Savings'
AND A2.ACCOUNTTYPE = 'Checking';

--4:Identifying customer with the highest cancelled transactions
SELECT 
c.CUSTOMERFULLNAME as "Customer Name",
COUNT(t.TRANSACTIONID) AS "No. of Cancelled Transactions"
FROM CUSTOMER c
INNER JOIN ACCOUNTS a ON c.CUSTOMERID = a.CUSTOMERID
INNER JOIN TRANSACTIONS t ON a.ACCOUNTID = t.ACCOUNTID

WHERE t.TRANSACTIONSTATUS = 'Cancelled'
GROUP BY c.CUSTOMERFULLNAME
HAVING COUNT(t.TRANSACTIONID) = 
(
SELECT 
MAX(cancelled_transactions)
FROM (
                SELECT 
                COUNT(t2.TRANSACTIONID) AS cancelled_transactions
                FROM 
                TRANSACTIONS t2
                INNER JOIN ACCOUNTS a2 ON t2.ACCOUNTID = a2.ACCOUNTID
                INNER JOIN CUSTOMER c2 ON a2.CUSTOMERID = c2.CUSTOMERID
                WHERE t2.TRANSACTIONSTATUS = 'Cancelled'
                GROUP BY c2.CUSTOMERFULLNAME
            )
    );
    