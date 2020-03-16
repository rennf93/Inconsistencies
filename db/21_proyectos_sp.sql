create or replace PROCEDURE PROY_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='PROYECTOS' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

    if reg.REPORT_ID = 'GIS 057' and reg.REPORT_ENABLED = 1 then

  BEGIN
            select SYSDATE into exec_begin from dual;
        END;

  BEGIN
    SELECT COUNT(*) INTO RESULT FROM(
      select count(*) from sprgprojectobjects x0 where not exists
      (select 1 from sprgprojects x1 where x0.projectid=x1.projectid));
  END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END PROY_INCONS;
/