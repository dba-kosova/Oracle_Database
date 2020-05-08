

---------------------------------------------------------------------------------------------------------------------------------
#backup INCREMENTAL differencial level 0 





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
#https://e-tinet.com/linux/crontab/ 																			 #
#****************************************************************************************************************#















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
#https://e-tinet.com/linux/crontab/ 																			 #
#****************************************************************************************************************#















---------------------------------------------------------------------------------------------------------------------------------