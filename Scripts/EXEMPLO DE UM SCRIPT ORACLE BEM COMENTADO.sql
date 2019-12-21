create or replace procedure CYBELAR_EXP_TXT_NRSORTE is
  /****************************************************************
  * PROCEDURE : CYBELAR_EXP_TXT_NRSORTE 			  *
  * OBJETIVO  : Exporta dados de uma tabela para um arquivo texto *
  * CRIACAO   : 19-05-2009					  *
  * VERSAO    : 1.0						  *
  * AUTOR     : FABIO A. CAMPOS DA CRUZ -			  *
  ****************************************************************/

  -----------------------------------------------------
  -- DECLARACAO DE VARIAVEIS P/ CONTROLE DO PROCESSO --
  -----------------------------------------------------
  ARQ_NRSORTE UTL_FILE.file_type;
  VC_LINHA	VARCHAR2(8000) := NULL;
  VC_ARQ_NOME VARCHAR2(100) := NULL;
  VC_DIR_LOG  VARCHAR2(50) := NULL;
  VC_DIR_OUT  VARCHAR2(50) := NULL;
  VG_PROCESSO VARCHAR2(100) := 'CYBELAR_EXP_TXT_NRSORTE';

  ------------------------------------
  -- CURSOR PARA GERACAO DO ARQUIVO --
  ------------------------------------
  CURSOR CUR_NRSORTE IS
	SELECT NROSORTE,
		   LOJA,
		   MES_ANO,
		   CPF,
		   NOMCLI,
		   TELCLI,
		   PDV_CAIXA,
		   CODPRODSORT,
		   SERIESORTEIO,
		   NUMOPERADOR,
		   VLRTRANSACAO,
		   CODCLIENTE
	 FROM CYBELAR_NROSORTE
	 WHERE CPF IS NOT NULL
	 AND TO_CHAR(DATANRSORTE, 'YYMMDD') = TO_CHAR(SYSDATE, 'YYMMDD');

begin
  ---------------------
  -- BUSCA DIRETORIO --
  ---------------------
  BEGIN
	SELECT PINT_NM_DIRETORIO_LOG, PINT_NM_DIRETORIO_OUT
	  INTO VC_DIR_LOG, VC_DIR_OUT
	  FROM GEMCO_PARAMETRO_INTERFACE PINT, GEMCO_SISTEMA SIST
	 WHERE PINT.PINT_CD_SISTEMA = SIST.SIST_CD_SISTEMA
	   AND SIST.SIST_DS_SISTEMA = VG_PROCESSO;
  EXCEPTION
	-- SE NAO EXISTIR INFORMAR O DIRETORIO ONDE DEVERA SER
	-- GERADO O LOG DE OCORRENCIAS
	WHEN NO_DATA_FOUND THEN
	  VC_DIR_LOG := '/home/gemco/integra/Log';
	  VC_DIR_OUT := '/home/gemco/integra/Gemco-Legado';
	WHEN TOO_MANY_ROWS THEN
	  VC_DIR_LOG := '/home/gemco/integra/Log';
	  VC_DIR_OUT := '/home/gemco/integra/Gemco-Legado';
	WHEN OTHERS THEN
	  VC_DIR_LOG := '/home/gemco/integra/Log';
	  VC_DIR_OUT := '/home/gemco/integra/Gemco-Legado';
  END;

  -- SETA NOME DO ARQUIVO 
  VC_ARQ_NOME := 'NRSORTE_' || TO_CHAR(SYSDATE, 'DDMMYY_HH24MI') || '.txt';
  -- INICIA GRAVACAO
  ARQ_NRSORTE := UTL_FILE.fopen(VC_DIR_OUT, VC_ARQ_NOME, 'W');
  UTL_FILE.fclose(ARQ_NRSORTE);


  -----------------------------------------
  -- ABRE CURSOR PARA LEITURA E MONTAGEM --
  -----------------------------------------
  FOR CUR IN CUR_NRSORTE LOOP
	VC_LINHA := LPAD(CUR.NROSORTE, 5, 0) || ';' || LPAD(CUR.LOJA, 3, 0) || ';' ||
				TO_CHAR(CUR.MES_ANO, 'YYYYMMDD') || ';' ||
				LPAD(CUR.CPF, 11, 0) || ';' || CUR.NOMCLI || ';' ||
				LPAD(CUR.TELCLI, 10, ' ') || ';' ||
				LPAD(CUR.PDV_CAIXA, 3, 0) || ';' ||
				CUR.CODPRODSORT || ';' ||
				LPAD(CUR.SERIESORTEIO, 3, 0) || ';' ||
				LPAD(CUR.NUMOPERADOR, 3, 0) || ';' || CUR.VLRTRANSACAO || ';' ||
				LPAD(CUR.CODCLIENTE, 8, 0);
	-- GRAVA O REGISTRO NO ARQUIVO
	ARQ_NRSORTE := UTL_FILE.fopen(VC_DIR_OUT, VC_ARQ_NOME, 'A');
	UTL_FILE.put_line(ARQ_NRSORTE, VC_LINHA);
	UTL_FILE.fclose(ARQ_NRSORTE);
  END LOOP;
EXCEPTION
  WHEN UTL_FILE.INVALID_PATH THEN
	dbms_output.put_line('ERRO: INVALID PATH  - ' || SQLCODE || '  ' ||
						 SQLERRM);
  WHEN UTL_FILE.INVALID_MODE THEN
	dbms_output.put_line('ERRO: FILE ' || VC_DIR_LOG || ' / ' ||
						 VC_DIR_OUT || ' INVALID MODE  - ' || SQLCODE || '  ' ||
						 SQLERRM);
  WHEN UTL_FILE.INVALID_OPERATION THEN
	dbms_output.put_line('ERRO: FILE ' || VC_DIR_LOG || ' / ' ||
						 VC_DIR_OUT || ' INVALID OPERATION  - ' || SQLCODE || '  ' ||
						 SQLERRM);
  WHEN UTL_FILE.INVALID_FILEHANDLE THEN
	RAISE_APPLICATION_ERROR(-20902, SQLCODE || ' ' || SQLERRM);
  WHEN UTL_FILE.INTERNAL_ERROR THEN
	dbms_output.put_line('ERRO: INTERNAL ERROR  - ' || SQLCODE || '  ' ||
						 SQLERRM);
  WHEN UTL_FILE.READ_ERROR THEN
	dbms_output.put_line('ERRO: READ ERROR  - ' || SQLCODE || '  ' ||
						 SQLERRM);
  WHEN UTL_FILE.WRITE_ERROR THEN
	dbms_output.put_line('ERRO: WRITE ERROR  - ' || SQLCODE || '  ' ||
						 SQLERRM);
  WHEN VALUE_ERROR THEN
	dbms_output.put_line('ERRO: VALUE ERROR  - ' || SQLCODE || '  ' ||
						 SQLERRM);
  WHEN OTHERS THEN
	dbms_output.put_line(SQLCODE || '  ' || SQLERRM);
  
end CYBELAR_EXP_TXT_NRSORTE;