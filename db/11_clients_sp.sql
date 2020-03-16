create or replace PROCEDURE CLIENTS_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='CLIENTS' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP
    if reg.REPORT_ID = 'GIS 063' and reg.REPORT_ENABLED = 1 then

  BEGIN
            select SYSDATE into exec_begin from dual;
        END;

  BEGIN
    SELECT COUNT(*) INTO RESULT FROM SPRCLIENTS x0
      WHERE NOT EXISTS (SELECT 1 FROM SMSTREETS x1
      WHERE x0.STREETID = x1.STREETID);
  END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'GIS 114' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SPRCLIENTS C
					WHERE EXISTS (SELECT 1 FROM SMSTREETS S1 WHERE S1.streetId = C.streetId)
					AND NOT EXISTS (SELECT 1 FROM SMSTREETS S2 WHERE S2.streetId = C.streetId AND S2.regionId = C.levelOneAreaId);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END CLIENTS_INCONS;
/