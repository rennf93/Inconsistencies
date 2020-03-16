create or replace PROCEDURE VALID_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='VALIDACION' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

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

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END VALID_INCONS;
/