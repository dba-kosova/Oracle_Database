#!/bin/bash 
#

#************************************************#
# OBJETIVO  : create_file_about_audit_sqlplus 	 #
# CRIACAO   : 16-01-2020	                 	 #
# VERSAO    : 1.0		                     	 #
# AUTOR     : Pedro Akira Danno Lima             #
#************************************************#



#mudar diretorio
cd /home/oracle/auditsqlplus

#atribuir uma data a variavel date
DATE=$(date +"%m-%d-%y")

#criar arquivo
touch ${DATA}_sqlplus.sql




#****************************************************************************************************************#
#                                                   REFERENCIAS      	                                         #
#https://www.udemy.com/course/oracle-database-12c-rac-administration/learn/lecture/8874172#questions        	 #
#https://www.vivaolinux.com.br/topico/Red-Hat-Fedora/Como-configurar-teclado-para-ABNT2                          #
#https://github.com/pedroAkiraDanno/Linux/blob/master/Conceitos_de_Programacao_em_Shell_Script_Curso_Gratuito    #
#****************************************************************************************************************#
