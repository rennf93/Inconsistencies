create or replace PROCEDURE TOPOLOGY_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='TOPOLOGIA' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

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

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END TOPOLOGY_INCONS;
/