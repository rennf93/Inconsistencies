set serveroutput on size 1000000;
--set serveroutput on size unlimited;

define ORA_USER_OWNER = '&1'
define ORA_USER_EXEC = '&2'
define ORA_USER_READONLY = '&3'
define ORA_ROLE_READONLY = '&4'
define ORA_TABLESPACE_TABLE = '&5'
define ORA_TABLESPACE_INDEX = '&6'
define ORA_PATH_PROFILE_LOG = '&7'

prompt "ejecutando 01_mu_inconsistencias.sql"
@01_mu_inconsistencias.sql

prompt "ejecutando 02_populate_mu_incons.sql"
@02_populate_mu_incons.sql

prompt "ejecutando 03_mu_results.sql"
@03_mu_results.sql

prompt "ejecutando 04_mu_data.sql"
@04_mu_data.sql

prompt "ejecutando 05_mu_incons_a.sql"
@05_mu_incons_a.sql

prompt "ejecutando 06_mu_incons_b.sql"
@06_mu_incons_b.sql

exit
