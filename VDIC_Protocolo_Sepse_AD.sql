/*
CREATED BY SAMIRA ALVES LUCIO DIAS
DATE: 29/10/2020
GOAL: Report developed to return data about sepse protocol filled by nurse staff
*/

CREATE OR REPLACE FORCE VIEW VDIC_REPORT_SEPSE_AD (
       cd_registro_documento
      ,cd_atendimento
      ,nm_paciente
      ,cd_documento
      ,nm_usuario
      ,DIA_PEDIDO
      ,HORARIO
      ,dt_registro
      ,cd_pergunta_doc
      ,ds_pergunta
      ,ds_resposta
      ,perguntas
      ,STATUS
) AS

SELECT  registro_documento.cd_registro_documento
       ,registro_documento.cd_atendimento
       ,paciente.nm_paciente
       ,registro_documento.cd_documento
       ,registro_documento.nm_usuario
       ,to_char(registro_documento.dt_registro,'DD/MM/YYYY')DIA_PEDIDO
       ,to_char(registro_documento.dt_registro,'HH24:MI:SS')HORARIO 
       ,registro_documento.dt_registro
       ,registro_resposta.cd_pergunta_doc
       ,pergunta_doc.ds_pergunta
       ,registro_resposta.ds_resposta
       ,decode(pergunta_doc.DS_PERGUNTA
                                      ,'IDADE','Idade: '
                                      ,'UNID INT','Unidade de Internação em registro: '
                                      ,'DATA E HORA','Abertura do documento: '

                                     )PERGUNTAS
       ,(Case
         WHEN ds_resposta = 'checked'
         THEN 'SIM'
         ELSE ds_resposta
         END)AS status

FROM registro_resposta registro_resposta
INNER JOIN registro_documento registro_documento
  ON registro_documento.cd_registro_documento =  registro_resposta.cd_registro_documento
INNER JOIN atendime atendime
  ON atendime.cd_atendimento = registro_documento.cd_atendimento
INNER JOIN paciente paciente
  ON paciente.cd_paciente = atendime.cd_paciente
INNER JOIN pergunta_doc pergunta_doc
  ON pergunta_doc.cd_pergunta_doc = registro_resposta.cd_pergunta_doc
INNER JOIN atendime atendime
  ON atendime.cd_atendimento = registro_documento.cd_atendimento
INNER JOIN paciente paciente
  ON paciente.cd_paciente = atendime.cd_paciente
WHERE registro_documento.cd_documento =  '775'
--AND registro_documento.cd_atendimento = '4539005'
AND registro_resposta.CD_PERGUNTA_DOC IN ( --------------CABEÇALHO-----------------------
                                           '8551','43035','39385'
                        )

UNION ALL
----------------------------------------------------------------------------IDENTIFICAÇÃO
SELECT  registro_documento.cd_registro_documento
       ,registro_documento.cd_atendimento
       ,paciente.nm_paciente
       ,registro_documento.cd_documento
       ,registro_documento.nm_usuario
       ,to_char(registro_documento.dt_registro,'DD/MM/YYYY')DIA_PEDIDO
       ,to_char(registro_documento.dt_registro,'HH24:MI:SS')HORARIO 
       ,registro_documento.dt_registro
       ,registro_resposta.cd_pergunta_doc
       ,pergunta_doc.ds_pergunta
       ,registro_resposta.ds_resposta
       ,decode(pergunta_doc.DS_PERGUNTA
                                      -------------IDENTIFICAÇÃO SEPSE -------------
                                      ,'ABERTURAPROTOCOLO','Horário de abertura do protocolo: '
                                      ,'IMPROCEDENTE','Protocolo improcedente (finalizar): '
                                      ,'MANTIDO','Protocolo mantido (iniciar metas): '
                                      )PERGUNTAS
       ,(Case
         WHEN ds_resposta = 'checked'
         THEN 'SIM'
         ELSE ds_resposta
         END)AS status


FROM registro_resposta registro_resposta
INNER JOIN registro_documento registro_documento
  ON registro_documento.cd_registro_documento =  registro_resposta.cd_registro_documento
INNER JOIN atendime atendime
  ON atendime.cd_atendimento = registro_documento.cd_atendimento
INNER JOIN paciente paciente
  ON paciente.cd_paciente = atendime.cd_paciente
INNER JOIN pergunta_doc pergunta_doc
  ON pergunta_doc.cd_pergunta_doc = registro_resposta.cd_pergunta_doc
INNER JOIN atendime atendime
  ON atendime.cd_atendimento = registro_documento.cd_atendimento
INNER JOIN paciente paciente
  ON paciente.cd_paciente = atendime.cd_paciente
WHERE registro_documento.cd_documento =  '775'
--AND registro_documento.cd_atendimento = '4539005'
AND registro_resposta.CD_PERGUNTA_DOC IN (  -------------IDENTIFICAÇÃO SEPSE -------------
                                           '45696','26559','44391'
                                          )
AND registro_resposta.ds_resposta IS NOT null

UNION ALL

SELECT  registro_documento.cd_registro_documento
       ,registro_documento.cd_atendimento
       ,paciente.nm_paciente
       ,registro_documento.cd_documento
       ,registro_documento.nm_usuario
       ,to_char(registro_documento.dt_registro,'DD/MM/YYYY')DIA_PEDIDO
       ,to_char(registro_documento.dt_registro,'HH24:MI:SS')HORARIO 
       ,registro_documento.dt_registro
       ,registro_resposta.cd_pergunta_doc
       ,pergunta_doc.ds_pergunta
       ,registro_resposta.ds_resposta
       ,decode(pergunta_doc.DS_PERGUNTA
                                      -------------META 1 HORA----------------------
                                      ,'INF1','Infecção PNEUMONIA\EMPIEMA: '
                                      ,'INF3','Infecção de CORRENTE SANGUÍNEA ASSOCIADA AO CATETER: '
                                      ,'INF4','Infecção URINÁRIA: '
                                      ,'INF5','Infecção de PRÓTESE: '
                                      ,'INF6', 'Infecção ABDOMINANL AGUDA: '
                                      ,'INF7','Infecção ÓSSEA/ARTICULAR: '
                                      ,'INF8','Infecção MENINGITE: '
                                      ,'INF9','Infecção de FERIDA OPERATÓRIA: '
                                      ,'INF10','Infecção ENDOCARDITE: '
                                      ,'INF11','Infecção SEM FOCO DEFINIDO: '
                                      ,'INF12','Infecção PELE E PARTES MOLES: '
                                      ,'INF13','Infecçã OUTRAS INFECÇÕES: '
                                      ,'COMUNITARIO','Foco comunitário: '
                                      ,'HOSPITALAR','Foco hospitalar: '

                                      ,'ANT1','Antibiótico prescrito CEFTRIAXONA: '
                                      ,'ANT2','Antibiótico prescrito AMICACINA: '
                                      ,'ANT3','Antibiótico prescrito OXACILINA: '
                                      ,'ANT4','Antibiótico prescrito CIPROFLOXACINO: '
                                      ,'ANT5','Antibiótico prescrito GENTAMICINA: '
                                      ,'ANT6','Antibiótico prescrito PENICILINA CRISTALINA: '
                                      ,'ANT7','Antibiótico prescrito CEFEPIME: '
                                      ,'ANT8','Antibiótico prescrito MEROPENEN: '
                                      ,'ANT9','Antibiótico prescrito TAZOCIN: '
                                      ,'ANT10','Antibiótico prescrito CLINDAMICINA: '
                                      ,'ANT11','Antibiótico prescrito METRONIDAZOL: '
                                      ,'ANT12','Antibiótico prescrito VANCOMICINA: '
                                      ,'ANT13','Antibiótico prescrito CLARITROMICINA: '
                                      ,'ANT14','Antibiótico prescrito LINEZOLIDA: '
                                      ,'ANT15','Antibiótico prescrito POLIMEXINA B: '
                                      ,'ANT16','Antibiótico prescrito TIGECICLINA: '
                                      ,'ANT19','Antibiótico prescrito DAPTOMICINA: '

                                      ,'META_PC_NAO','Meta de primeira hora NÃO CUMPRIDA: '
                                      ,'META_PC_SIM','Meta de primeira hora CUMPRIDA: '

                                      )PERGUNTAS

       ,(Case
         WHEN ds_resposta = 'checked'
         THEN 'SIM'
         ELSE ds_resposta
         END)AS status
FROM registro_resposta registro_resposta
INNER JOIN registro_documento registro_documento
  ON registro_documento.cd_registro_documento =  registro_resposta.cd_registro_documento
INNER JOIN atendime atendime
  ON atendime.cd_atendimento = registro_documento.cd_atendimento
INNER JOIN paciente paciente
  ON paciente.cd_paciente = atendime.cd_paciente
INNER JOIN pergunta_doc pergunta_doc
  ON pergunta_doc.cd_pergunta_doc = registro_resposta.cd_pergunta_doc
INNER JOIN atendime atendime
  ON atendime.cd_atendimento = registro_documento.cd_atendimento
INNER JOIN paciente paciente
  ON paciente.cd_paciente = atendime.cd_paciente
WHERE registro_documento.cd_documento =  '775'
--AND registro_documento.cd_atendimento = '4539005'
AND registro_resposta.CD_PERGUNTA_DOC IN (
                                            -------------META 1 HORA----------------------
                                            '41774','41776','41777','41778','44381','44382','44383'
                                            ,'44384','44385','44386','44387','44389','45629','45630'

                                            ,'22248','22249','22250','22251','22252','22253','30163'
                                            ,'44409','44410','44411','44412','44413','44414','45639'
                                            ,'45554','45555','45556','45631','45632'

                        )
AND registro_resposta.ds_resposta IS NOT null

UNION ALL

SELECT  registro_documento.cd_registro_documento
       ,registro_documento.cd_atendimento
       ,paciente.nm_paciente
       ,registro_documento.cd_documento
       ,registro_documento.nm_usuario
       ,to_char(registro_documento.dt_registro,'DD/MM/YYYY')DIA_PEDIDO
       ,to_char(registro_documento.dt_registro,'HH24:MI:SS')HORARIO 
       ,registro_documento.dt_registro
       ,registro_resposta.cd_pergunta_doc
       ,pergunta_doc.ds_pergunta
       ,registro_resposta.ds_resposta
       ,decode(pergunta_doc.DS_PERGUNTA

                                       -------------META 6 HORAS----------------------
                                      ,'META_6H_NAO','Meta de seis hora NÃO CUMPRIDA: '
                                      ,'META_6H_SIM','Meta de seis hora CUMPRIDA: '

                                     )PERGUNTAS

       ,(Case
         WHEN ds_resposta = 'checked'
         THEN 'SIM'
         ELSE ds_resposta
         END)AS status


FROM registro_resposta registro_resposta
INNER JOIN registro_documento registro_documento
  ON registro_documento.cd_registro_documento =  registro_resposta.cd_registro_documento
INNER JOIN atendime atendime
  ON atendime.cd_atendimento = registro_documento.cd_atendimento
INNER JOIN paciente paciente
  ON paciente.cd_paciente = atendime.cd_paciente
INNER JOIN pergunta_doc pergunta_doc
  ON pergunta_doc.cd_pergunta_doc = registro_resposta.cd_pergunta_doc
INNER JOIN atendime atendime
  ON atendime.cd_atendimento = registro_documento.cd_atendimento
INNER JOIN paciente paciente
  ON paciente.cd_paciente = atendime.cd_paciente
WHERE registro_documento.cd_documento =  '775'
--AND registro_documento.cd_atendimento = '4539005'
AND registro_resposta.CD_PERGUNTA_DOC IN (  -------------META 6 HORAS----------------------
                                            '45633','45635','15788','20656'

                        )
AND registro_resposta.ds_resposta IS NOT null


UNION ALL

SELECT  registro_documento.cd_registro_documento
       ,registro_documento.cd_atendimento
       ,paciente.nm_paciente
       ,registro_documento.cd_documento
       ,registro_documento.nm_usuario
       ,to_char(registro_documento.dt_registro,'DD/MM/YYYY')DIA_PEDIDO
       ,to_char(registro_documento.dt_registro,'HH24:MI:SS')HORARIO 
       ,registro_documento.dt_registro
       ,registro_resposta.cd_pergunta_doc
       ,pergunta_doc.ds_pergunta
       ,registro_resposta.ds_resposta
       ,decode(pergunta_doc.DS_PERGUNTA
                                      --------------DESFECHO--------------------------
                                      ,'OBITO','Desfecho ÓBITO: '
                                      ,'SETOR','Desfecho TRANSFERÊNCIA PARA SETOR: '
                                      ,'ALTA','Desfecho ALTA: ')PERGUNTAS

       ,(Case
         WHEN ds_resposta = 'checked'
         THEN 'SIM'
         ELSE ds_resposta
         END)AS status


FROM registro_resposta registro_resposta
INNER JOIN registro_documento registro_documento
  ON registro_documento.cd_registro_documento =  registro_resposta.cd_registro_documento
INNER JOIN atendime atendime
  ON atendime.cd_atendimento = registro_documento.cd_atendimento
INNER JOIN paciente paciente
  ON paciente.cd_paciente = atendime.cd_paciente
INNER JOIN pergunta_doc pergunta_doc
  ON pergunta_doc.cd_pergunta_doc = registro_resposta.cd_pergunta_doc
INNER JOIN atendime atendime
  ON atendime.cd_atendimento = registro_documento.cd_atendimento
INNER JOIN paciente paciente
  ON paciente.cd_paciente = atendime.cd_paciente
WHERE registro_documento.cd_documento =  '775'
--AND registro_documento.cd_atendimento = '4539005'
AND registro_resposta.CD_PERGUNTA_DOC IN ( ------------DESFECHO---------------------------
                                            '20656','15788','42285'
                        )
AND registro_resposta.ds_resposta IS NOT null

ORDER BY paciente.nm_paciente 
        ,atendime.cd_atendimento
        ,registro_documento.dt_registro
/

GRANT SELECT ON VDIC_REPORT_SEPSE_AD TO biconexao;
GRANT SELECT ON VDIC_REPORT_SEPSE_AD TO dbacp WITH GRANT OPTION;
GRANT SELECT ON VDIC_REPORT_SEPSE_AD TO dbaportal WITH GRANT OPTION;
GRANT DELETE,INSERT,SELECT,UPDATE ON VDIC_REPORT_SEPSE_AD TO dbaps;
GRANT DELETE,INSERT,SELECT,UPDATE ON VDIC_REPORT_SEPSE_AD TO dbasgu;
GRANT DELETE,INSERT,SELECT,UPDATE ON VDIC_REPORT_SEPSE_AD TO mv2000;
GRANT DELETE,INSERT,SELECT,UPDATE ON VDIC_REPORT_SEPSE_AD TO mvintegra;

