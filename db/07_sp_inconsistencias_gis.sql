create or replace PROCEDURE SP_INCONS_GIS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where custom_index='GIS' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

        if reg.REPORT_ID = 'GIS 001' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT
					FROM SPROBJECTS
					WHERE NOT EXISTS (SELECT 1 FROM SPRLOG WHERE LOGIDFROM=LOGID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 002' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT
					FROM SPROBJECTS
					WHERE NOT EXISTS (SELECT 1 FROM SPRLOG WHERE LOGIDTO=LOGID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 003' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT
					FROM SMBLOCKS
					WHERE NOT EXISTS (SELECT 1 FROM SPRLOG WHERE LOGIDFROM=LOGID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 004' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT
					FROM SMBLOCKS
					WHERE NOT EXISTS (SELECT 1 FROM SPRLOG WHERE LOGIDTO=LOGID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 005' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT
					FROM SMSTREETSECTION
					WHERE NOT EXISTS (SELECT 1 FROM SPRLOG WHERE LOGIDFROM=LOGID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 006' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT
					FROM SMSTREETSECTION
					WHERE NOT EXISTS (SELECT 1 FROM SPRLOG WHERE LOGIDTO=LOGID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 007' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT
					FROM SPRLINKS
					WHERE NOT EXISTS (SELECT 1 FROM SPRLOG WHERE LOGIDFROM=LOGID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 008' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT
					FROM SPRLINKS
					WHERE NOT EXISTS (SELECT 1 FROM SPRLOG WHERE LOGIDTO=LOGID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 009' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT
					FROM SPRTOPOLOGY
					WHERE NOT EXISTS (SELECT 1 FROM SPRLOG WHERE LOGIDFROM=LOGID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 010' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT
					FROM SPRTOPOLOGY
					WHERE NOT EXISTS (SELECT 1 FROM SPRLOG WHERE LOGIDTO=LOGID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 011' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT
					FROM SPRGOPERATIONS
					WHERE INTPROCID=0 AND LOGIDTO = 0 AND NOT EXISTS (SELECT 1 FROM SPRLOG WHERE LOGIDFROM=LOGID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 012' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT
					FROM SPRGOPERATIONS
					WHERE NOT EXISTS (SELECT 1 FROM SPRLOG WHERE LOGIDTO=LOGID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


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


		if reg.REPORT_ID = 'GIS 014' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT logidfrom AS logid, 'LogidFrom de sprobjects' AS caso FROM sprobjects
					WHERE EXISTS (SELECT 1 FROM sprlog WHERE sprobjects.logidfrom = logid AND eventstatus <> 0)
					UNION
					SELECT logidto AS logid, 'LogidTo de sprobjects' AS caso FROM sprobjects
					WHERE EXISTS (SELECT 1 FROM sprlog WHERE sprobjects.logidto = logid AND eventstatus <> 0));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 015' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT logidfrom AS logid, 'LogidFrom de smblocks' AS caso FROM smblocks
					WHERE EXISTS (SELECT 1 FROM sprlog WHERE smblocks.logidfrom = logid AND eventstatus <> 0)
					UNION
					SELECT logidto AS logid, 'LogidTo de smblocks' AS caso FROM smblocks
					WHERE EXISTS (SELECT 1 FROM sprlog WHERE smblocks.logidto = logid AND eventstatus <> 0));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 016' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT logidfrom AS logid, 'LogidFrom de smstreetsection' AS caso FROM smstreetsection
					WHERE EXISTS (SELECT 1 FROM sprlog WHERE smstreetsection.logidfrom = logid AND eventstatus <> 0)
					UNION
					SELECT logidto AS logid, 'LogidTo de smstreetsection' AS caso FROM smstreetsection
					WHERE EXISTS (SELECT 1 FROM sprlog WHERE smstreetsection.logidto = logid AND eventstatus <> 0));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 017' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT logidfrom AS logid, 'LogidFrom de sprlinks' AS caso FROM sprlinks
					WHERE EXISTS (SELECT 1 FROM sprlog WHERE sprlinks.logidfrom = logid AND eventstatus <> 0)
					UNION
					SELECT logidto AS logid, 'LogidTo de sprlinks' AS caso FROM sprlinks
					WHERE EXISTS (SELECT 1 FROM sprlog WHERE sprlinks.logidto = logid AND eventstatus <> 0));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 018' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT logidfrom AS logid, 'LogidFrom de sprtopology' AS caso FROM sprtopology
					WHERE EXISTS (SELECT 1 FROM sprlog WHERE sprtopology.logidfrom = logid AND eventstatus <> 0)
					UNION
					SELECT logidto AS logid, 'LogidTo de sprtopology' AS caso FROM sprtopology
					WHERE EXISTS (SELECT 1 FROM sprlog WHERE sprtopology.logidto = logid AND eventstatus <> 0));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 019' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT logidfrom AS logid, 'LogidFrom de sprgoperations' AS caso FROM sprgoperations
					WHERE EXISTS (SELECT 1 FROM sprlog WHERE sprgoperations.logidfrom = logid AND eventstatus <> 0)
					UNION
					SELECT logidto AS logid, 'LogidTo de sprgoperations' AS caso FROM sprgoperations
					WHERE EXISTS (SELECT 1 FROM sprlog WHERE sprgoperations.logidto = logid AND eventstatus <> 0));
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


		if reg.REPORT_ID = 'GIS 021' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT * FROM sprlog
					WHERE logdate < TO_DATE('14000101000000', 'YYYYMMDDHH24MISS')
					or logdate > TO_DATE('20211231235959', 'YYYYMMDDHH24MISS')
					or eventdate < TO_DATE('14000101000000', 'YYYYMMDDHH24MISS')
					or eventdate > TO_DATE('20211231235959', 'YYYYMMDDHH24MISS'));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 022' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SPROBJECTS where exists
					(select * from SMSTREETSECTION where
					SPROBJECTS.OBJECTNAMEID=SMSTREETSECTION.OBJECTNAMEID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 023' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SPROBJECTS where exists
					(select * from SMBLOCKS where SPROBJECTS.OBJECTNAMEID=SMBLOCKS.OBJECTNAMEID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 024' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMBLOCKS where exists
					(select * from SMSTREETSECTION where SMBLOCKS.OBJECTNAMEID=SMSTREETSECTION.OBJECTNAMEID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 025' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM sprobjects o WHERE o.objecttype = 12
					AND EXISTS (SELECT 1 FROM sprobjectvertixs WHERE objectid = o.objectid);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 026' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT COUNT(o.objectid) FROM sprobjects o WHERE NOT EXISTS
					(SELECT 1 FROM net_modules WHERE objectid = o.objectid) AND NOT EXISTS
					(SELECT 1 FROM sprfuncconfig f WHERE f.targetid = o.sprid AND f.dataid1 = 1 AND f.funcid = 750));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 027' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT * FROM sprobjects ob WHERE nextid > 0 AND NOT EXISTS
					(SELECT 1 FROM sprobjects WHERE objectid = ob.nextid AND previousid = ob.objectid));

			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 028' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT * FROM sprobjects ob WHERE previousid > 0 AND NOT EXISTS
					(SELECT 1 FROM sprobjects WHERE objectid = ob.previousid AND nextid = ob.objectid));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 029' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select objectNameId, count(*) from sprObjects where previousId = 0 and nextId = 0
					group by objectNameId having count(*) > 1);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 030' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select b1.* from smblocks b1, smblocks b2 where b1.blockId != b2.blockId
					and b2.previousId = b1.blockId and b2.blockId != b1.nextId);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 031' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select b1.* from smblocks b1, smblocks b2 where b1.blockId != b2.blockId
					and b2.nextId = b1.blockId and b2.blockId != b1.previousId);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 032' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select objectNameId, count(*) from smblocks where previousId = 0 and nextId = 0
					group by objectNameId having count(*) > 1);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 033' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select s1.* from smstreetsection s1, smstreetsection s2 where s1.streetsectionId != s2.streetsectionId
					and s2.previousId = s1.streetsectionId and s2.streetsectionId != s1.nextId);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 034' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select s1.* from smstreetsection s1, smstreetsection s2 where s1.streetsectionId != s2.streetsectionId
					and s2.nextId = s1.streetsectionId and s2.streetsectionId != s1.previousId);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 035' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select objectNameId, count(*) from smstreetsection where previousId = 0 and nextId = 0
					group by objectNameId having count(*) > 1);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 036' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT objectid, angle FROM sprobjects WHERE angle > (3.1415926535897932384626433832795) * 2);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 037' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select pr.projectid, ob.objectid, ob.projectid, pr.closelogid, pr.cancellogid, 'Objeto' as objeto
					from sprgprojects pr, sprobjects ob where ob.logidto = 0 and pr.projectid = ob.projectid
					and (pr.closelogid <> 0 or pr.cancellogid <> 0)
					union all
					select pr.projectid, ob.blockid as objectid, ob.projectid, pr.closelogid, pr.cancellogid, 'Polilinea' as objeto
					from sprgprojects pr, smblocks ob where ob.logidto = 0 and pr.projectid = ob.projectid
					and (pr.closelogid <> 0 or pr.cancellogid <> 0)
					union all
					select pr.projectid, ob.streetsectionid as objectid, ob.projectid, pr.closelogid, pr.cancellogid, 'Seccion de Calle' as objeto
					from sprgprojects pr, smstreetsection ob where ob.logidto = 0 and pr.projectid = ob.projectid
					and (pr.closelogid <> 0 or pr.cancellogid <> 0));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


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


		if reg.REPORT_ID = 'GIS 043' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					Select * from sprtopology
					where not exists (select /*+ PUSH_SUBQ */ 1 from sprobjects where objectidfrom=objectid) and topologytype in (0,6)
					union
					select * from sprtopology
					where not exists (select /*+ PUSH_SUBQ */ 1 from sprobjects where objectidto=objectid) and topologytype in (0,6));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 044' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT(
						SELECT COUNT(*) FROM sprObjects x1, sprTopology x2
						WHERE x1.objectType = 12 AND x2.topologytype = 0 AND x2.objectIdFrom = x1.objectId
						AND NOT EXISTS (SELECT 1 FROM nodePoints x3 WHERE x3.sprId = x1.sprId AND nodeIndexFrom = nodeIndex)
						AND nodeIndexFrom <> -1
						) + (
						SELECT COUNT(*) FROM sprObjects x1, sprTopology x2
						WHERE x1.objectType = 12 AND x2.topologytype = 0 AND x2.objectIdTo = x1.objectId
						AND NOT EXISTS (SELECT 1 FROM nodePoints x3 WHERE x3.sprId = x1.sprId AND nodeIndexTo = nodeIndex)
						AND nodeIndexTo <> -1
						) AS CANTIDAD FROM DUAL);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 045' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT (
						SELECT COUNT(*) FROM sprObjects x1, sprTopology x2
						WHERE x1.objectType = 11 AND x2.topologytype = 0 AND x2.objectIdFrom = x1.objectId
						AND nodeIndexFrom NOT BETWEEN -1 AND 1
						) + (
						SELECT COUNT(*) FROM sprObjects x1, sprTopology x2
						WHERE x1.objectType = 11 AND x2.topologytype = 0 AND x2.objectIdTo = x1.objectId
						AND nodeIndexTo NOT BETWEEN -1 AND 1
						) AS CANTIDAD FROM DUAL);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 046' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select * from sprtopology where (objectidfrom is null OR objectidto is null));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 047' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select * from sprtopology where ObjectIdTo = ObjectIdFrom and topologytype in (0,6));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 048' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT /*+rule*/ o1.objectid, o2.objectid FROM sprtopology t1, sprobjects o1, sprobjects o2
					WHERE t1.objectidfrom = o1.objectid AND t1.objectidto = o2.objectid
					AND t1.topologytype = 0 AND o1.objecttype = 11 AND o2.objecttype = 11);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 049' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT o1.sprid, o2.sprid, COUNT(*)
					FROM sprtopology t, sprobjects o1, sprobjects o2, sprentities e1, sprentities e2
					WHERE t.topologytype = 0 AND t.objectidfrom = o1.objectid AND t.objectidto = o2.objectid
					AND o1.sprid = e1.sprid AND o2.sprid = e2.sprid AND e1.nettypeid <> e2.nettypeid
					GROUP BY o1.sprid, o2.sprid);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 050' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT objectid FROM sprlinks
					MINUS SELECT objectid FROM sprobjects
					MINUS SELECT blockid FROM smblocks
					MINUS SELECT streetsectionid FROM smstreetsection
					MINUS SELECT BLOCKFACADEID FROM SMBLOCKFACADES);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


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


		if reg.REPORT_ID = 'GIS 053' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT objectId, realstate, realdate FROM sprobjects oo WHERE logidto = 0
					AND NOT EXISTS (SELECT 1 FROM sprgoperations WHERE objectid = oo.objectid
					AND logidto = 0 AND statustype = 1 AND intprocid = 0) AND (realstate <> 15 OR realdate IS NOT NULL));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 054' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT objectId, normalstate, normaldate FROM sprobjects oo WHERE logidto = 0
					AND NOT EXISTS (SELECT 1 FROM sprgoperations WHERE objectid = oo.objectid
					AND logidto = 0 AND statustype = 0 AND intprocid = 0) AND (normalstate <> 15 OR normaldate IS NOT NULL));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


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


		if reg.REPORT_ID = 'GIS 056' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT COUNT(*) FROM smBlockFacades f WHERE NOT EXISTS (
					SELECT 1 FROM smBlocks b WHERE b.blockId = f.blockId AND sprId =
					(SELECT targetId FROM sprFuncConfig WHERE funcId = 2350 )));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


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


		/*if reg.REPORT_ID = 'GIS 058' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT tableId, TRIM(tableName) as tableName, nextId, rangeSize, (SELECT MAX(streetId) FROM SMSTREETS) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(streetId) FROM smStreets) AND UPPER(TRIM(tableName)) = 'SMSTREETS'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(streetTypeId) FROM smStreetTypes) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(streetTypeId) FROM smStreetTypes) AND UPPER(TRIM(tablename))='SMSTREETTYPES'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(logId) FROM sprLog) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(logId) FROM sprLog) AND UPPER(TRIM(tablename))='SPRLOG'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(objectId) FROM sprObjects) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(objectId) FROM sprObjects) AND UPPER(TRIM(tablename))='SPROBJECTS'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(objectId) FROM sprObjects) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(streetsectionId) FROM smstreetsection) AND UPPER(TRIM(tablename))='SPROBJECTS'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(blockId) FROM smblocks) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(blockId) FROM smblocks) AND TRIM(tablename) = 'SPROBJECTS'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(blockfacadeId) FROM smblockfacades) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(blockfacadeId) FROM smblockfacades) AND UPPER(TRIM(tablename))='SPROBJECTS'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(topologyId) FROM sprTopology) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(topologyId) FROM sprTopology) AND TRIM(tablename) = 'SPRTOPOLOGY'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(operationId) FROM sprgOperations) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(operationId) FROM sprgOperations) AND UPPER(TRIM(tablename))='SPRGOPERATIONS'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(interruptionId) FROM sprgInterruptions) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(interruptionId) FROM sprgInterruptions) AND UPPER(TRIM(tablename))='SPRGINTERRUPTIONS'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(linkIntId) FROM sprgLinkInterrupt) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(linkIntId) FROM sprgLinkInterrupt) AND UPPER(TRIM(tablename))='SPRGLINKINTERRUPT'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(intProcId) FROM sprgIntProcesses) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(intProcId) FROM sprgIntProcesses) AND UPPER(TRIM(tablename))='SPRGINTPROCESSES'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(projectId) FROM sprgProjects) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(projectId) FROM sprgProjects) AND UPPER(TRIM(tablename))='SPRGPROJECTS'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(tempIntId) FROM sprgTempInt) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(tempIntId) FROM sprgTempInt) AND UPPER(TRIM(tablename))='SPRGTEMPINT'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(selectionId) FROM sprgSelection) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(selectionId) FROM sprgSelection) AND UPPER(TRIM(tablename))='SPRGSELECTION'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(projParametersId) FROM sprgProjParameters) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(projParametersId) FROM sprgProjParameters) AND UPPER(TRIM(tablename))='SPRGPROJPARAMETERS'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(scaleId) FROM sprSymbScales) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(scaleId) FROM sprSymbScales) AND UPPER(TRIM(tablename))='SPRGSYMBSCALES'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(hierarchyId) FROM sprEntHierarchies) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(hierarchyId) FROM sprEntHierarchies) AND UPPER(TRIM(tablename))='SPRGENTHIERARCHIES'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(profileId) FROM sprSymbProfiles) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(profileId) FROM sprSymbProfiles) AND UPPER(TRIM(tablename))='SPRSYMBPROFILES' --tableId = 54
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(ruleId) FROM sprSymbRules) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(ruleId) FROM sprSymbRules) AND UPPER(TRIM(tablename))='SPRSYMBRULES' --tableId = 56
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(stringId) FROM sprStringChunks) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(stringId) FROM sprStringChunks) AND UPPER(TRIM(tablename))='SPRSTRINGCHUNKS' --tableId = 57
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(categoryId) FROM sprSymbGSCat) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(categoryId) FROM sprSymbGSCat) AND UPPER(TRIM(tablename))='SPRSYMBGSCAT' --tableId = 58
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(rangeId) FROM sprSymbScaleRanges) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(rangeId) FROM sprSymbScaleRanges) AND UPPER(TRIM(tablename))='SPRSYMBSCALERANGES' --tableId = 59
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(categoryId) FROM sprEntCategories) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(categoryId) FROM sprEntCategories) AND UPPER(TRIM(tablename))='SPRENTCATEGORIES' --tableId = 60
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(gsId) FROM sprSymbGS) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(gsId) FROM sprSymbGS) AND UPPER(TRIM(tablename))='SPRSYMBGS' --tableId = 61
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(gsPartId) FROM sprSymbGSPart) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(gsPartId) FROM sprSymbGSPart) AND UPPER(TRIM(tablename))='SPRSYMBGSPART' --tableId = 62
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(gsPartVertexId) FROM sprSymbGSPartVertex) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(gsPartVertexId) FROM sprSymbGSPartVertex) AND UPPER(TRIM(tablename))='SPRSYMBGSPARTVERTEX' --tableId = 63
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(ID_PACKAGE_INFO) FROM FDL_PACKAGE_INFO) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(ID_PACKAGE_INFO) FROM FDL_PACKAGE_INFO) AND UPPER(TRIM(tablename))='APPS.PACKAGEINFO'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(ID_PACKAGE_INFO) FROM FDL_PACKAGE_INFO) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(ID_APPINFO) FROM FDL_APPINFO) AND UPPER(TRIM(tablename))='APPS.APPINFO'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (SELECT MAX(ID) FROM OMS_DOCUMENT) as utilizado FROM sprTables
					WHERE nextId < (SELECT MAX(ID) FROM OMS_DOCUMENT) AND UPPER(TRIM(tablename))='OMS.SEQ'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (select max (sprcallid) from dscccalls) as utilizado FROM sprTables
					WHERE nextId < (select max (sprcallid) from dscccalls) AND UPPER(TRIM(tablename))='4DL.CC.DSCCCALLS'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (select max (sprreclaimid) from dsccreclaims) as utilizado FROM sprTables
					WHERE nextId < (select max (sprreclaimid) from dsccreclaims) AND UPPER(TRIM(tablename))='DSCCRECLAIMS'
					UNION
					SELECT tableId, TRIM(tablename) as tableName, nextId, rangeSize, (select max (session_id) from as_session) as utilizado FROM sprTables
					WHERE nextId < (select max (session_id) from as_session) AND UPPER(TRIM(tablename))='SESSIONMANAGER');
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;*/


		if reg.REPORT_ID = 'GIS 059' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT objectid FROM sprobjectvertixs
					MINUS SELECT objectid FROM sprobjects WHERE objecttype = 11);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 060' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT objectid FROM net_modules
					MINUS SELECT objectid FROM sprobjects);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 061' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT objectid FROM sm_modules
					MINUS SELECT blockid FROM smblocks
					MINUS SELECT streetsectionid FROM smstreetsection);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 062' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select 'OBJETOS' AS caso,count(*) from sprobjects where logidfrom = logidto
					union all
					select 'MANZANAS' AS caso,count(*) from smblocks where logidfrom = logidto
					union all
					select 'CALLES' AS caso,count(*) from smstreetsection where logidfrom = logidto
					union all
					select 'LINKS' AS caso,count(*) from sprlinks where logidfrom = logidto
					union all
					select 'TOPOLOGIAS' AS caso,count(*) from sprtopology where logidfrom = logidto
					union all
					select 'OPERACIONES' AS caso,count(*) from sprgoperations where logidfrom = logidto);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


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


		if reg.REPORT_ID = 'GIS 064' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select p.* from sprgoperations p, sprobjects o
					where p.documenttype = 'D'
					and o.objectid = p.objectid
					and p.operationdate = o.datefrom
					and p.logidto = 0);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 065' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select p.* from sprgoperations p, sprobjects o
					where p.documenttype = 'D'
					and o.objectid = p.objectid
					and p.operationdate = o.dateto
					and p.logidto = 0);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 066' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT op1.operationid, op1.objectid, op1.documenttype, o1.datefrom, op1.operationdate, o1.dateto
					FROM sprobjects o1, sprgoperations op1
					WHERE op1.objectid = o1.objectid
					AND op1.intprocid = 0
					AND op1.logidto = 0
					AND (op1.operationdate < o1.datefrom OR op1.operationdate > o1.dateto));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 067' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMBLOCKS
					WHERE NOT EXISTS (SELECT 1 FROM SPRENTITIES WHERE SMBLOCKS.SPRID=SPRENTITIES.SPRID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 068' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM sprObjects WHERE objectId <= 0;
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 069' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM smBlocks WHERE blockId <= 0;
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 070' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM smStreetSection WHERE streetSectionId <= 0;
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 071' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM smBlockFacades WHERE blockFacadeId <= 0;
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 072' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SPROBJECTS WHERE EXISTS
					(SELECT 1 FROM SMSTREETSECTION WHERE
					SPROBJECTS.OBJECTID=SMSTREETSECTION.STREETSECTIONID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 073' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SPROBJECTS WHERE EXISTS
					(SELECT 1 FROM SMBLOCKS WHERE
					SPROBJECTS.OBJECTID=SMBLOCKS.BLOCKID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 074' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SPROBJECTS WHERE EXISTS
					(SELECT 1 FROM SMBLOCKFACADES WHERE
					SPROBJECTS.OBJECTID=SMBLOCKFACADES.BLOCKFACADEID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 075' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMSTREETSECTION WHERE EXISTS
					(SELECT 1 FROM SMBLOCKS WHERE
					SMSTREETSECTION.STREETSECTIONID=SMBLOCKS.BLOCKID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 076' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMSTREETSECTION WHERE EXISTS
					(SELECT 1 FROM SMBLOCKFACADES WHERE
					SMSTREETSECTION.STREETSECTIONID=SMBLOCKFACADES.BLOCKFACADEID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 077' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMBLOCKS WHERE EXISTS
					(SELECT 1 FROM SMBLOCKFACADES WHERE
					SMBLOCKS.BLOCKID=SMBLOCKFACADES.BLOCKFACADEID);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 078' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SPRLINKS x0 WHERE NOT EXISTS
					(SELECT 1 FROM links x1 WHERE x0.linkId=x1.linkId);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 079' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT COUNT(*) FROM SPRLINKS x0
					WHERE objectType IN (11,12)
					AND EXISTS (SELECT 1 FROM LINKS x1 WHERE x0.linkId=x1.linkId)
					AND NOT EXISTS (SELECT 1 FROM SPROBJECTS x2, PERMITABLELINKS x3
					WHERE x0.objectId=x2.objectId AND x2.sprId=x3.sprId));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 080' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT COUNT(*) FROM SPRLINKS x0
					WHERE objectType=20
					AND EXISTS (SELECT 1 FROM LINKS x1 WHERE x0.linkId=x1.linkId)
					AND NOT EXISTS (SELECT 1 FROM SMBLOCKS x2, PERMITABLELINKS x3
					WHERE x0.objectId=x2.blockId AND x2.sprId=x3.sprId));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 081' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SPRLINKS x0
					WHERE objectType=21
					AND EXISTS (SELECT 1 FROM LINKS x1 WHERE x0.linkId=x1.linkId)
					AND NOT EXISTS (SELECT 1 FROM PERMITABLELINKS x2 WHERE x2.sprId=-3);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 082' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SPRLINKS x0
					WHERE objectType=23
					AND EXISTS (SELECT 1 FROM LINKS x1 WHERE x0.linkId=x1.linkId)
					AND NOT EXISTS (SELECT 1 FROM PERMITABLELINKS x2 WHERE x2.sprId=-2);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 083' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT COUNT(*) FROM SPROBJECTS x0, PERMITABLELINKS x1
					WHERE x0.sprId = x1.sprId AND x1.mustHave = 1 AND x0.logIdTo = 0
					AND NOT EXISTS (SELECT 1 FROM SPRLINKS x2 WHERE x2.objectId=x0.objectId AND x2.linkId=x1.linkId AND x2.logIdTo=0));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 084' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT COUNT(*) FROM SMBLOCKS x0, PERMITABLELINKS x1
					WHERE x0.sprId = x1.sprId AND x1.mustHave = 1 AND x0.logIdTo = 0
					AND NOT EXISTS (SELECT 1 FROM SPRLINKS x2 WHERE x2.objectId=x0.blockId AND x2.linkId=x1.linkId AND x2.logIdTo=0));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 085' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMSTREETSECTION x0, PERMITABLELINKS x1
					WHERE x1.sprId = -3 AND x1.mustHave = 1 AND x0.logIdTo = 0
					AND NOT EXISTS (SELECT 1 FROM SPRLINKS x2 WHERE x2.objectId=x0.streetSectionId AND x2.linkId=x1.linkId AND x2.logIdTo=0);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 086' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMBLOCKFACADES x0, PERMITABLELINKS x1, SMBLOCKS x3
					WHERE x1.sprId = -2 AND x1.mustHave = 1 AND x3.blockId=x0.blockId AND x3.logIdTo=0
					AND NOT EXISTS (SELECT 1 FROM SPRLINKS x2 WHERE x2.objectId=x0.blockFacadeId AND x2.linkId=x1.linkId AND x2.logIdTo=0);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 087' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT COUNT(*) FROM SPROBJECTS x0, PERMITABLELINKS x1
					WHERE x0.sprId = x1.sprId AND x1.moreThanOne = 0 AND x0.logIdTo = 0
					AND (SELECT COUNT(*) FROM SPRLINKS x2 WHERE x2.objectId=x0.objectId AND x2.linkId=x1.linkId AND x2.logIdTo=0) > 1);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 088' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMBLOCKS x0, PERMITABLELINKS x1
					WHERE x0.sprId = x1.sprId AND x1.moreThanOne = 0 AND x0.logIdTo = 0
					AND (SELECT COUNT(*) FROM SPRLINKS x2 WHERE x2.objectId=x0.blockId AND x2.linkId=x1.linkId AND x2.logIdTo=0) > 1;
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 089' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMSTREETSECTION x0, PERMITABLELINKS x1
					WHERE x1.sprId = -3 AND x1.moreThanOne = 0 AND x0.logIdTo = 0
					AND (SELECT COUNT(*) FROM SPRLINKS x2 WHERE x2.objectId=x0.streetSectionId AND x2.linkId=x1.linkId AND x2.logIdTo=0) > 1;
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 090' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMBLOCKFACADES x0, PERMITABLELINKS x1, SMBLOCKS x3
					WHERE x1.sprId = -2 AND x1.moreThanOne = 0 AND x3.blockId=x0.blockId AND x3.logIdTo=0
					AND (SELECT COUNT(*) FROM SPRLINKS x2 WHERE x2.objectId=x0.blockFacadeId AND x2.linkId=x1.linkId AND x2.logIdTo=0) > 1;
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 091' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT streetSectionId FROM smStreetSection
					MINUS SELECT streetSectionId FROM smStreetGeo);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 092' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT streetSectionId FROM smStreetGeo
					MINUS SELECT streetSectionId FROM smStreetSection);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 093' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT blockId FROM smBlocks
					MINUS SELECT blockId FROM smBlockGeo);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 094' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT blockId FROM smBlockGeo
					MINUS SELECT blockId FROM smBlocks);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 095' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT COUNT(*) FROM SPROBJECTS O
					WHERE (O.X < (SELECT VARVALUE FROM SPRGSYSVARS WHERE VARID = 1008)
					OR O.X > (SELECT VARVALUE FROM SPRGSYSVARS WHERE VARID = 1010)
					OR O.Y < (SELECT VARVALUE FROM SPRGSYSVARS WHERE VARID = 1009)
					OR O.Y > (SELECT VARVALUE FROM SPRGSYSVARS WHERE VARID = 1011))
					AND NOT EXISTS (SELECT 1 FROM SPRFUNCCONFIG F WHERE F.TARGETID = O.SPRID AND F.DATAID1 = 1 AND F.FUNCID = 750));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 096' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SPROBJECTVERTIXS OV, SPROBJECTS O
					WHERE (OV.X < (SELECT VARVALUE FROM SPRGSYSVARS WHERE VARID = 1008)
					OR OV.X > (SELECT VARVALUE FROM SPRGSYSVARS WHERE VARID = 1010)
					OR OV.Y < (SELECT VARVALUE FROM SPRGSYSVARS WHERE VARID = 1009)
					OR OV.Y > (SELECT VARVALUE FROM SPRGSYSVARS WHERE VARID = 1011))
					AND O.OBJECTID = OV.OBJECTID
					AND NOT EXISTS (SELECT 1 FROM SPRFUNCCONFIG F WHERE F.TARGETID = O.SPRID AND F.DATAID1 = 1 AND F.FUNCID = 750);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 097' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select * from sprlinks l
					where not exists (select  1 from sprobjects where l.objectid=objectid)
					and not exists (select  1 from smblocks where l.objectid=blockid));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 098' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT l.objectid, l.linkid, l.linkvalue, l.datefrom as DATEFROM_LINK, l.dateto as DATETO_LINK, o.datefrom as DATEFROM_OBJ, o.dateto as DATETO_OBJ
					FROM sprlinks l, sprObjects o
					WHERE l.objectId = o.objectId
					AND (o.dateFrom > l.dateFrom OR o.dateTo < l.dateTo));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 099' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select l.objectid,l.linkid,l.linkvalue, count(*)
					from permitablelinks p, sprlinks l, sprobjects o
					where p.UNIQUENESSFLAG = 1
					and l.linkid = p.linkid
					and l.logidto = 0
					and l.objectid = o.objectid
					and o.sprid = p.sprid
					group by  l.objectid,l.linkid,l.linkvalue
					having count(*) > 1);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		/*if reg.REPORT_ID = 'GIS 100' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select p.sprid,l1.linkid,l1.linkvalue, count(*)
					from permitablelinks p, sprlinks l1, sprlinks l2, sprobjects o1, sprobjects o2, sprentities e1, sprentities e2
					where p.UNIQUENESSFLAG = 2
					and l1.linkid = p.linkid
					and l2.linkid = p.linkid
					and l1.logidto = 0
					and l2.logidto = 0
					and l1.objectid = o1.objectid
					and l2.objectid = o2.objectid
					and o1.sprid = p.sprid
					and o2.sprid = p.sprid
					and e1.sprid = o1.sprid
					and e2.sprid = o2.sprid
					and e1.categId = e2.categId
					and (l1.objectid != l2.objectid or l1.objectid = l2.objectid and l1.seqorder < l2.seqorder)
					and l1.linkvalue = l2.linkvalue
					group by  p.sprid,l1.linkid,l1.linkvalue
					having count(*) > 1);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;*/


		/*if reg.REPORT_ID = 'GIS 101' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select p.sprid,l1.linkid,l1.linkvalue, count(*)
					from permitablelinks p, sprlinks l1, sprlinks l2, sprobjects o1, sprobjects o2, sprentities e1, sprentities e2
					where p.UNIQUENESSFLAG = 3
					and l1.linkid = p.linkid
					and l2.linkid = p.linkid
					and l1.logidto = 0
					and l2.logidto = 0
					and l1.objectid = o1.objectid
					and l2.objectid = o2.objectid
					and o1.sprid = p.sprid
					and o2.sprid = p.sprid
					and e1.sprid = o1.sprid
					and e2.sprid = o2.sprid
					and e1.netTypeId = e2.netTypeId
					and (l1.objectid != l2.objectid or l1.objectid = l2.objectid and l1.seqorder < l2.seqorder)
					and l1.linkvalue = l2.linkvalue
					group by  p.sprid,l1.linkid,l1.linkvalue
					having count(*) > 1);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;*/


		/*if reg.REPORT_ID = 'GIS 102' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select p.sprid,l1.linkid,l1.linkvalue, count(*)
					from permitablelinks p, sprlinks l1, sprlinks l2, sprobjects o1, sprobjects o2
					where p.UNIQUENESSFLAG = 4
					and l1.linkid = p.linkid
					and l2.linkid = p.linkid
					and l1.logidto = 0
					and l2.logidto = 0
					and l1.objectid = o1.objectid
					and l2.objectid = o2.objectid
					and o1.sprid = p.sprid
					and o2.sprid = p.sprid
					and o1.sprid = o2.sprid
					and (l1.objectid != l2.objectid or l1.objectid = l2.objectid and l1.seqorder < l2.seqorder)
					and l1.linkvalue = l2.linkvalue
					group by  p.sprid,l1.linkid,l1.linkvalue
					having count(*) > 1);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;*/


		/*if reg.REPORT_ID = 'GIS 103' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					select l1.linkid,l1.linkvalue, count(*)
					from permitablelinks p, sprlinks l1, sprlinks l2
					where p.uniquenessFlag=5
					and l1.linkid = p.linkid
					and l2.linkid = p.linkid
					and l1.logidto = 0
					and l2.logidto = 0
					and (l1.objectid != l2.objectid or l1.objectid = l2.objectid and l1.seqorder != l2.seqorder)
					and l1.linkvalue = l2.linkvalue
					group by l1.linkid,l1.linkvalue
					having count(*) > 1);
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;*/


		if reg.REPORT_ID = 'GIS 104' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM SMSTREETSECTION WHERE EXISTS (SELECT 1 from AMAREAS WHERE SMSTREETSECTION.STREETSECTIONID=AMAREAS.AREAID);
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


		if reg.REPORT_ID = 'GIS 108' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT * FROM SPRLOG L, sprobjects O
					WHERE (L.LOGID = O.LOGIDFROM AND L.EVENTDATE != O.DATEFROM) OR (L.LOGID = O.LOGIDTO AND L.EVENTDATE != O.DATETO));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 109' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT * FROM SPRLOG L, smblocks O
					WHERE (L.LOGID = O.LOGIDFROM AND L.EVENTDATE != O.DATEFROM) OR (L.LOGID = O.LOGIDTO AND L.EVENTDATE != O.DATETO));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 110' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT * FROM SPRLOG L, smstreetsection O
					WHERE (L.LOGID = O.LOGIDFROM AND L.EVENTDATE != O.DATEFROM) OR (L.LOGID = O.LOGIDTO AND L.EVENTDATE != O.DATETO));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 111' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT * FROM SPRLOG L, sprlinks O
					WHERE (L.LOGID = O.LOGIDFROM AND L.EVENTDATE != O.DATEFROM) OR (L.LOGID = O.LOGIDTO AND L.EVENTDATE != O.DATETO));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 112' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT * FROM SPRLOG L, sprtopology O
					WHERE (L.LOGID = O.LOGIDFROM AND L.EVENTDATE != O.DATEFROM) and topologytype in (0)
					OR (L.LOGID = O.LOGIDTO AND L.EVENTDATE != O.DATETO)  and topologytype in (0));
			END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;


		if reg.REPORT_ID = 'GIS 113' and reg.REPORT_ENABLED = 1 then

			BEGIN
                select SYSDATE into exec_begin from dual;
            END;

			BEGIN
				SELECT COUNT(*) INTO RESULT FROM(
					SELECT * FROM SPRLOG L, sprgoperations O
					WHERE (L.LOGID = O.LOGIDFROM AND L.EVENTDATE != O.operationdate)
					and intprocid = 0 and logidto = 0);
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

END SP_INCONS_GIS;
/

