create or replace PROCEDURE LOGS_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='LOGS' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

    if reg.REPORT_ID = 'GIS 013' and reg.REPORT_ENABLED = 1 then

  BEGIN
            select SYSDATE into exec_begin from dual;
        END;

  BEGIN
    SELECT COUNT(*) INTO RESULT
      FROM SPRLOG
      WHERE EVENTSTATUS = 1 AND LOGDATE < SYSDATE - 7;
  END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'GIS 020' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT userid FROM sprlog
					MINUS
					SELECT userid FROM users);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END LOGS_INCONS;
/