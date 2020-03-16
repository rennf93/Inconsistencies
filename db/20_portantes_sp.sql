create or replace PROCEDURE PORTANTES_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='PORTANTES' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

    if reg.REPORT_ID = 'P SUPERIOR 1' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            SELECT /*+ INDEX (o SPROBJ_SPRID_IDTO) */ /*+ INDEX (ls SPRLINKS_OBJID_LNKID) */  /*+ INDEX (lp SPRLINKS_OBJID_LNKID) */ COUNT(*) into result
            FROM SPROBJECTS O, SPRLINKS LS, SPRLINKS LP
            WHERE O.SPRID IN (76, 254) AND O.LOGIDTO = 0
            AND LS.OBJECTID = O.OBJECTID  AND LS.LINKID = 77 AND LS.LOGIDTO = 0
            AND LP.OBJECTID = O.OBJECTID AND LP.LINKID = 237 AND LP.LOGIDTO = 0
            AND EXISTS (
               SELECT /*+ INDEX (oc SPROBJ_SPRID_IDTO) */ /*+ INDEX (lc SPRLINKS_OBJID_LNKID) */  1
                FROM SPROBJECTS OC, SPRLINKS LC
                WHERE OC.SPRID = 100 AND OC.LOGIDTO = 0
                AND LC.OBJECTID = OC.OBJECTID AND LC.LINKID IN (15, 164) AND LC.LINKVALUE = LS.LINKVALUE AND LC.LOGIDTO = 0 )
            AND NOT EXISTS (
               SELECT /*+ INDEX (T SPRTOPO_IDFROM) */ 1
                   FROM SPRTOPOLOGY T
                   WHERE T.OBJECTIDFROM IN (
                       SELECT /*+ INDEX (LTP SPRLINKS_LNK) */ LTP.OBJECTID FROM SPRLINKS LTP WHERE LTP.LINKID = 237 AND LTP.LINKVALUE = LP.LINKVALUE AND LTP.LOGIDTO = 0)
                   AND T.OBJECTIDTO IN (
                       SELECT /*+ INDEX (LTC SPRLINKS_LNK) */ LTC.OBJECTID FROM SPRLINKS LTC WHERE LTC.LINKID IN (15, 164) AND LTC.LINKVALUE = LS.LINKVALUE AND LTC.LOGIDTO = 0 )
                   AND T.LOGIDTO = 0 );
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'P SUPERIOR 2' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            SELECT count(*) into result From (
              SELECT /*+ INDEX (O SPROBJ_SPRID_IDTO) INDEX (LS SPRLINKS_OBJID_LNKID) INDEX (LP SPRLINKS_OBJID_LNKID) */ lp.linkvalue as PortID, ls.linkvalue as PortSup
                FROM sprobjects o, sprlinks ls, sprlinks lp
               WHERE o.sprid IN (76, 254) AND o.logidto = 0
                 AND ls.objectid = o.objectid AND ls.linkid = 77 AND NVL(LENGTH(ls.linkvalue), 0) > 0 AND ls.logidto = 0
                 AND lp.objectid = o.objectid AND lp.linkid = 237 AND lp.logidto = 0
                 GROUP BY lp.linkvalue, ls.linkvalue )
            WHERE NOT EXISTS (
                       SELECT /*+ INDEX (L2P SPRLINKS_LNK) INDEX (OP SPROBJ_OBJ_SPRID) */ 1
                         FROM sprlinks l2p, sprobjects op
                         WHERE l2p.linkid = 237 AND l2p.linkvalue = PortSup AND L2P.LOGIDTO = 0
                         AND l2p.objectid = op.objectid AND op.sprid IN (76, 254) AND OP.LOGIDTO = 0 )
             AND NOT EXISTS (
                       SELECT  /*+ INDEX (L3P SPRLINKS_LNK) INDEX (OP SPROBJ_OBJ_SPRID) */ 1 FROM sprlinks l3p, sprobjects op
                        WHERE l3p.linkid IN (15, 164) AND l3p.linkvalue = PortSup AND L3P.LOGIDTO = 0
                        AND   l3p.objectid = op.objectid AND op.sprid = 100 AND OP.LOGIDTO = 0 );
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'P SUPERIOR 3' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            SELECT count(*) into result FROM (
               SELECT portanteid, MIN (portSuperior) AS PSup_A, MAX (portSuperior) AS PSup_B
                 FROM ( SELECT /*INDEX (O SPROBJ_SPRID_IDTO) +INDEX (LS SPRLINKS_OBJID_LNKID) INDEX (LP SPRLINKS_OBJID_LNKID) */
                 lp.linkvalue AS portanteid, ls.linkvalue AS portSuperior
                          FROM sprobjects o, sprlinks ls, sprlinks lp
                         WHERE o.sprid IN (76, 254)
                           AND o.logidto = 0
                           AND ls.objectid = o.objectid
                           AND ls.linkid = 77 AND ls.logidto = 0
                           AND lp.linkid = 237
                           AND lp.logidto = 0
                           AND lp.objectid = o.objectid
                        GROUP BY lp.linkvalue, ls.LINKVALUE )
               GROUP BY portanteid )
            WHERE PSup_A <> PSup_B;
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'P SUPERIOR 4' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            SELECT COUNT(*) INTO RESULT FROM(
                SELECT lp.linkvalue as portanteid, ls.LINKVALUE as portantesup, MIN (o.objectid) AS objectidEje
                  FROM sprobjects o, sprlinks ls, sprlinks lp
                 WHERE o.sprid IN (76, 254)
                   AND ls.objectid = o.objectid
                   AND lp.objectid = o.objectid
                   AND ls.linkid = 77
                   AND lp.linkid = 237
                   AND ls.linkvalue = lp.linkvalue
                   AND o.logidto = 0
                   AND ls.logidto = 0
                   AND lp.logidto = 0
                GROUP BY lp.linkvalue, ls.LINKVALUE
                ORDER BY lp.linkvalue, ls.LINKVALUE);
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'P SUPERIOR 5' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            SELECT /*+INDEX (O SPROBJ_SPRID_IDTO) INDEX (LS SPRLINKS_OBJID_LNKID) INDEX (LP SPRLINKS_OBJID_LNKID) */ count(*) into result
              FROM sprobjects o, sprlinks ls, sprlinks lp
             WHERE o.sprid IN (76, 254) AND o.logidto = 0
               AND ls.objectid = o.objectid AND ls.linkid = 77 AND ls.logidto = 0
               AND lp.objectid = o.objectid AND lp.linkid = 237 AND lp.logidto = 0
               AND EXISTS (
                           SELECT /*+INDEX (OPS SPROBJ_SPRID_IDTO)INDEX (LPS SPRLINKS_OBJID_LNKID) */ 1 FROM sprobjects ops, sprlinks lps
                             WHERE ops.sprid IN (76, 254) AND ops.logidto = 0
                               AND ops.objectid <> o.objectid
                               AND lps.objectid = ops.objectid  AND lps.linkid = 237 AND lps.linkvalue = ls.linkvalue AND lps.logidto = 0
                               )
               AND NOT EXISTS (
                               SELECT /*+ INDEX (T1 SPRTOPO_IDFROM) + INDEX (T2 SPRTOPO_IDFROM) */ 1 FROM SPRTOPOLOGY t1, SPRTOPOLOGY t2
                                WHERE t1.OBJECTIDFROM IN ( SELECT /*+INDEX (LTS SPRLINKS_LNK)*/ lts.objectid FROM SPRLINKS lts
                                                                   WHERE lts.linkid = 237 AND lts.linkvalue = ls.linkvalue AND lts.logidto = 0)
                                  AND t1.OBJECTIDTO = t2.OBJECTIDFROM
                                  AND t2.OBJECTIDTO IN ( SELECT /*+INDEX (LTP SPRLINKS_LNK)*/ ltp.objectid FROM SPRLINKS ltp
                                                          WHERE ltp.linkid = 237 AND ltp.linkvalue = lp.linkvalue AND ltp.logidto = 0)
                                  AND t1.LOGIDTO = 0
                                  AND t2.LOGIDTO = 0 );
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'P SUPERIOR 6' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            SELECT /*+INDEX (O SPROBJ_SPRID_IDTO) +INDEX (LP SPRLINKS_LNK_IDTO) */ count(*) into result
              FROM sprobjects o, sprlinks lp
             WHERE o.sprid IN (76, 254)
               AND o.logidto = 0
               AND o.objectid = lp.objectid
               AND lp.linkid = 237
               AND lp.logidto = 0
               AND EXISTS ( SELECT /*+ INDEX (L2P SPRLINKS_LNK) INDEX (O2 SPROBJ_OBJ_SPRID)  INDEX (L2S SPRLINKS_OBJID_LNKID) */ 1
                               FROM sprobjects o2, sprlinks l2p, sprlinks l2s
                                WHERE l2p.linkid = 237 AND l2p.linkvalue = lp.linkvalue AND l2p.logidto = 0
                                AND o2.objectid = l2p.objectid AND o2.sprid IN (76, 254) AND o2.logidto = 0
                                AND o2.objectid = l2s.objectid AND l2s.linkid = 77 AND l2s.logidto = 0)
                    AND NOT EXISTS ( SELECT /*+ INDEX (L3S SPRLINKS_OBJID_LNKID)*/ 1
                                        FROM  sprlinks l3s
                                        WHERE l3s.objectid = o.objectid
                                        AND l3s.linkid = 77
                                        AND NVL(LENGTH ( l3s.linkvalue), 0) > 0
                                        AND l3s.logidto = 0 );
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'P SUPERIOR 7' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            SELECT /*+INDEX (O SPROBJ_OBJ_SPRID) INDEX (LP SPRLINKS_OBJID_LNKID) */ count(*) into result
            FROM sprobjects o, sprlinks lp WHERE o.sprid IN (76, 254)
            AND o.objectid = lp.objectid AND o.logidto = 0
            AND lp.linkid = 237 AND lp.logidto = 0
            AND EXISTS (SELECT /*+INDEX (LP SPRLINKS_LNK) */ 1 FROM sprlinks ls
                        WHERE ls.linkid = 77
                        AND ls.logidto = 0
                        AND o.objectid = ls.objectid
                        AND NVL(LENGTH ( ls.linkvalue), 0) = 0 );
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'P SUPERIOR 8' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            SELECT count(*) into result FROM (
               SELECT lp.linkvalue AS portanteid, MIN (o.objectid) AS objectidEj
                 FROM sprobjects o, sprlinks lp
                WHERE o.sprid IN (76, 254)
                  AND o.objectid = lp.objectid
                  AND lp.linkid = 237
                  AND lp.logidto = 0
                  AND o.logidto = 0
               GROUP BY lp.linkvalue ) sq
            WHERE NOT EXISTS ( SELECT  /*+ INDEX(l2p.SPRLINKS_LNK_IDTO ) */ 1 FROM   sprlinks l2p, sprlinks l2s
                                    WHERE l2s.objectid = l2p.objectid
                                      AND l2s.linkid = 77
                                      AND l2p.linkid = 237
                                      AND l2p.linkvalue = sq.portanteid
                                      AND l2p.logidto = 0
                                      AND l2s.logidto = 0  );
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'PORTANTE 1' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN
                select count(*) into result from sprlinks l
                where l.linkid = 424
                  and l.logidto = 0
                  and length(trim(linkvalue)) > 4
                  and exists ( select 1 from sprobjects o
                                where o.SPRID in (76, 254)
                                  and o.logidto = 0
                                  and o.objectid = l.objectid
                                  and o.projectid = 0 );
            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'PORTANTE 2' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN
                SELECT COUNT(*) INTO RESULT FROM(
                    SELECT portid, COUNT (1) AS CANTIDAD_DE_EXTREMOS FROM (
                       SELECT portid, idPuntual, MAX(INDXPORT) AS CANT_CONEXIONES
                         FROM ( SELECT lp.linkvalue AS portid,
                                       t.objectidto AS idPuntual,
                                       ROW_NUMBER () OVER (PARTITION BY lp.linkvalue, t.objectidto ORDER BY lp.linkvalue, o.objectid) AS indxPort
                                  FROM sprobjects o, sprlinks lp, sprtopology t
                                 WHERE o.sprid IN (76, 254)
                                   AND o.objectid = lp.objectid
                                   AND o.objectid = t.objectidfrom
                                   AND lp.linkid = 237
                                   AND lp.logidto = 0
                                   AND t.logidto = 0
                                   AND o.logidto = 0 )
                       GROUP BY portid, idPuntual
                       HAVING MAX (INDXPORT) = 1
                       )
                    GROUP BY portid
                    HAVING COUNT (1) > 2);
            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'PORTANTE 3' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN
                SELECT count(*) into result FROM sprobjects o
                 WHERE o.sprid IN (76, 254)
                   AND NOT EXISTS ( SELECT 1 FROM sprlinks l
                                     WHERE l.objectid = o.objectid
                                       AND l.linkid = 237
                                       AND TO_NUMBER(l.linkvalue) > 0
                                       AND l.logidto = 0 )
                   AND o.logidto = 0;
            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'PORTANTE 4' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN
                SELECT COUNT(*) INTO RESULT FROM(
                    SELECT portid, idPuntual, MAX(INDXPORT) AS CANT_CONEXIONES
                     FROM ( SELECT lp.linkvalue AS portid,
                                   t.objectidto AS idPuntual,
                                   ROW_NUMBER () OVER (PARTITION BY lp.linkvalue, t.objectidto ORDER BY lp.linkvalue, o.objectid) AS indxPort
                              FROM sprobjects o, sprlinks lp, sprtopology t
                             WHERE o.sprid IN (76, 254)
                               AND o.objectid = lp.objectid
                               AND o.objectid = t.objectidfrom
                               AND lp.linkid = 237
                               AND lp.logidto = 0
                               AND t.logidto = 0
                               AND o.logidto = 0 )
                    GROUP BY portid, idPuntual
                    HAVING MAX (INDXPORT) > 2);
            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'N PORTANTES 1' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN
                SELECT count(
                    (SELECT 1 FROM sprobjects o2, sprlinks l2p, sprlinks l2s
                                        WHERE o2.sprid IN (76, 254)
                                          AND o2.objectid = l2s.objectid
                                          AND o2.objectid = l2p.objectid
                                          AND l2s.linkid = 424
                                          AND l2p.linkid = 237
                                          AND l2p.linkvalue = lp.linkvalue
                                          AND l2p.logidto = 0
                                          AND l2s.logidto = 0
                                          AND o2.logidto = 0
                                          and rownum < 2)) into result
                  FROM sprobjects o, sprlinks lp
                 WHERE o.sprid IN (76, 254)
                   AND o.objectid = lp.objectid
                   AND lp.linkid = 237
                   AND lp.logidto = 0
                   AND o.logidto = 0
                   AND NOT EXISTS ( SELECT 1 FROM  sprlinks l3s
                                     WHERE l3s.objectid = o.objectid
                                       AND l3s.linkid = 424
                                       AND NVL(LENGTH ( l3s.linkvalue), 0) > 0
                                       AND l3s.logidto = 0 );
            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'N PORTANTES 2' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN
                SELECT COUNT(*) INTO RESULT FROM(
                    SELECT portanteid, MIN (nroport) AS nroport_A, MAX (nroport) AS nroport_B
                      FROM ( SELECT lp.linkvalue AS portanteid, ls.linkvalue AS nroport
                               FROM sprobjects o, sprlinks ls, sprlinks lp
                              WHERE o.sprid IN (76, 254)
                                AND ls.objectid = o.objectid
                                AND lp.objectid = o.objectid
                                AND ls.linkid = 424
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

        if reg.REPORT_ID = 'N PORTANTES 3' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN
                SELECT count(*) into result
                  FROM sprlinks lnp, sprlinks lp, sprobjects o
                 WHERE lnp.objectid = o.objectid
                   AND lp.objectid = o.objectid
                   AND o.sprid IN (76, 254)
                   AND lnp.linkid = 424
                   AND lp.linkid = 237
                   AND lnp.logidto = 0
                   AND lp.logidto = 0
                   AND SUBSTR (TRIM (lnp.linkvalue), 1, 1) NOT IN
                                   (SELECT DISTINCT SUBSTR (TRIM (MILENIO_PORTANTE), 1, 1) FROM PM_MILENIO_PORTANTE)
                   AND SUBSTR (TRIM (lnp.linkvalue), 1, 1) NOT IN
                                   (SELECT DISTINCT SUBSTR (TRIM (MILENIO_PORTANTE_PADRE), 1, 1) FROM PM_MILENIO_PORTANTE);
            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END PORTANTES_INCONS;
/