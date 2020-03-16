create or replace PROCEDURE OPSOBJ_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='OP_OB' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

    if reg.REPORT_ID = 'GIS 051' and reg.REPORT_ENABLED = 1 then

  BEGIN
            select SYSDATE into exec_begin from dual;
        END;

  BEGIN
    SELECT COUNT(*) INTO RESULT FROM(
      SELECT op.operationid, ob.objectid, ob.sprid, ob.realstate, ob.realdate, op.status, op.operationdate
      FROM sprobjects ob, sprgoperations op WHERE ob.objectid = op.objectid AND op.operationdate = (SELECT MAX(operationdate)
      FROM sprgoperations WHERE objectid = ob.objectid AND logidto = 0 AND intprocid = 0
      AND statustype = op.statustype) AND op.operationid = (SELECT MAX(operationid) FROM sprgoperations WHERE objectid = ob.objectid
      AND logidto = 0 AND intprocid = 0 AND statustype = op.statustype)
      AND op.logidto = 0 AND ob.logidto = 0 AND op.intprocid = 0
      AND op.statustype = 1 AND (op.status <> ob.realstate OR op.operationdate <> ob.realdate OR ob.realdate IS NULL));
  END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;


if reg.REPORT_ID = 'GIS 052' and reg.REPORT_ENABLED = 1 then

  BEGIN
            select SYSDATE into exec_begin from dual;
        END;

  BEGIN
    SELECT COUNT(*) INTO RESULT FROM(
      SELECT op.operationid, ob.objectid, ob.sprid, ob.normalstate, ob.normaldate, op.status, op.operationdate
      FROM sprobjects ob, sprgoperations op WHERE ob.objectid = op.objectid AND op.operationdate = (SELECT MAX(operationdate)
      FROM sprgoperations WHERE objectid = ob.objectid AND logidto = 0 AND intprocid = 0
      AND statustype = op.statustype) AND op.operationid = (SELECT MAX(operationid) FROM sprgoperations WHERE objectid = ob.objectid
      AND logidto = 0 AND intprocid = 0 AND statustype = op.statustype)
      AND op.logidto = 0 AND ob.logidto = 0 AND op.intprocid = 0
      AND op.statustype = 0 AND (op.status <> ob.normalstate OR op.operationdate <> ob.normaldate OR ob.normaldate IS NULL));
  END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END OPSOBJ_INCONS;
/