set serveroutput on size 1000000;
--set serveroutput on size unlimited;

define ORA_USER_OWNER = '&1'
define ORA_USER_EXEC = '&2'
define ORA_USER_READONLY = '&3'
define ORA_ROLE_READONLY = '&4'
define ORA_TABLESPACE_TABLE = '&5'
define ORA_TABLESPACE_INDEX = '&6'
define ORA_PATH_PROFILE_LOG = '&7'

prompt "ejecutando 01_tb_reports.sql"
@01_tb_reports.sql
 
prompt "ejecutando 02_tb_inconsistencias.sql"
@02_tb_inconsistencias.sql

prompt "ejecutando 03_populate_reports_custom.sql"
@03_populate_reports_custom.sql

prompt "ejecutando 04_populate_reports_gis.sql"
@04_populate_reports_gis.sql

prompt "ejecutando 05_sp_fill_inconsistencias.sql"
@05_sp_fill_inconsistencias.sql

prompt "ejecutando 06_sp_inconsistencias_custom.sql"
@06_sp_inconsistencias_custom.sql

prompt "ejecutando 07_sp_inconsistencias_gis.sql"
@07_sp_inconsistencias_gis.sql

prompt "ejecutando 08_blocks_sp.sql"
@08_blocks_sp.sql

prompt "ejecutando 09_calles_sp.sql"
@09_calles_sp.sql

prompt "ejecutando 10_check_sp.sql"
@10_check_sp.sql

prompt "ejecutando 11_clients_sp.sql"
@11_clients_sp.sql

prompt "ejecutando 12_conectores_sp.sql"
@12_conectores_sp.sql

prompt "ejecutando 13_fo_sp.sql"
@13_fo_sp.sql

prompt "ejecutando 14_links_sp.sql"
@14_links_sp.sql

prompt "ejecutando 15_logs_sp.sql"
@15_logs_sp.sql

prompt "ejecutando 16_milenios_sp.sql"
@16_milenios_sp.sql

prompt "ejecutando 17_objetos_sp.sql"
@17_objetos_sp.sql

prompt "ejecutando 18_operaciones_sp.sql"
@18_operaciones_sp.sql

prompt "ejecutando 19_operobj_sp.sql"
@19_operobj_sp.sql

prompt "ejecutando 07_sp_inconsistencias_gis.sql"
@20_portantes_sp.sql

prompt "ejecutando 21_proyectos_sp.sql"
@21_proyectos_sp.sql

prompt "ejecutando 22_regletas_sp.sql"
@22_regletas_sp.sql

prompt "ejecutando 23_topologia_sp.sql"
@23_topologia_sp.sql

prompt "ejecutando 24_validacion_sp.sql"
@24_validacion_sp.sql

prompt "ejecutando 25_veredas_sp.sql"
@25_veredas_sp.sql

prompt "ejecutando 26_verificacion_sp.sql"
@26_verificacion_sp.sql

exit
