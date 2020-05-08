
/**************************************************************
 * FILE NAME:  script_examples2_0.sql                         *
 *                                                            *
 * PURPOSE: Tests in database oracle                          *
 *                                                            *
 *                                                            *
 * Date        Author                       Release           *
 * 23-12-19    Pedro Akira Danno Lima       -------           *
 *                                                            * 
 *************************************************************/













Oracle_Database_12c_Backup_and_Recovery_using_RMAN





CONFIGURE CONTROLFILE AUTOBACKUP FORMAT
FOR DEVICE TYPE DISK TO 'u01/backupdata/cf_%F';



CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/backups/XE_cf_%F';


CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK CLEAR;


DELETE BACKUPSET TAG 'TAG20200506T215457';


BACKUP DATABASE FORMAT '/backups/XE_full_%U.bck';


/u01/app/oracle/diag/rdbms/xe/XE/trace/alert_XE.log


BACKUP INCREMENTAL LEVEL 0 DATABASE FORMAT '/backups/XEtest_incre_%U.bck';


BCT block change tracking 




DB_CREATE_FILE_DEST











SQL 'col S_KEY format a4
col STATUS format a11
SELECT TO_CHAR(SESSION_KEY) S_KEY, INPUT_TYPE, STATUS,
 TO_CHAR(START_TIME,'dd/mm/yy hh24:mi') START_TIME,
 TO_CHAR(END_TIME,'dd/mm/yy hh24:mi') END_TIME,
 ELAPSED_SECONDS/60 MINS
FROM V$RMAN_BACKUP_JOB_DETAILS
WHERE START_TIME > SYSDATE-1 -- this condition is just to reduce the output
ORDER BY SESSION_KEY;'





col S_KEY format a4
col STATUS format a11
SELECT TO_CHAR(SESSION_KEY) S_KEY, INPUT_TYPE, STATUS,
 TO_CHAR(START_TIME,'dd/mm/yy hh24:mi') START_TIME,
 TO_CHAR(END_TIME,'dd/mm/yy hh24:mi') END_TIME,
 ELAPSED_SECONDS/60 MINS
FROM V$RMAN_BACKUP_JOB_DETAILS
WHERE START_TIME > SYSDATE-1 -- this condition is just to reduce the output
ORDER BY SESSION_KEY;












BACKUP .. KEEP {UNTIL TIME [=] ' date_string ' | FOREVER} |
NOKEEP [RESTORE POINT rsname]






    25  #atribuir uma data a variavel date
    26  DATA=$(date +"%m-%d-%y")
    27
    28  #criar arquivo
    29  touch ${DATA}_sqlplus.sql







nls_date_format



sysdate 


CONTROL_FILE_RECORD_KEEP_TIME





#!/bin/bash 
#

#************************************************#
# OBJETIVO  : script_rman_backup			 	 #
# CRIACAO   : 07-05-2020	                 	 #
# VERSAO    : 1.0		                     	 #
# AUTOR     : Pedro Akira Danno Lima             #
#************************************************#


#variaveis
RMANBACKUP_LOCATION=/backups

#atribuir uma data a variavel date
DATA=$(date +"%m-%d-%y")




run{
	rman target / <<EOF>> /home/oracle/backup.log
	set echo on;
	CONFIGURE CONTROLFILE AUTOBACKUP ON;
	CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '$RMANBACKUP_LOCATION/%F${DATA}';

	BACKUP DATABASE PLUS ARCHIVELOG;

}





#****************************************************************************************************************#
#                                                   REFERENCIAS      	                                         #
#https://www.udemy.com/course/oracle-database-12c-rac-administration/learn/lecture/8874172#questions        	 #
#https://www.vivaolinux.com.br/topico/Red-Hat-Fedora/Como-configurar-teclado-para-ABNT2                          #
#https://github.com/pedroAkiraDanno/Linux/blob/master/Conceitos_de_Programacao_em_Shell_Script_Curso_Gratuito    #
#https://www.udemy.com/course/conceitos-de-programacao-em-shell-script/learn/lecture/13868716#overview           #
#https://dbatricksworld.com/how-to-backup-oracle-rac-11gr2-database-with-rman-backup-utility-with-the-help-of-dbms_scheduler-part-i-rman-full-database-backup/#
#****************************************************************************************************************#





















#!/bin/bash
#

#************************************************#
# OBJETIVO  : script_rman_backup                 #
# CRIACAO   : 07-05-2020                         #
# VERSAO    : 1.0                                #
# AUTOR     : Pedro Akira Danno Lima             #
#************************************************#


#variaveis
        RMANBACKUP_LOCATION=/backups

        #atribuir uma data a variavel date
        DATE=$(date +"%d-%m-%y")

        #atribuir hora a variavel time
        TIME=$(date +"%T")




run{
        rman target / <<EOF>> /home/oracle/scripts/logs/rman_script2_weekly_full_${DATE}_${TIME}.log
        set echo on;
        CONFIGURE CONTROLFILE AUTOBACKUP ON;
        CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '$RMANBACKUP_LOCATION/%F_${DATE}_${TIME}';

        BACKUP DATABASE FORMAT '/backups/XE_full_${DATE}_${TIME}_%U.bck';;

}





#****************************************************************************************************************#
#                                                   REFERENCIAS                                                  #
#https://www.udemy.com/course/oracle-database-12c-rac-administration/learn/lecture/8874172#questions             #
#https://www.vivaolinux.com.br/topico/Red-Hat-Fedora/Como-configurar-teclado-para-ABNT2                          #
#https://github.com/pedroAkiraDanno/Linux/blob/master/Conceitos_de_Programacao_em_Shell_Script_Curso_Gratuito    #
#https://www.udemy.com/course/conceitos-de-programacao-em-shell-script/learn/lecture/13868716#overview           #
#https://dbatricksworld.com/how-to-backup-oracle-rac-11gr2-database-with-rman-backup-utility-with-the-help-of-dbms_scheduler-part-i-rman-full-database-backup/#
#****************************************************************************************************************#















- Enable Block Change Tracking (BCT)


SELECT status, filename FROM V$BLOCK_CHANGE_TRACKING;


































date +"%T"


DB_CREATE_FILE_DEST









#!/bin/bash
#

#************************************************#
# NOME      : rman_script2_weekly_full.sh        #
# OBJETIVO  : Script to run weekly full backup   #
# CRIACAO   : 07-05-2020                         #
# VERSAO    : 1.0                                #
# AUTOR     : Pedro Akira Danno Lima             #
#************************************************#


#variaveis
        #localizacao do diretorio de backup
        RMANBACKUP_LOCATION=/backups

        #atribuir uma data a variavel date
        DATE=$(date +"%d-%m-%y")

        #atribuir hora a variavel time
        TIME=$(date +"%T")

        #localizacao do log de backup
        RMANLOG=/home/oracle/scripts/logs




run{
        rman target / <<EOF>> ${RMANLOG}/rman_script2_weekly_full_${DATE}_${TIME}.log
        set echo on;
        ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
        CONFIGURE CONTROLFILE AUTOBACKUP ON;

        sql 'alter system swith logfile';
        sql 'alter system checkpoint';

        CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '$RMANBACKUP_LOCATION/%F_${DATE}_${TIME}';

        BACKUP DATABASE FORMAT '$RMANBACKUP_LOCATION/XE_full_${DATE}_${TIME}_%U.bck';
        BACKUP SPFILE TAG 'SPF_FULL' FORMAT 'RMANBACKUP_LOCATION/SPF_FULL_%F_${DATE}_${TIME}';
        BACKUP ARCHIVELOG TAG 'ARCH_FULL' FORMAT 'RMANBACKUP_LOCATION/ARCH_FULL_%F_${DATE}_${TIME}';

}





#****************************************************************************************************************#
#                                                   REFERENCIAS                                                  #
#https://www.udemy.com/course/oracle-database-12c-rac-administration/learn/lecture/8874172#questions             #
#https://www.vivaolinux.com.br/topico/Red-Hat-Fedora/Como-configurar-teclado-para-ABNT2                          #
#https://github.com/pedroAkiraDanno/Linux/blob/master/Conceitos_de_Programacao_em_Shell_Script_Curso_Gratuito    #
#https://www.udemy.com/course/conceitos-de-programacao-em-shell-script/learn/lecture/13868716#overview           #
#https://dbatricksworld.com/how-to-backup-oracle-rac-11gr2-database-with-rman-backup-utility-with-the-help-of-dbms_scheduler-part-i-rman-full-database-backup/#
#http://www.dba-oracle.com/t_rman_scheduling_backup.htm 														 #
#http://oracledbawings.blogspot.com/2011/05/how-to-schedule-rman-daily-backup.html								 #
#****************************************************************************************************************#













                        begin
                        	dbms_scheduler.create_schedule(
                        	schedule_name  =>  'schedulerman',
                        	repeat_interval  =>  ' FREQ=DAILY; INTERVAL=1;
							BYDAY=MON,TUE,WED,THU,FRI,SAT,SUN;  BYHOUR=15;
							BYMINUTE=45;BYSECOND=10',
                        	comments   =>   'schedule to run daily at 3.45pm');

							dbms_scheduler.create_program
                        	(  program_name   =>  'programrman',
                        	program_type   =>   'EXECUTABLE',
                        	program_action  =>  '/home/oracle/scripts/rman_script.sh',
                        	enabled  =>  TRUE,
                        	comments   =>  'Backup of db using rman.'
                        	);


                        	dbms_scheduler.create_job
                        	(  job_name  =>  'daily_backup',
                        	program_name   =>  'programrman',
                        	schedule_name  =>  'schedulerman',
                        	enabled  =>  true,
                        	comments  =>  'database daily backup at 3.45pmthrough rman.'
                        	);
						end;
						/






begin
	dbms_scheduler.run_job('schedulerman');
end;
/






select SESSION_KEY, INPUT_TYPE, STATUS,
to_char(START_TIME,'mm/dd/yy hh24:mi') start_time,
to_char(END_TIME,'mm/dd/yy hh24:mi') end_time,
elapsed_seconds/3600 hrs
from V$RMAN_BACKUP_JOB_DETAILS
order by session_key;

















begin
dbms_scheduler.create_job(
job_name => 'rman_weekly_full2',
job_type => 'EXECUTABLE',
job_action => '/bin/sh',
number_of_arguments => 1,
start_date => SYSTIMESTAMP,
credential_name => 'Oracle',
auto_drop => FALSE,
enabled => FALSE);
end;
/



begin
dbms_scheduler.set_job_argument_value(
job_name => 'rman_weekly_full2',
argument_position => 1,
argument_value => '/home/oracle/RMAN/Scripts/daily_incrmental.sh');
end;
/




















BEGIN
  DBMS_SCHEDULER.CREATE_PROGRAM(
    program_name   => 'sys.rman_weekly_full',
    program_type   => 'executable',
    program_action => '/home/oracle/scripts/rman_script.sh',
    enabled        =>  TRUE);
 
  DBMS_SCHEDULER.SET_ATTRIBUTE('sys.rman_script', 'detached', TRUE);
 
  DBMS_SCHEDULER.CREATE_JOB(
    job_name        => 'sys.rman_weekly_full',
    program_name    => 'sys.rman_weekly_full',
    repeat_interval => 'FREQ=daily;byhour=1;byminute=0;bysecond=0');
 
  DBMS_SCHEDULER.ENABLE('sys.rman_script');
END;
/



SELECT owner, job_name, enabled FROM dba_scheduler_jobs;


























sql "alter session set nls_date_format="dd.mm.yyyy hh24:mi:ss"";



select value from v$nls_parameters where parameter = 'NLS_LANGUAGE';
select value from v$nls_parameters where parameter = 'NLS_TERRITORY'; 
SQL> select value from v$nls_parameters where parameter = 'NLS_CHARACTERSET';




Backup strategy may include:
	- Whole: entire database
	- Partial: portion of the database

BACKUP TYPE:
	-FULL 

	-INCREMENTAL 
		-DIFFERENTIAL: changes since last incremental
		-CUMULATIVE: changes since last level 0

BACKUP MODE:
	OFFILINE (consistent,cold)
	ONLINE (inconsistent, hot)














RMAN Format Specifiers


formatSpec

---------------------------------------------------------------------------------------------------------------------------------





#!/bin/bash
#

#************************************************#
# NOME      : rman_script2_weekly_full.sh        #
# OBJETIVO  : Script to run weekly full backup   #
# CRIACAO   : 07-05-2020                         #
# VERSAO    : 1.0                                #
# AUTOR     : Pedro Akira Danno Lima             #
#************************************************#


#variaveis
        #localizacao do diretorio de backup
        RMANBACKUP_LOCATION=/backups

        #atribuir uma data a variavel date
        DATE=$(date +"%d-%m-%y")

        #atribuir hora a variavel time
        TIME=$(date +"%T")

        #localizacao do log de backup
        RMANLOG=/home/oracle/scripts/logs




run{
        rman target / <<EOF>> ${RMANLOG}/rman_script2_weekly_full_${DATE}_${TIME}.log
        set echo on;
        ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
        CONFIGURE CONTROLFILE AUTOBACKUP ON;

        sql 'alter system swith logfile';
        sql 'alter system checkpoint';
        sql 'alter database backup controlfile to trace as /backups/controlfile${DATE}_${TIME}.txt';

        CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '$RMANBACKUP_LOCATION/%F_${DATE}_${TIME}';

        BACKUP INCREMENTAL LEVEL 0 DATABASE PLUS ARCHIVELOG FORMAT '$RMANBACKUP_LOCATION/XE_full_${DATE}_${TIME}_%U.bck';
        #BACKUP SPFILE TAG 'SPF_FULL' FORMAT 'RMANBACKUP_LOCATION/SPF_FULL_${DATE}_${TIME}';
        #BACKUP ARCHIVELOG ALL TAG 'ARCH_FULL' FORMAT 'RMANBACKUP_LOCATION/ARCH_FULL_${DATE}_${TIME}';

}





#****************************************************************************************************************#
#                                                   REFERENCIAS                                                  #
#https://www.udemy.com/course/oracle-database-12c-rac-administration/learn/lecture/8874172#questions             #
#https://www.vivaolinux.com.br/topico/Red-Hat-Fedora/Como-configurar-teclado-para-ABNT2                          #
#https://github.com/pedroAkiraDanno/Linux/blob/master/Conceitos_de_Programacao_em_Shell_Script_Curso_Gratuito    #
#https://www.udemy.com/course/conceitos-de-programacao-em-shell-script/learn/lecture/13868716#overview           #
#https://dbatricksworld.com/how-to-backup-oracle-rac-11gr2-database-with-rman-backup-utility-with-the-help-of-dbms_scheduler-part-i-rman-full-database-backup/#
#http://www.dba-oracle.com/t_rman_scheduling_backup.htm 														 #
#http://oracledbawings.blogspot.com/2011/05/how-to-schedule-rman-daily-backup.html								 #
#****************************************************************************************************************#







DBLVL1
DBLVL0


CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 7 DAYS;



		






if [ -e ${FILE_DAY}]
then
	echo " o diretorio existe"
else
	echo " o diretorio não existe vamos criar o diretorio"
	mkdir ${FILE_DAY}
fi









rman target / @/home/oracle/RMAN/Scripts/Weekly_full.rcv


du -sh
If you want to check the total disk space used by a particular directory, use the -s flag.














#!/bin/bash
#

#************************************************#
# NOME      : rman_script2_weekly_full.sh        #
# OBJETIVO  : Script to run weekly full backup   #
# CRIACAO   : 07-05-2020                         #
# VERSAO    : 1.0                                #
# AUTOR     : Pedro Akira Danno Lima             #
#************************************************#


#variaveis
        #localizacao do diretorio de backup
        RMANBACKUP_LOCATION=/backups

        #atribuir uma data a variavel date
        DATE=$(date +"%d-%m-%y")

        #atribuir hora a variavel time
        TIME=$(date +"%T")

        #localizacao do log de backup
        RMANLOG=/home/oracle/scripts/logs

        #criar diretorio para organizar backup
        DIR_BKP_DAYS=${RMANBACKUP_LOCATION}/${DATE}

        #criar diretorio para organizar logs da saida do scripts
        DIR_LOGS=${RMANLOG}/${DATE}


#criacao de diretorio para organizar backups 		
		if [ -d "${DIR_BKP_DAYS}" ];then
			echo " o diretorio ${DIR_BKP_DAYS} existe ja"
		else
			echo " o diretorio ${DIR_BKP_DAYS} nao existe vamos criar o diretorio"
			mkdir ${DIR_BKP_DAYS}
		fi


#criacao de diretorio para organizar logs da saida do scripts 	
		if [ -d "${DIR_LOGS}" ];then
			echo " o diretorio ${DIR_LOGS} existe ja"
		else
			echo " o diretorio ${DIR_LOGS} nao existe vamos criar o diretorio"
			mkdir ${DIR_LOGS}
		fi		




run{
        rman target / <<EOF>> ${DIR_LOGS}/rman_script2_weekly_full_${DATE}_${TIME}.log
        set echo on;
        ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
        CONFIGURE CONTROLFILE AUTOBACKUP ON;

        sql 'alter system swith logfile';
        sql 'alter system checkpoint';
        sql 'alter database backup controlfile to trace as /backups/controlfile${DATE}_${TIME}.txt';

        CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '${DIR_BKP_DAYS}/%F_${DATE}_${TIME}';
        BACKUP INCREMENTAL LEVEL 0 DATABASE PLUS ARCHIVELOG  FORMAT '${DIR_BKP_DAYS}/XE_full_${DATE}_${TIME}_%U.bck';

}





#****************************************************************************************************************#
#                                                   REFERENCIAS                                                  #
#https://dbatricksworld.com/																					 #
#http://www.dba-oracle.com/t_rman_scheduling_backup.htm 														 #
#http://oracledbawings.blogspot.com/2011/05/how-to-schedule-rman-daily-backup.html								 #
#https://www.ostechnix.com/find-size-directory-linux/															 #
#****************************************************************************************************************#







































#!/bin/bash
#

#**************************************************************************#
# NOME      : rman_script2_daily_incremental.sh        					   #
# OBJETIVO  : Script to run daily incremental differential= level 1 backup #
# CRIACAO   : 07-05-2020                         						   #
# VERSAO    : 1.0                                						   #
# AUTOR     : Pedro Akira Danno Lima             						   #
#**************************************************************************#


#variaveis
        #localizacao do diretorio de backup
        RMANBACKUP_LOCATION=/backups

        #atribuir uma data a variavel date
        DATE=$(date +"%d-%m-%y")

        #atribuir hora a variavel time
        TIME=$(date +"%T")

        #localizacao do log de backup
        RMANLOG=/home/oracle/scripts/logs




run{
        rman target / <<EOF>> ${RMANLOG}/rman_script2_daily_incremental_${DATE}_${TIME}.log
        set echo on;
        ALLOCATE CHANNEL c1 DEVICE TYPE DISK;
        CONFIGURE CONTROLFILE AUTOBACKUP ON;

        sql 'alter system swith logfile';
        sql 'alter system checkpoint';

        CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '$RMANBACKUP_LOCATION/%F_${DATE}_${TIME}';

        # differentail incremental backup 
        BACKUP INCREMENTAL LEVEL 1 DATABASE FORMAT '$RMANBACKUP_LOCATION/XE_incre_${DATE}_${TIME}_%U.bck';
        BACKUP SPFILE TAG 'SPF_INCRE' FORMAT 'RMANBACKUP_LOCATION/SPF_INCRE_%F_${DATE}_${TIME}';
        BACKUP ARCHIVELOG TAG 'ARCH_INCRE' FORMAT 'RMANBACKUP_LOCATION/ARCH_INCRE_%F_${DATE}_${TIME}';

}





#****************************************************************************************************************#
#                                                   REFERENCIAS                                                  #
#https://www.udemy.com/course/oracle-database-12c-rac-administration/learn/lecture/8874172#questions             #
#https://www.vivaolinux.com.br/topico/Red-Hat-Fedora/Como-configurar-teclado-para-ABNT2                          #
#https://github.com/pedroAkiraDanno/Linux/blob/master/Conceitos_de_Programacao_em_Shell_Script_Curso_Gratuito    #
#https://www.udemy.com/course/conceitos-de-programacao-em-shell-script/learn/lecture/13868716#overview           #
#https://dbatricksworld.com/how-to-backup-oracle-rac-11gr2-database-with-rman-backup-utility-with-the-help-of-dbms_scheduler-part-i-rman-full-database-backup/#
#http://www.dba-oracle.com/t_rman_scheduling_backup.htm 														 #
#http://oracledbawings.blogspot.com/2011/05/how-to-schedule-rman-daily-backup.html								 #
#****************************************************************************************************************#






