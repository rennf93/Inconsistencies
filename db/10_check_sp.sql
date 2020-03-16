create or replace PROCEDURE CHECK_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='CHECK' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

    if reg.REPORT_ID = 'GIS 041' and reg.REPORT_ENABLED = 1 then

          BEGIN
              select SYSDATE into exec_begin from dual;
          END;

    BEGIN
      SELECT COUNT(*) INTO RESULT FROM(
        SELECT /*+ FIRST_ROWS(30) */ topologyid,topologytype,objectidfrom,objectidto,nodeindexfrom,nodeindexto,t.datefrom TOPO_DATEFROM,x1.datefrom OBJECTO_1_DATEFROM,x2.datefrom OBJECTO_2_DATEFROM,t.dateto TOPO_DATETO,x1.dateto OBJECTO_1_DATETO,x2.dateto OBJECTO_2_DATETO,t.logidfrom TOPO_LOGIDFROM,x1.logidfrom OBJECTO_1_LOGIDFROM,x2.logidfrom OBJETO_2_LOGIDFROM,t.logidto TOPO_LOGIDTO,x1.logidto OBJECTO_1_LOGIDTO,x2.logidto OBJECTO_2_LOGIDTO
        FROM sprTopology t, sprObjects x1, sprObjects x2
        WHERE t.objectIdFrom = x1.objectId
        AND t.objectIdTo = x2.objectId
        AND t.topologyType = 0
        AND (x1.dateFrom > t.dateFrom OR x1.dateTo < t.dateTo OR x2.dateFrom > t.dateFrom OR x2.dateTo < t.dateTo));
    END;

          BEGIN
              select SYSDATE into exec_end from dual;
          END;
      end if;


  if reg.REPORT_ID = 'GIS 042' and reg.REPORT_ENABLED = 1 then

          BEGIN
              select SYSDATE into exec_begin from dual;
          END;

    BEGIN
      SELECT COUNT(*) INTO RESULT FROM(
        SELECT x0.*, 'ASIMETRICA' caso
        FROM sprTopology x0
        WHERE topologyType = 0
        AND NOT EXISTS (SELECT /*+ PUSH_SUBQ */ x1.topologyId
        FROM sprTopology x1
        WHERE x1.objectIdFrom = x0.objectIdTo
        AND x1.objectIdTo = x0.objectIdFrom
        AND x1.topologyType = X0.topologyType
        AND x1.dateFrom = x0.dateFrom
        AND x1.dateTo = x0.dateTo)
        UNION
        SELECT DISTINCT t0.*, 'DUPLICADA' caso
        FROM sprtopology t0, sprtopology t1
        WHERE (t0.topologyid < t1.topologyid OR t0.topologyid > t1.topologyid)
        AND t0.objectidfrom = t1.objectidfrom
        AND t0.objectidto = t1.objectidto
        AND t0.topologytype = 0
        AND t1.topologytype = 0
        AND ( (t0.DATEFROM >= t1.datefrom AND t0.datefrom < t1.dateto)
        OR (t0.DATEto > t1.datefrom AND t0.dateto <= t1.dateto)));
    END;

          BEGIN
              select SYSDATE into exec_end from dual;
          END;
      end if;

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END CHECK_INCONS;
/