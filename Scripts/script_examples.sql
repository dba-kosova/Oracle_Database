

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


fdisk -l

fdisk /dev/sdc
n
p
enter 
enter



# create mount dir
sudo mkdir /hdd6T

# new file system
sudo mkfs.ext4 /dev/sdc

# mount drive
sudo mount /dev/sdc /hdd6T/

# change ownership to specified user
sudo chown your-user:your-group /hdd6T/
chown -R oracle:oinstall /bkp



REPORT NEED BACKUP;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT  TABLESPACE_NAME FROM DBA_TABLESPACES;



SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS3';


SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'USERS';


SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = ''


SELECT FILE_NAME FROM DBA_DATA_FILES;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BISample Schema Installation on Oracle Database


https://www.youtube.com/watch?v=mKg0kPvaktg



@/home/oracle/BISAMPLE_DATA_825.SQL





-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




select * from dba_tablespace_usage_metrics
where tablespace_name in ('UNDOTBS1', 'SYSTEM'  )
order by 1;





-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SCHEMAS AND BACKUP TESTE



cd /opt


cnf git


zypper install git-core



cd /home/oracle



git clone https://github.com/oracle/db-sample-schemas.git




SELECT  TABLESPACE_NAME FROM DBA_TABLESPACES;



create tablespace TBS1
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;




@/home/oracle/db-sample-schemas/human_resources/hr_main.sql
oracle
TBS1
TEMP
$ORACLE_HOME/demo/schema/log/



ALTER USER hr ACCOUNT UNLOCK IDENTIFIED BY oracle;






create tablespace TBS2
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;



@/home/oracle/db-sample-schemas/customer_orders/co_main.sql
oracle
localhost:1521/AL1
TBS2
TEMP




SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS2';


ALTER USER co ACCOUNT UNLOCK IDENTIFIED BY oracle;






//@/home/oracle/db-sample-schemas/order_entry/oc_main.sql





















create tablespace TBS3
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;



@/home/oracle/db-sample-schemas/product_media/pm_main.sql
oracle
TBS3
TEMP
oracle
+DATA
$ORACLE_HOME/demo/schema/log/
v3
$ORACLE_HOME/demo/schema/
localhost:1521/AL1




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


@/home/oracle/db-sample-schemas/info_exchange/ix_main.sql


select object_type, count(*) from user_objects group by object_type;



 CONNECT TO hr;



 CONNECT sys/389102@localhost:1521/AL1 AS SYSDBA;

 CONNECT sys/oracle@localhost:1521/AL1 AS SYSDBA;



 alter user SYS identified by "newpassword";


 alter user SYS identified by "oracle";


 alter user SYS identified by  "newpassword";


https://stackoverflow.com/questions/740119/default-passwords-of-oracle-11g



alter session set container=AL1;




sqlplus / as sysdba

alter user system identified by oracle;




alter user sys identified by oracle;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



col username for a10

select username,sysdba,sysoper from v$pwfile_users;


ALTER USER sys IDENTIFIED BY "oracle";


SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS4';






https://oracle-base.com/articles/misc/install-sample-schemas





perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat


DESC ix.AQ$_ORDERS_QUEUETABLE_G;


@/home/oracle/db-sample-schemas/info_exchange/ix_main.sql



/home/oracle/db-sample-schemas/product_media/pm_main.sql

create tablespace TBS5
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Installation
The following schemas will be installed.

HR : Human Resources
OE : Order Entry
PM : Product Media
IX : Information Exchange
SH : Sales History
BI : Business Intelligence




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



@/home/oracle/db-sample-schemas/sales_history/sh_main.sql



create tablespace TBS6
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;






SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS5';





-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SIMPLE SCHEMAS






Installation
The following schemas will be installed.

HR : Human Resources
OE : Order Entry
PM : Product Media
IX : Information Exchange
SH : Sales History
BI : Business Intelligence







cd /opt


cnf git


zypper install git-core



cd /home/oracle



git clone https://github.com/oracle/db-sample-schemas.git




SELECT  TABLESPACE_NAME FROM DBA_TABLESPACES;



create tablespace TBS1
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;




@/u01/app/oracle/product/12.2.0/db_1/demo/schema/human_resources/hr_main_new.sql
oracle
TBS1
TEMP
$ORACLE_HOME/demo/schema/log/



ALTER USER hr ACCOUNT UNLOCK IDENTIFIED BY oracle;


SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS1';



create tablespace TBS2
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;



@/home/oracle/db-sample-schemas/order_entry/oc_main.sql
oracle
localhost:1521/AL1
TBS2
TEMP




SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS2';


ALTER USER co ACCOUNT UNLOCK IDENTIFIED BY oracle;





passwd oracle


sqlplus /nolog


connect / as sysdba

ALTER USER sys IDENTIFIED BY oracle;



sqlplus / as sysdba

alter user system identified by oracle;

alter user sys identified by oracle;




cd /home/oracle/db-sample-schemas

perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat



SELECT  TABLESPACE_NAME FROM DBA_TABLESPACES;



create tablespace TBS3
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;





@/home/oracle/db-sample-schemas/product_media/pm_main.sql
oracle
TBS3
TEMP
$ORACLE_HOME/demo/schema/log/
$ORACLE_HOME/demo/schema/
/u01/oradata
localhost:1521/AL1







create tablespace TBS4
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;


@/home/oracle/db-sample-schemas/info_exchange/ix_main.sql
TBS4
$ORACLE_HOME/demo/schema/log/
v3
localhost:1521/AL1





create tablespace TBS5
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;


@/home/oracle/db-sample-schemas/sales_history/sh_main.sql


localhost:1521/AL1





-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




dd





-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



works

HR : Human Resources
CO : Costumers Orders  
IX : Information Exchange



OE : Order Entry
PM : Product Media

SH : Sales History
BI : Business Intelligence







-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SIMPLE SCHEMAS v2.0









Installation
The following schemas will be installed.

HR : Human Resources
OE : Order Entry
PM : Product Media
IX : Information Exchange
SH : Sales History
BI : Business Intelligence







cd /opt


cnf git


zypper install git-core



cd /home/oracle



git clone https://github.com/oracle/db-sample-schemas.git




SELECT  TABLESPACE_NAME FROM DBA_TABLESPACES;



create tablespace TBS1
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;




@/u01/app/oracle/product/12.2.0/db_1/demo/schema/human_resources/hr_main_new.sql
oracle
TBS1
TEMP
$ORACLE_HOME/demo/schema/log/



ALTER USER hr ACCOUNT UNLOCK IDENTIFIED BY oracle;


SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS1';



create tablespace TBS2
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;






@/home/oracle/db-sample-schemas/order_entry/oc_cre.sql









@/home/oracle/db-sample-schemas/order_entry/oc_main.sql
oracle
localhost:1521/AL1
TBS2
TEMP




SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS2';


ALTER USER co ACCOUNT UNLOCK IDENTIFIED BY oracle;





passwd oracle


sqlplus /nolog


connect / as sysdba

ALTER USER sys IDENTIFIED BY oracle;



sqlplus / as sysdba

alter user system identified by oracle;

alter user sys identified by oracle;




cd /home/oracle/db-sample-schemas

perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat



SELECT  TABLESPACE_NAME FROM DBA_TABLESPACES;



create tablespace TBS3
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;





@/home/oracle/db-sample-schemas/product_media/pm_main.sql
oracle
TBS3
TEMP
$ORACLE_HOME/demo/schema/log/
$ORACLE_HOME/demo/schema/
/u01/oradata
localhost:1521/AL1







create tablespace TBS4
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;


@/home/oracle/db-sample-schemas/info_exchange/ix_main.sql
TBS4
$ORACLE_HOME/demo/schema/log/
v3
localhost:1521/AL1





create tablespace TBS5
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;


@/home/oracle/db-sample-schemas/sales_history/sh_main.sql


localhost:1521/AL1







-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SIMPLE SCHEMAS v3.0 FINAL



Installation
The following schemas will be installed.

HR : Human Resources
CO : Costumers Orders
IX : Information Exchange




cd /opt


cnf git


zypper install git-core



cd /home/oracle



git clone https://github.com/oracle/db-sample-schemas.git


root 
passwd oracle
oracle



SELECT  TABLESPACE_NAME FROM DBA_TABLESPACES;



create tablespace TBS1
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;




@/u01/app/oracle/product/12.2.0/db_1/demo/schema/human_resources/hr_main_new.sql
oracle
TBS1
TEMP
$ORACLE_HOME/demo/schema/log/



ALTER USER hr ACCOUNT UNLOCK IDENTIFIED BY oracle;


SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS1';



create tablespace TBS2
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;




@/home/oracle/db-sample-schemas/customer_orders/co_main.sql
oracle
localhost:1521/AL1
TBS2
TEMP



ALTER USER co ACCOUNT UNLOCK IDENTIFIED BY oracle;




cd /home/oracle/db-sample-schemas


perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat



SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS2';





sqlplus /nolog


connect / as sysdba

ALTER USER sys IDENTIFIED BY oracle;



sqlplus / as sysdba

alter user system identified by oracle;

alter user sys identified by oracle;




create tablespace TBS3
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;




@/home/oracle/db-sample-schemas/info_exchange/ix_main.sql
oracle
TBS3
TEMP
oracle
$ORACLE_HOME/demo/schema/log/
v3
localhost:1521/AL1

 





HR : Human Resources
CO : Costumers Orders
IX : Information Exchange


sqlplus / as sysdba

SELECT TABLESPACE_NAME FROM DBA_TABLESPACES;

SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS1';
SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS2';
SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS3';



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




drop table [Oracle SQL]

    
drop table table_name;
drop table table_name cascade constraints;
drop table table_name purge;


The drop table command moves a table into the recycle bin unless purge was also specified.


purge
Normally, a table is moved into the recycle bin (as of Oracle 10g), if it is dropped. However, if the purge modifier is specified as well, the table is unrecoverably (entirely) dropped from the database.


cascade constraints
Deletes all foreign keys that reference the table to be dropped, then drops the table.



Thanks
Thanks to Steve Parker and Thorir Olafsson who notified me of a typo on this page.










-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



  
FLASHBACK TABLE HR.REGIONS TO BEFORE DROP;



FLASHBACK TABLE CO.CUSTOMERS TO BEFORE DROP;

RECOVER TABLE CO.CUSTOMERS;




"to_date('29/12/2019 00:00:00','DD/MM/YYYY HH24:MI:SS')"



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


BACKUP



sqlplus / as sysdba
SQL> shutdown immediate;
SQL> startup mount;
SQL> alter database archivelog;
SQL> alter database open;




/*banco está em modo ARCHIVELOG*/
SELECT LOG_MODE FROM V$DATABASE;





sh> rman target /

  
RMAN> SHOW ALL;

RMAN> CONFIGURE CONTROLFILE AUTOBACKUP ON;


RMAN> CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 2 DAYS;


RMAN> CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/adirectory/anotherdirectory/%U'
RMAN> CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/bkp/%U';


RMAN> BACKUP DATABASE;



RMAN> BACKUP INCREMENTAL LEVEL 0 DATABASE;
RMAN> DELETE NOPROMPT OBSOLETE;
RMAN> SQL "alter database backup controlfile to trace as /adirectory/controlfile.txt"


RMAN> REPORT NEED BACKUP;



RMAN> LIST BACKUP SUMMARY;



RMAN> LIST BACKUP;



RMAN> RESTORE DATABASE VALIDATE;



RMAN> SET DBID <número do="" dbid="">;
RMAN> STARTUP FORCE NOMOUNT;</número>



RMAN> RESTORE CONTROLFILE FROM AUTOBACKUP;


RMAN> ALTER DATABASE MOUNT;



RMAN> RESTORE DATABASE PREVIEW;


RMAN> RESTORE DATABASE;


RMAN> RECOVER DATABASE UNTIL CANCEL;


RMAN> ALTER DATABASE OPEN RESETLOGS;






-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




DROP TABLESPACE USERS
   INCLUDING CONTENTS AND DATAFILES;




DROP TABLESPACE TBS1
   INCLUDING CONTENTS AND DATAFILES;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BACKUP


sqlplus / as sysdba;
SQL> shutdown immediate;
SQL> startup mount;
SQL> alter database archivelog;
SQL> alter database open;


rman target / 

CONFIGURE BACKUP OPTIMIZATION ON;




CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/bkp/%U';





// +ARCH/AL1/AUTOBACKUP/2019_12_28/s_1028237964.261.1028237965




RESTORE DATABASE  VALIDATE;



//SYSTEM
RESTORE DATAFILE 1 VALIDATE;




RESTORE TABLESPACE USERS VALIDATE;


RESTORE ARCHIVELOG ALL VALIDATE;




















srvctl stop database -d AL1



sqlplus / as sysdba


startup NOMOUNT;

sql 'alter database mount';

list backup of database;



list backup of controlfile;



startup nomount;

startup mount;










shut immediate;


startup nomount;


RESTORE CONTROLFILE FROM '+ARCH/AL1/AUTOBACKUP/2019_12_29/s_1028249622.260.1028249625';


ALTER DATABASE MOUNT;




LIST BACKUP OF DATABASE;


RESTORE DATABASE;



RECOVER DATABASE;



SQL 'ALTER DATABASE OPEN RESETLOGS';





-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


COL USERNAME FORMAT A10
COL USERHOST FORMAT A20
COL TERMINAL FORMAT A10
COL TIMESTAMP FORMAT A15
COL ACTION_NAME FORMAT A10
COL LOGOFF_TIME FORMAT A10


SELECT USERNAME,
       USERHOST,
       TERMINAL,
       TIMESTAMP,
       ACTION_NAME,
       LOGOFF_TIME
FROM  DBA_AUDIT_SESSION;









COL USERNAME FORMAT A5
COL USERHOST FORMAT A5
COL TERMINAL FORMAT A5
COL TIMESTAMP FORMAT A5
COL ACTION_NAME FORMAT A5
COL LOGOFF_TIME FORMAT A5








-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


To rename the column headings, and to select data from the HR sample schema view,
EMP_DETAILS_VIEW, enter



COLUMN FIRST_NAME HEADING "First Name"
COLUMN LAST_NAME HEADING "Family Name"
SELECT FIRST_NAME, LAST_NAME
FROM hr.EMP_DETAILS_VIEW
WHERE LAST_NAME LIKE 'K%';



OR


SELECT FIRST_NAME AS 'First Name' , LAST_NAME
FROM hr.EMP_DETAILS_VIEW
WHERE LAST_NAME LIKE 'K%';


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




CONNECT /@AL1


SET AUTOCOMMIT ON


DEFINE _EDITOR = vi




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



create tablespace TBS1AUDIT
datafile '+DATA'
size 500m
extent management local
uniform size 128k
segment space management auto;





SELECT TABLESPACE_NAME 
FROM DBA_TABLESPACES;



BEGIN
  
   
   --Modificando para a  auditoria simples, a AUD$
   DBMS_AUDIT_MGMT.SET_AUDIT_TRAIL_LOCATION(
    audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD
    , audit_trail_location_value => 'TBS1AUDIT'
     );
  
   
   --Modificando para a  auditoria de FGA, a FGA_LOG$
   DBMS_AUDIT_MGMT.SET_AUDIT_TRAIL_LOCATION(
    audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_FGA_STD
    , audit_trail_location_value => 'TBS1AUDIT'
     );    

END;



   DBMS_AUDIT_MGMT.SET_AUDIT_TRAIL_LOCATION(
    audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_FGA_STD
    , audit_trail_location_value => 'TBS1AUDIT'
     );  




SELECT TABLE_NAME
FROM ALL_TABLES 
WHERE TABLESPACE_NAME = 'SYSAUX' 
      AND TABLESPACE_NAME LIKE 'AUDSYS%';


SELECT * FROM SCOTT.EMP;
 



VIEW 
SYS.UNIDIED_AUDIT_TRAIL




COL VALUE FORMAT A45

SHOW PARAMETER AUD




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

HABILITAR Unified Auditing







 COL PARAMETER FORMAT A20
 COL value FORMAT A15
 select parameter,value from v$option where parameter='Unified Auditing';




PARAMETER            VALUE
-------------------- ---------------
Unified Auditing     FALSE






show parameter audit


desc dba_audit_trail;


host ( cd $ORACLE_HOME/rdbms/lib ; make -f ins_rdbms.mk uniaud_&2 ioracle ORACLE_HOME=$ORACLE_HOME )







cd $ORACLE_HOME/rdbms/lib


make -f ins_rdbms.mk uniaud_on ioracle ORACLE_HOME=$ORACLE_HOME


lsnrctl start


SELECT NAME,OPEN_MODE FROM V$PDBS;



connect sys@PDB3 as sysdba


CREATE AUDIT POLICY DP_POL ACTIONS COMPONENT=DATAPUMP EXPORT;


audit policy DP_POL;


col user_name format a10
col policy_name format a10



SELECT user_name,
       policy_name
FROM AUDIT_UNIFIED_ENABLED_POLICIES 
WHERE POLICY_NAME LIKE '%DP%';


SHOW CON_NAME;




SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS1';



SELECT * FROM HR.REGIONS;


CREATE DIRECTORY dump AS ‘/oracle/dump/’;

GRANT read, write ON DIRECTORY dump TO PUBLIC;




expdp SYSTEM/oracle@AL1 diretory=dump01 DUMPFILE=TEST1 TABLES=HR.REGIONS

expdp SYSTEM/oracle@AL1 directory=dump dumpfile=teste.dmp schema=HR logfile=teste.log


connect SYSTEM/oracle@AL1;



CREATE DIRECTORY dump03 AS ‘/u01/dump/’;

CREATE DIRECTORY dump03 AS '/u01/dump/';


expdp SYSTEM/oracle@AL1 diretory='/u01/dump/' DUMPFILE=TEST1 TABLES=HR.REGIONS


expdp SYSTEM/oracle@AL1 diretory=dpump_dir1 DUMPFILE=TEST1 TABLES=HR.REGIONS


GRANT READ, WRITE ON DIRECTORY dpump_dir1 TO SYSTEM;


expdp hr@AL1 DIRECTORY=dpump_dir1 DUMPFILE=hr.dmp TABLES=employees



CREATE DIRECTORY dum AS '/u01/';


GRANT READ, WRITE ON DIRECTORY dum TO PUBLIC;


expdp hr@AL1 DIRECTORY=dum DUMPFILE=hr.dmp TABLES=employees


expdp SYSTEM/oracle@AL1 diretory=dum DUMPFILE=TEST1 TABLES=HR.REGIONS


expdp SYS/oracle@AL1 diretory=dum DUMPFILE=TEST1 TABLES=HR.REGIONS





-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ALL_DIRECTORIES



COL OWNER FORMAT A5;

COL DIRECTORY_NAME FORMAT A25;

COL DIRECTORY_PATH FORMAT A55;

SET LINESIZE 32000;


SELECT OWNER,
       DIRECTORY_NAME,
       DIRECTORY_PATH
     FROM ALL_DIRECTORIES;




SELECT OWNER,
       DIRECTORY_NAME
FROM ALL_DIRECTORIES;


SELECT DIRECTORY_PATH
FROM ALL_DIRECTORIES;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT DBUSERNAME,
       DP_TEXT_PARAMETERS1,
       DP_BOOLEAN_PARAMETERS1,
FROM UNIFIED_AUDIT_TRAIL;    








-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ORACLE RAC 




COL OWNER FORMAT A5;


COL TABLE_NAME FORMAT A30;



SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS2';


DESC ALL_TABLES;


SELECT OWNER, TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'EXAMPLE';



SELECT OWNER,
       TABLE_NAME
FROM ALL_TABLES WHERE TABLESPACE_NAME = 'EXAMPLE'
ORDER BY OWNER;






-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
LOAD BALANCING ALGORITMO - ORACLE RAC


swingbeach



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT FILE_NAME FROM DBA_DATA_FILES;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE TALUNO
(
  NOME VARCHAR(30)
) 
TABLESPACE TBS2;





INSERT INTO TALUNO (NOME)
VALUES ('Pedro Akira Danno Lima');

INSERT INTO TALUNO (NOME)
VALUES ('Saty');


UPDATE TALUNO
SET NOME = 'Ivete'
WHERE NOME = 'Pedro Akira Danno Lima';


DELETE FROM TALUNO WHERE NOME = 'IVETE';



SELECT TABLE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME = 'TBS2';

SELECT * FROM V$LOG;








-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





/**********************************************************************************************************
*                                               REFERENCIAS                                               *
*                                                                                                         *
*https://www.askmlabs.com/2018/09/install-oracle-database-18c-in-silent_8.html                            *
*http://oracle-sql-procedimentos.blogspot.com/                                                            *
*https://unix.stackexchange.com/questions/315063/mount-wrong-fs-type-bad-option-bad-superblock            *
*https://nanxiao.me/en/how-to-install-git-on-suse/                                                        *
*https://www.youtube.com/watch?v=mKg0kPvaktg                                                              *
*https://dbakevlar.com/2017/03/manually-adding-sales-history-sh-schema-11-2-0-4/                          *
*https://stackoverflow.com/questions/740119/default-passwords-of-oracle-11g                               *
*https://stackoverflow.com/questions/18752676/alter-user-sys-identified-by-not-working                    *
*http://www.dba-oracle.com/t_reset_sys_password.html                                                      *
*https://databasesecurityninja.wordpress.com/2019/04/01/changing-sys-password-in-oracle-12cr2-and-18c/    *
*https://www.youtube.com/watch?v=BGywvemMyXA                                                              *                                                      
*https://www.youtube.com/watch?v=Y7IrPNUEOSM                                                              *
*https://oracle-base.com/articles/misc/install-sample-schemas                                             *
*http://www.adp-gmbh.ch/ora/sql/drop_table.html                                                           *
*http://nervinformatica.com.br/blog/index.php/2017/05/22/oracle-mini-manual-de-backup/                    *
*https://docs.oracle.com/cd/B19306_01/backup.102/b14192/bkup003.html                                      *
*https://docs.oracle.com/cd/B19306_01/server.102/b14357/ch12043.html                                      *
*https://www.youtube.com/watch?v=pHjvR_4gSwo                                                              *
*http://www.rauldba.com.br/expimp/                                                                        *
*https://dba.stackexchange.com/questions/54149/how-to-make-sqlplus-output-appear-in-one-line              *
***********************************************************************************************************/



