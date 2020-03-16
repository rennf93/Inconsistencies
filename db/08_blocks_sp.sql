create or replace PROCEDURE BLOCKS_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='BLOCKS' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

        if reg.REPORT_ID = 'GIS 067' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN
            SELECT COUNT(*) INTO RESULT FROM SMBLOCKS
        WHERE NOT EXISTS (SELECT 1 FROM SPRENTITIES WHERE SMBLOCKS.SPRID=SPRENTITIES.SPRID);
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

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END BLOCKS_INCONS;
/