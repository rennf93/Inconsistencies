create or replace PROCEDURE VEREDAS_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='VEREDAS' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

    if reg.REPORT_ID = 'GIS 055' and reg.REPORT_ENABLED = 1 then

  BEGIN
            select SYSDATE into exec_begin from dual;
        END;

  BEGIN
    SELECT COUNT(*) INTO RESULT FROM(
      select b.blockfacadeid from smblocks a, smblockfacades b where a.blockflags = 0
      and b.blockid = a.blockid and b.blockverini = b.blockverend);
  END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'GIS 105' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMBLOCKFACADES WHERE EXISTS (SELECT 1 from AMAREAS WHERE SMBLOCKFACADES.BLOCKFACADEID=AMAREAS.AREAID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 106' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMBLOCKFACADES  WHERE BLOCKVERINI<0 OR BLOCKVEREND <0;
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 107' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT blockId from smblockfacades
					MINUS SELECT blockId from smBlocks);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END VEREDAS_INCONS;
/