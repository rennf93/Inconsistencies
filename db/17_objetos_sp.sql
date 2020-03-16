create or replace PROCEDURE OBJ_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='OBJETOS' order by REPORT_ID;

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

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END OBJ_INCONS;
/