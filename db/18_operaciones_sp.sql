create or replace PROCEDURE OPS_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='OPERACIONES' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

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

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END OPS_INCONS;
/