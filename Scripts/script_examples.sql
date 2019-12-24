

/**************************************************************
 * FILE NAME:  script_examples.sql                            *
 *                                                            *
 * PURPOSE: Tests in database oracle                          *
 *                                                            *
 *                                                            *
 * Date        Author                       Release           *
 * 23-12-19    Pedro Akira Danno Lima       -------           *
 *                                                            * 
 *************************************************************/







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



shutdown immediate;


startup mount:

alter databse open resetlogs;




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

SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS3';


SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS1';


 AUDIT_ACTIONS;





SELECT * FROM TESTUSER.REGIONS;




SELECT TABLESPACE_NAME FROM ALL_TABLES;








SELECT HR.D.DEPARTMENT_NAME, 
       HR.L.CITY  
FROM  HR.DEPARTMENTS D
INNER JOIN HR.LOCATIONS L ON  
HR.D.LOCATION_ID = HR.L.LOCATION_ID;







-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create tablespace TBS2
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;




create tablespace TBS3
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;




create tablespace TBS1
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;




ALTER USER hr ACCOUNT UNLOCK IDENTIFIED BY oracle;





CREATE TABLE TALUNO
(
  COD_ALUNO INTEGER NOT NULL,
  NOME VARCHAR(30),
  CIDADE VARCHAR2(30),
  CEP VARCHAR(10),
  PRIMARY KEY (COD_ALUNO)
) 
TABLESPACE TBS2;



SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS2';




CREATE TABLE TCURSO
(  COD_CURSO INTEGER NOT NULL PRIMARY KEY,
   NOME VARCHAR2(30),
   VALOR NUMBER(8,2),
   CARGA_HORARIA INTEGER
)
TABLESPACE TBS2;


SELECT * FROM TCURSO;


CREATE TABLE TCONTRATO
(  COD_CONTRATO INTEGER NOT NULL PRIMARY KEY,
   DATA DATE,
   COD_ALUNO INTEGER,
   TOTAL NUMBER(8,2),
   DESCONTO NUMBER(5,2)
)
TABLESPACE TBS2;



SELECT * FROM TCONTRATO;


CREATE TABLE TITEM
 ( COD_ITEM INTEGER NOT NULL PRIMARY KEY,
   COD_CURSO INTEGER,
   COD_CONTRATO INTEGER,
   VALOR NUMBER(8,2) )
TABLESPACE TBS2;


 SELECT * FROM TITEM;




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


select username
from dba_users
where username
not in('QS_CB','PERFSTAT','QS_ADM',
'PM','SH','HR','OE',
'ODM_MTR','WKPROXY','ANONYMOUS',
'OWNER','SYS','SYSTEM','SCOTT',
'SYSMAN','XDB','DBSNMP','EXFSYS',
'OLAPSYS','MDSYS','WMSYS','WKSYS',
'DMSYS','ODM','EXFSYS','CTXSYS','LBACSYS',
'ORDPLUGINS','SQLTXPLAIN','OUTLN',
'TSMSYS','XS$NULL','TOAD','STREAM',
'SPATIAL_CSW_ADMIN','SPATIAL_WFS_ADMIN',
'SI_INFORMTN_SCHEMA','QS','QS_CBADM',
'QS_CS','QS_ES','QS_OS','QS_WS','PA_AWR_USER',
'OWBSYS_AUDIT','OWBSYS','ORDSYS','ORDDATA',
'ORACLE_OCM','MGMT_VIEW','MDDATA',
'FLOWS_FILES','FLASHBACK','AWRUSER',
'APPQOSSYS','APEX_PUBLIC_USER',
'APEX_030200','FLOWS_020100');






-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




select a.tablespace_name, a.total TOTAL_MB, a.total - b.free USADO_MB,
       b.free LIVRE_MB, (b.free * 100) / a.total PCT_LIVRE,
       (100 - ((b.free * 100) / a.total)) PCT_USADO
from    (select sum(bytes)/1024/1024 total, tablespace_name from dba_data_files group by tablespace_name
         union
         select sum(bytes)/1024/1024 total, tablespace_name from dba_temp_files group by tablespace_name) a,
        (select sum(bytes)/1024/1024 free,  tablespace_name from dba_free_space group by tablespace_name) b
where   b.tablespace_name(+) = a.tablespace_name
order by 6 desc;






-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RMAN


/*connect rman*/
$ rman target /


/*connect sqlplus*/
$ sqlplus / as sysdba


/*connect asm*/
$ asmcmd







/*comandos rman*/

/*Para exibir a configuração atual da ferramenta execute:*/
SHOW ALL;


CONFIGURE CONTROLFILE AUTOBACKUP ON;



fdisk /dev/sdc

# create mount dir
sudo mkdir /hdd6T

# new file system
sudo mkfs.ext4 /dev/sdc

# mount drive
sudo mount /dev/sdc /hdd6T/

# change ownership to specified user
sudo chown your-user /hdd6T/



REPORT NEED BACKUP;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT  TABLESPACE_NAME FROM DBA_TABLESPACES;



SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS1';


SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'USERS';


SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = '


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BISample Schema Installation on Oracle Database


https://www.youtube.com/watch?v=mKg0kPvaktg



@/home/oracle/BISAMPLE_DATA_825.SQL





-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




select * from dba_tablespace_usage_metrics
where tablespace_name in ('UNDOTBS1', 'SYSTEM'  )
order by 1;





-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





/**********************************************************************************************************
*                                               REFERENCIAS                                               *
*                                                                                                         *
*https://www.askmlabs.com/2018/09/install-oracle-database-18c-in-silent_8.html                            *
*http://oracle-sql-procedimentos.blogspot.com/                                                            *
*https://unix.stackexchange.com/questions/315063/mount-wrong-fs-type-bad-option-bad-superblock            *
*https://nanxiao.me/en/how-to-install-git-on-suse/                                                        *
*https://www.youtube.com/watch?v=mKg0kPvaktg                                                              *
***********************************************************************************************************/