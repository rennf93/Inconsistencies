create or replace PROCEDURE MILENIOS_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='MILENIOS' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

    if reg.REPORT_ID = 'MILENIOS 1' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            SELECT count((SELECT 1 FROM sprobjects o2, sprlinks l2p, sprlinks l2s
                          WHERE o2.sprid IN (76, 254)
                            AND o2.objectid = l2s.objectid
                            AND o2.objectid = l2p.objectid
                            AND l2s.linkid = 436
                            AND l2p.linkid = 237
                            AND l2p.linkvalue = lp.linkvalue
                            AND l2p.logidto = 0
                            AND l2s.logidto = 0
                            AND o2.logidto = 0
                            AND rownum < 2)) into result
              FROM sprobjects o, sprlinks lp
             WHERE o.sprid IN (76, 254)
               AND o.objectid = lp.objectid
               AND lp.linkid = 237
               AND lp.logidto = 0
               AND o.logidto = 0
               AND NOT EXISTS ( SELECT 1 FROM  sprlinks l3s
                                 WHERE l3s.objectid = o.objectid
                                   AND l3s.linkid = 436
                                   AND NVL(LENGTH ( l3s.linkvalue), 0) > 0
                                   AND l3s.logidto = 0 );
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'MILENIOS 2' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            SELECT COUNT(*) INTO RESULT FROM(
                SELECT portanteid, MIN (milenio) AS milenio_A, MAX (milenio) AS milenio_B
                  FROM ( SELECT lp.linkvalue AS portanteid, ls.linkvalue AS milenio
                           FROM sprobjects o, sprlinks ls, sprlinks lp
                          WHERE o.sprid IN (76, 254)
                            AND ls.objectid = o.objectid
                            AND lp.objectid = o.objectid
                            AND ls.linkid = 436
                            AND lp.linkid = 237
                            AND ls.logidto = 0
                            AND lp.logidto = 0
                            AND o.logidto = 0
                         GROUP BY lp.linkvalue, ls.LINKVALUE )
                GROUP BY portanteid
                HAVING COUNT (1) > 1);
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'MILENIOS 3' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            SELECT count(*) into result FROM sprlinks lm, sprlinks lp, sprobjects o
             WHERE lm.objectid = o.objectid
                 AND lp.objectid = o.objectid
                 AND o.sprid IN (76, 254)
                 AND lm.linkid = 436
                 AND lp.linkid = 237
                 AND lm.logidto = 0
                 AND lp.logidto = 0
                 AND TRIM (lm.linkvalue) NOT IN ( select distinct MILENIO_PORTANTE  from PM_MILENIO_PORTANTE )
                AND TRIM (lm.linkvalue) NOT IN ( select distinct MILENIO_PORTANTE_PADRE from PM_MILENIO_PORTANTE );
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'MILENIOS 4' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            WITH portantes
              AS (SELECT DISTINCT LN.linkvalue AS portanteid,
                                  lp.linkvalue AS nroportante,
                                  SUBSTR (lp.linkvalue, 1, 1) || '000' AS milenio,
                                  ls.linkvalue AS portantesup
                    FROM sprobjects o, sprlinks ls, sprlinks lp, sprlinks LN
                   WHERE o.sprid IN (76, 254)
                     AND ls.objectid = o.objectid
                     AND lp.objectid = o.objectid
                     AND LN.objectid = o.objectid
                     AND REGEXP_LIKE (TRIM (ls.linkvalue), '^[[:digit:]]+$')
                     AND ls.linkid = 77
                     AND lp.linkid = 424
                     AND LN.linkid = 237
                     AND LN.logidto = 0
                     AND ls.logidto = 0
                     AND lp.logidto = 0
                     AND o.logidto = 0
                )
            SELECT count(*) into result
              FROM portantes p1, portantes p2
             WHERE p1.portantesup = p2.portanteid
                   AND NOT EXISTS ( SELECT 1  FROM PM_MILENIO_PORTANTE
                                     WHERE p1.milenio = MILENIO_PORTANTE
                                       AND p2.milenio = MILENIO_PORTANTE_PADRE );
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'MILENIOS 5' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            SELECT count(*) into result
              FROM sprobjects o, sprlinks ln, sprlinks lp, sprlinks lm
             WHERE o.sprid IN (76, 254)
               AND lm.objectid = o.objectid
               AND ln.objectid = o.objectid
               AND lp.objectid = o.objectid
               AND REGEXP_LIKE (TRIM (ln.linkvalue), '^[[:digit:]]+$')
               AND lm.linkid = 436
               AND ln.linkid = 424
               AND lp.linkid = 237
               AND lm.logidto = 0
               AND ln.logidto = 0
               AND lp.logidto = 0
               AND o.logidto = 0
               AND TRIM(lm.linkvalue) <> TRIM(SUBSTR (ln.linkvalue, 1, 1) || '000');
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END MILENIOS_INCONS;
/