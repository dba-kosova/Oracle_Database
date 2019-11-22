rem  Run this script using TOAD or SQL*Plus.  TOAD...open this file, click 'Run Script' button
rem
rem  This script creates EMP and DEPT tables, the profiler tables, and a few objects used
rem  in the book and used by the profiler...
rem
rem  You will need resource privledges to run this script...ask your IT staff for assistance
rem     ...you can also email me at Dan@DanHotka.com with your questions
rem


drop table emp;
drop table dept;



CREATE TABLE DEPT (
 DEPTNO              NUMBER(2) NOT NULL,
 DNAME               VARCHAR2(14),
 LOC                 VARCHAR2(13),
 CONSTRAINT DEPT_PRIMARY_KEY PRIMARY KEY (DEPTNO));

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

CREATE TABLE EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 NUMBER(4),
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) NOT NULL,
 CONSTRAINT EMP_FOREIGN_KEY FOREIGN KEY (DEPTNO) REFERENCES DEPT (DEPTNO),
 CONSTRAINT EMP_PRIMARY_KEY PRIMARY KEY (EMPNO));

INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'17-NOV-81',5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'1-MAY-81',2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'9-JUN-81',2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'2-APR-81',2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'28-SEP-81',1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'20-FEB-81',1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'8-SEP-81',1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'3-DEC-81',950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'22-FEB-81',1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'3-DEC-81',3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'17-DEC-80',800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'09-DEC-82',3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'12-JAN-83',1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'23-JAN-82',1300,NULL,10);





CREATE OR REPLACE PROCEDURE looping_example
IS
   cursor emp_cur is
        select ename
        from emp;
   loop_counter   NUMBER := 0;
   ename   varchar2(10);
   
BEGIN
   open emp_cur;

   fetch emp_cur into ename;

   while emp_cur%FOUND
   LOOP
      loop_counter := loop_counter + 1;
      DBMS_OUTPUT.put_line 
          ('Record ' || loop_counter || ' is Employee ' || ename );
      fetch emp_cur into ename;
   END LOOP;

   DBMS_OUTPUT.put_line ('Procedure Looping Example is done');
   
   close emp_cur;
   
END;


/

CREATE OR REPLACE PACKAGE temperature IS
   PROCEDURE Temperature_Conversion ( IN_Temp number,IN_Type varchar2);
   FUNCTION Celsius_to_Fahrenheit ( IN_Temp NUMBER) Return Number;
   FUNCTION Fahrenheit_to_Celsius ( IN_Temp NUMBER) Return Number;
   
/******************************************************************************
   NAME:       temperature
   PURPOSE:    To calculate the desired information.

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        9/12/02             1. Created this package.

   PARAMETERS:
   INPUT:
   OUTPUT:
   RETURNED VALUE:
   CALLED BY:
   CALLS:
   EXAMPLE USE:     NUMBER := temperature.MyFuncName(Number);
                    temperature.MyProcName(Number, Varchar2);
   ASSUMPTIONS:
   LIMITATIONS:
   ALGORITHM:
   NOTES:

   Here is the complete list of available Auto Replace Keywords:
      Object Name:     temperature or temperature
      Sysdate:         9/12/02
      Date/Time:       9/12/02 5:43:38 PM
      Date:            9/12/02
      Time:            5:43:38 PM
      Username:         (set in TOAD Options, Procedure Editor)
      Trigger Options: %TriggerOpts%
******************************************************************************/
END temperature;
/

CREATE OR REPLACE PACKAGE BODY temperature AS

PROCEDURE temperature_conversion 
(IN_Temp number,
IN_Type varchar2)
IS
Converted_Temp NUMBER := 0;
/******************************************************************************
   NAME:       temperature_conversion
   PURPOSE:    To call the proper conversion rouitine

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        9/12/02      Dan Hotka        Created code

   PARAMETERS:
   INPUT: temperature and type of conversion
   OUTPUT: converted temperature
   RETURNED VALUE:  NUMBER
   CALLED BY:
   CALLS: celsius_to_fahrenheit or fahrenheit_to_celsius
   EXAMPLE USE:     NUMBER := temperature_conversion(10,C);
   ASSUMPTIONS:
   LIMITATIONS:
   ALGORITHM:
   NOTES:  execute giving temp and C for celsius to fahrenheit
           or F for fahrenheit to celsius

   Here is the complete list of available Auto Replace Keywords:
      Object Name:     temperature_conversion or temperature_conversion
      Sysdate:         9/12/02
      Date/Time:       9/12/02 5:09:56 PM
      Date:            9/12/02
      Time:            5:09:56 PM
      Username:         (set in TOAD Options, Procedure Editor)
      Trigger Options: %TriggerOpts%
******************************************************************************/

BEGIN

IF 	 IN_Type = 'C'
THEN
	Converted_Temp := TEMPERATURE.Celsius_to_Fahrenheit(IN_Temp);
	DBMS_OUTPUT.PUT_LINE('Fahrenheit = ' || Converted_Temp);
	RETURN;
ELSIF In_Type = 'F'
THEN
	Converted_temp := TEMPERATURE.Fahrenheit_to_Celsius(IN_Temp);
	DBMS_OUTPUT.PUT_LINE('Celsius = ' || Converted_Temp);
	RETURN; 
END IF;
DBMS_OUTPUT.PUT_LINE('Bad Temperature Conversion Code: ' ||
    IN_Type);
RETURN;  

END temperature_conversion;


FUNCTION celsius_to_fahrenheit (IN_Temp NUMBER)
RETURN NUMBER IS
Conv_Temp NUMBER;
/******************************************************************************
   NAME:       celsius_to_fahrenheit
   PURPOSE:    To calculate fahrenheit temp

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        9/12/02       Dan Hotka

   
******************************************************************************/
BEGIN
   Conv_Temp := (IN_Temp * 9/5) + 32;
   RETURN Conv_temp;
END celsius_to_fahrenheit;



FUNCTION fahrenheit_to_celsius (IN_Temp NUMBER)
RETURN NUMBER IS
Conv_Temp NUMBER;
/******************************************************************************
   NAME:       fahrenheit_to+celsius
   PURPOSE:    To calculate celsius temp

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        9/12/02       Dan Hotka

   
******************************************************************************/
BEGIN
   Conv_Temp := (5/9) * (IN_Temp - 32);
   RETURN Conv_temp;
END fahrenheit_to_celsius;

END temperature;
/ 

drop table plsql_profiler_data purge; 
drop table plsql_profiler_units purge; 
drop table plsql_profiler_runs purge; 

drop sequence plsql_profiler_runnumber;

CREATE TABLE plsql_profiler_runs
(
  runid           NUMBER primary key, -- unique run identifier, from plsql_profiler_runnumber
  related_run     NUMBER,                -- runid of related run (for client-server correlation)
  run_owner       VARCHAR2(32),     -- user that executed the procedure
  run_proc        VARCHAR2(256),     -- procedure that was executed
  run_date        DATE,                       -- start time of run
  run_comment     VARCHAR2(2047),      -- user provided comment for this run
  run_total_time  NUMBER,               -- elapsed time for this run
  run_system_info VARCHAR2(2047),      -- currently unused
  run_comment1    VARCHAR2(256),       -- additional comment
  spare1          VARCHAR2(256)        -- unused
);


COMMENT ON TABLE plsql_profiler_runs IS
        'Run-specific information for the PL/SQL profiler';
		
CREATE TABLE plsql_profiler_units
(
  runid              NUMBER references plsql_profiler_runs ON DELETE cascade,
  unit_number        NUMBER,            -- internally generated library unit #
  unit_type          VARCHAR2(32),     -- library unit type
  unit_owner         VARCHAR2(32),   -- library unit owner name
  unit_name          VARCHAR2(32),   -- library unit name
  unit_timestamp     DATE,
    -- timestamp on library unit, can be used to detect changes to unit between runs
  total_time         NUMBER DEFAULT 0 NOT NULL,
  spare1             NUMBER,           -- unused
  spare2             NUMBER,           -- unused
  primary key (runid, unit_number)
);


COMMENT ON TABLE plsql_profiler_units IS
        'Information about each library unit in a run';
		

CREATE TABLE plsql_profiler_data
(
  runid           NUMBER,                      -- unique (generated) run identifier
  unit_number     NUMBER,                -- internally generated library unit #
  line#           NUMBER NOT NULL,   -- line number in unit
  text            VARCHAR2(4000),   -- source for the line
  total_occur     NUMBER,         -- number of times line was executed
  total_time      NUMBER,           -- total time spent executing line
  min_time        NUMBER,          -- minimum execution time for this line
  max_time        NUMBER,         -- maximum execution time for this line
  spare1          NUMBER,           -- unused
  spare2          NUMBER,           -- unused
  spare3          NUMBER,           -- unused
  spare4          NUMBER,           -- unused
  primary key (runid, unit_number, line#),
  foreign key (runid, unit_number) references plsql_profiler_units ON DELETE CASCADE);



COMMENT ON TABLE plsql_profiler_data IS
        'Accumulated data from all profiler runs';
Prompt Creating package spec TOAD_PROFILER
CREATE OR REPLACE PACKAGE toad_profiler is
  procedure rollup_unit(run_number IN number, UnitNumber IN number,
    UnitType IN varchar2, UnitOwner IN varchar2, UnitName IN varchar2);
  procedure rollup_run(run_number IN number);
  procedure rollup_all_runs;
end toad_profiler;
/
Prompt Creating package body TOAD_PROFILER
CREATE OR REPLACE PACKAGE BODY toad_profiler is
  -- compute the total time spent executing this unit - the sum of the
  -- time spent executing lines in this unit (for this run)


  procedure rollup_unit(run_number IN number, UnitNumber IN number,
    UnitType IN varchar2, UnitOwner IN varchar2, UnitName IN varchar2) is


  TYPE TSourceTable IS TABLE OF VARCHAR2(4000) INDEX BY BINARY_INTEGER;
  SourceTable TSourceTable;
  TriggerBody long;
  FoundTriggerSource boolean;
  Cnt number;
  LnStart number;
  LnEnd   number;
  Pos number;
  vText varchar2(4000);
  IsWrapped boolean;
  TotalTime number;


  -- Select the lines for the unit to find source code
  cursor cLines(run_number number, UnitNumber number) is
    select line# from plsql_profiler_data
    where runid = run_number and unit_number = UnitNumber;
  begin
    select sum(total_time) into TotalTime
      from plsql_profiler_data
      where runid = run_number and unit_number = UnitNumber;


    if TotalTime IS NULL then
      TotalTime := 0;
    end if;


    update plsql_profiler_units set total_time = TotalTime
    where runid = run_number and unit_number = UnitNumber;


    -- Get trigger source into index-by table
    if UnitType = 'TRIGGER' then
      begin
        FoundTriggerSource := True;
        select trigger_body into TriggerBody
          from all_triggers where owner = UnitOwner and trigger_name = UnitName;
      exception
        when NO_DATA_FOUND then
          FoundTriggerSource := False;
      end;


      if FoundTriggerSource then
        Cnt     := 1;
        LnStart := 1;


        loop
          LnEnd := INSTR(TriggerBody, CHR(10), 1, Cnt);


          if (LnEnd = 0) then
            SourceTable(Cnt) := SubStr(TriggerBody, LnStart);
          else
            SourceTable(Cnt) := Substr(TriggerBody, LnStart, (LnEnd-LnStart));
          end if;


          LnStart := LnStart + (LnEnd-LnStart)+1;
          Cnt := Cnt+1;


          exit when (lnEnd = 0);
        end loop;
      end if;
    -- see if the code is wrapped
    else
      begin
        select upper(text) into vtext from all_source s
          where s.type = UnitType and s.owner = UnitOwner and
                s.name = UnitName and s.line = 1;
        IsWrapped := (INSTR(vText, ' WRAPPED') > 0);
      exception
        when NO_DATA_FOUND then
          IsWrapped := False;
      end;
    end if;


    -- Get the source for each line in unit
    Cnt := 1;
    for linerec in cLines(run_number, UnitNumber) loop
      if UnitType = 'TRIGGER' then
        if FoundTriggerSource then
          vText := SourceTable(linerec.line#);
        else
          if Cnt = 1 then
            vText := '<source unavailable>';
          else
            vText := null;
          end if;
        end if;
      else
        if IsWrapped then
          if Cnt = 1 then
            vText := '<wrapped>';
          else
            vText := null;
          end if;
        else
          begin
            select text into vtext from all_source s
              where s.type = UnitType and s.owner = UnitOwner and
                    s.name = UnitName and s.line = linerec.line#;
          exception
            when NO_DATA_FOUND then
              vText := null;
          end;
        end if;
      end if;
      -- store the source line
      update plsql_profiler_data d set d.text = vText
      where d.runid = run_number and d.unit_number = UnitNumber and
            d.line# = linerec.line#;
      Cnt := Cnt+1;
    end loop;
  end rollup_unit;






  -- rollup all units for the given run
  procedure rollup_run(run_number IN number) is
    tabpos number;
    comment varchar2(2047);
    proc varchar2(256);
    --
    -- only select those units which have not been rolled up yet
    cursor cunits(run_number number) is
      select unit_number, unit_type, unit_owner, unit_name
        from plsql_profiler_units
        where runid = run_number and total_time = 0
        order by unit_number asc;
  begin
    -- Fix Oracle's calling a 'PACKAGE' a 'PACKAGE SPEC'
    update plsql_profiler_units set unit_type = 'PACKAGE'
    where runid = run_number and unit_type like 'PACKAGE SPEC%';


    -- parse the RUN_COMMENT column to get the procedure name
  	-- (note: this replaces the BI_PLSQL_PROFILER_RUNS trigger.
    select run_proc, run_comment into proc, comment
	  from plsql_profiler_runs where runid = run_number;
    if proc is null then
      tabpos := INSTR(comment, CHR(8));
        if tabpos > 0 THEN
          proc := SUBSTR(comment, tabpos+1);
          comment := SUBSTR(comment, 1, tabpos-1);
        else
          proc := 'ANONYMOUS BLOCK';
        end if;
        update plsql_profiler_runs
          set run_owner = USER, run_proc = proc, run_comment = comment
          where runid = run_number;
    end if;




    for unitrec in cunits(run_number) loop
      rollup_unit(run_number, unitrec.unit_number, unitrec.unit_type,
                  unitrec.unit_owner, unitrec.unit_name);
    end loop;
  end rollup_run;




  -- rollup all runs
  procedure rollup_all_runs is
    cursor crunid is
      select runid from plsql_profiler_runs order by runid asc;
  begin
    for runidrec in crunid loop
      rollup_run(runidrec.runid);
    end loop crunid;
    commit;
  end rollup_all_runs;
end toad_profiler;
/

CREATE SEQUENCE plsql_profiler_runnumber START WITH 1 NOCACHE;


commit;

create or replace function seconds (nsec1 IN NUMBER)
RETURN NUMBER AS
nsec2 number(12,3);
begin
nsec2 := nsec1 / 1000000000;
return (nsec2);
END;
/

commit;

purge recyclebin;

exec dbms_stats.gather_schema_stats(USER,cascade => true);



commit;

exit; 

