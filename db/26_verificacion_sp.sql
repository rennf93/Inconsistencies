create or replace PROCEDURE VERIF_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='VERIFICACION' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

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

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END VERIF_INCONS;
/