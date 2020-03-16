create or replace PROCEDURE CONECT_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='CONECTORES' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

    if reg.REPORT_ID = 'GIS 038' and reg.REPORT_ENABLED = 1 then

  BEGIN
            select SYSDATE into exec_begin from dual;
        END;

  BEGIN
    SELECT COUNT(*) INTO RESULT FROM(
      SELECT objectid FROM sprobjects WHERE objecttype = 11
      MINUS SELECT objectid FROM sprobjectvertixs);
  END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;


if reg.REPORT_ID = 'GIS 039' and reg.REPORT_ENABLED = 1 then

  BEGIN
            select SYSDATE into exec_begin from dual;
        END;

  BEGIN
    SELECT COUNT(*) INTO RESULT FROM(
      SELECT * FROM sprobjectvertixs t1 WHERE EXISTS (SELECT 1 FROM sprobjectvertixs
      WHERE objectid = t1.objectid AND vertixorder = t1.vertixorder + 1 AND x = t1.x and y = t1.y));
  END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;


if reg.REPORT_ID = 'GIS 040' and reg.REPORT_ENABLED = 1 then

  BEGIN
            select SYSDATE into exec_begin from dual;
        END;

  BEGIN
    SELECT COUNT(*) INTO RESULT FROM(
      SELECT objectid, COUNT (*) FROM sprobjectvertixs GROUP BY objectid HAVING COUNT (*) = 1);
  END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END CONECT_INCONS;
/