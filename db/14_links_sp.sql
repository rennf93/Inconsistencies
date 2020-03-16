create or replace PROCEDURE LINKS_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='LINKS' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP
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

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END LINKS_INCONS;
/