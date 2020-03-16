create or replace PROCEDURE CALLES_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='CALLES' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

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

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END CALLES_INCONS;
/