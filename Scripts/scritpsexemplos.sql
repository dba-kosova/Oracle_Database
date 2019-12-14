CREATE USER TESTUSER IDENTIFIED BY testuser   DEFAULT TABLESPACE users   TEMPORARY TABLESPACE temp   QUOTA UNLIMITED ON users;




GRANT "CONNECT" TO TESTUSER;


GRANT DBA TO TESTUSER;


GRANT "RESOURCE" TO TESTUSER;









ALTER USER TESTUSER DEFAULT ROLE "CONNECT",
                                  DBA,
                                  "RESOURCE";







CREATE TABLE Employees (
        EmployeeID number(10) NOT NULL ,
        LastName varchar2 (20) NOT NULL ,
        FirstName varchar2 (10) NOT NULL ,
        Title varchar2 (30) NULL ,
        TitleOfCourtesy varchar2 (25) NULL ,
        BirthDate date NULL,
        HireDate date NULL ,
        Address varchar2 (60) NULL ,
        City varchar2 (30) NULL ,
        Region varchar2 (15) NULL ,
        PostalCode varchar2 (10) NULL ,
        Country varchar2 (15) NULL ,
        HomePhone varchar2 (24) NULL ,
        Extension varchar2 (4) NULL ,
        Photo blob NULL ,
        Notes blob NULL ,
        ReportsTo number NULL ,
        PhotoPath varchar2 (255) NULL,
        PRIMARY KEY(EmployeeID),
        CONSTRAINT FK_Employees_Employees FOREIGN KEY (ReportsTo)
                REFERENCES Employees(EmployeeID)
        --CONSTRAINT CK_Birthdate CHECK (BirthDate < SYSDATE)
        );




4.northwind.oracle.sps.sql



5.northwind.oracle.seed.sql




6.northwind.oracle.constraints.sql



SELECT * FROM Employees;




SELECT TABLE_NAME FROM DBA_TABLES WHERE TABLESPACE_NAME = 'users';





SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'USERS';





SELECT TABLE_NAME FROM ALL_TABLES;






SELECT
    OWNER,
    TABLE_NAME,
    TABLESPACE_NAME
FROM
    ALL_TABLES;




SELECT
    OWNER,
    TABLE_NAME,
    TABLESPACE_NAME
FROM
    ALL_TABLES
WHERE
    OWNER IN ('SYS', 'ALBA');



SELECT	TABLESPACE_NAME FROM DBA_TABLESPACES;





SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'SYS';





SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'SYSTEM';

SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLE_NAME LIKE 'AU%';



SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS1';


 AUDIT_ACTIONS;





SELECT * FROM TESTUSER.REGIONS;

