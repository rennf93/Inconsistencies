create or replace PROCEDURE MU_INCONS_B(P_ORIGEN VARCHAR2, P_DESTINO VARCHAR2, P_DBLINK_ORI VARCHAR2)
AS

result number := 0;
exec_begin DATE := SYSDATE;
exec_end DATE := SYSDATE;
v_script VARCHAR2(2000);

    CURSOR INCO IS
        select * from MU_INCONSISTENCIAS where custom_index = 'B' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

        if reg.REPORT_ID = 'SCRIPT1B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :=
            'SELECT COUNT (1) SCRIPT1B
            FROM (SELECT id_area FROM ' || P_DESTINO || '.AREA_H
            MINUS
            SELECT DISTINCT (ah.areaid)
            FROM ' || P_ORIGEN || '.amareas_h@' || P_DBLINK_ORI || ' ah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE AH.LOGIDFROM = l.LOGID AND l.EVENTSTATUS = 0
            MINUS
            SELECT 0 ID_AREA
            FROM ' || P_DESTINO || '.AREA_H
            WHERE ID_AREA = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT2B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT2B
            FROM (SELECT DISTINCT (gaph.id_area)
            FROM ' || P_DESTINO || '.area_pol_h gaph, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE GAPH.ID_INC_DESDE = l.logid AND L.EVENTSTATUS = 0
            MINUS
            SELECT DISTINCT (aph.areaid)
            FROM ' || P_ORIGEN || '.ampolygons_h@' || P_DBLINK_ORI || ' aph,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l,
            ' || P_ORIGEN || '.ampolygongeo_h@' || P_DBLINK_ORI || ' apgh,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l2,
            ' || P_ORIGEN || '.amareas@' || P_DBLINK_ORI || ' am
            WHERE aph.logidfrom = l.logid
            AND L.EVENTSTATUS = 0
            AND APH.POLYGONID = APGH.POLYGONID
            AND APGH.LOGIDFROM = l2.logid
            AND L2.EVENTSTATUS = 0
            AND am.areaid = aph.areaid)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT3B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT3B
            FROM (SELECT DISTINCT (ath.id_tipo_area)
            FROM ' || P_DESTINO || '.AREA_TIPO_H ath, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ATH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (ath.areatypeid)
            FROM ' || P_ORIGEN || '.AMAREATYPES_H@' || P_DBLINK_ORI || ' ath, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ath.logidfrom = l.logid AND l.eventstatus = 0
            MINUS
            SELECT 0
            FROM ' || P_DESTINO || '.AREA_TIPO_H
            WHERE ID_TIPO_AREA = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT4B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT4B
            FROM (SELECT DISTINCT (id_calle)
            FROM ' || P_DESTINO || '.CALLE_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (streetid)
            FROM ' || P_ORIGEN || '.smstreets_h@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT5B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT5B
            FROM (SELECT DISTINCT (id_calle_nom)
            FROM ' || P_DESTINO || '.CALLE_NOMBRE_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (streetid)
            FROM ' || P_ORIGEN || '.smstreets_h@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT6B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT6B
            FROM (SELECT DISTINCT (ch.id_tipo_calle)
            FROM ' || P_DESTINO || '.CALLE_TIPO_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (streettypeid)
            FROM ' || P_ORIGEN || '.SMSTREETTYPES_H@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid AND l.eventstatus = 0
            MINUS
            SELECT id_tipo_calle
            FROM ' || P_DESTINO || '.CALLE_TIPO_H
            WHERE id_tipo_calle = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT7B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT7B
            FROM (SELECT DISTINCT (ch.id_calle_seg)
            FROM ' || P_DESTINO || '.CALLE_SEG_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (SH.OBJECTNAMEID)
            FROM ' || P_ORIGEN || '.SMSTREETsection@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT8B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT8B
            FROM (SELECT DISTINCT (ch.id_manzana)
            FROM ' || P_DESTINO || '.MANZANA_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (SH.objectnameid)
            FROM ' || P_ORIGEN || '.SMBLOCKS@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid  and sh.sprid = 311 AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT9B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT9B
            FROM (SELECT DISTINCT (SH.userid)
            FROM ' || P_ORIGEN || '.USERS_H@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (ch.id_usuario)
            FROM ' || P_DESTINO || '.USUARIO_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT10B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT10B
            FROM (SELECT DISTINCT (ch.id_vereda)
            FROM ' || P_DESTINO || '.VEREDA_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (SH.blockfacadeid)
            FROM ' || P_ORIGEN || '.smblockfacades@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l, ' || P_ORIGEN || '.smblocks@' || P_DBLINK_ORI || ' b
            WHERE b.logidfrom = l.logid
            and b.sprid = 311
            AND l.eventstatus = 0
            AND b.blockid = sh.blockid)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT12B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT12B
            FROM (SELECT DISTINCT (ADH.ID_ATR)
            FROM ' || P_DESTINO || '.ATR_DEF_H adh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ADH.ID_INC_HASTA = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (lh.linkid)
            FROM ' || P_ORIGEN || '.links_h@' || P_DBLINK_ORI || ' lh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE lh.logidfrom = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT13B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT13B
            FROM (SELECT DISTINCT (rh.id_red)
            FROM ' || P_DESTINO || '.RED_H rh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE RH.ID_INC_DESDE = l.logid AND L.EVENTSTATUS = 0
            MINUS
            SELECT DISTINCT (nettypeid)
            FROM ' || P_ORIGEN || '.nettypes_h@' || P_DBLINK_ORI || ' nh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE NH.LOGIDFROM = l.logid AND l.eventstatus = 0
            MINUS
            SELECT id_red
            FROM ' || P_DESTINO || '.RED_H
            WHERE id_red = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT14B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT14B
            FROM ( (SELECT DISTINCT (rh.id_cat)
            FROM ' || P_DESTINO || '.CATEGORIA_H rh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE RH.ID_INC_DESDE = l.logid AND L.EVENTSTATUS = 0
            MINUS
            SELECT DISTINCT (nh.categid)
            FROM ' || P_ORIGEN || '.categories_h@' || P_DBLINK_ORI || ' nh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE NH.LOGIDFROM = l.logid AND l.eventstatus = 0))';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT15B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT15B
            FROM (SELECT DISTINCT (rh.id_clase)
            FROM ' || P_DESTINO || '.CLASE_H rh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE RH.ID_INC_DESDE = l.logid AND L.EVENTSTATUS = 0
            MINUS
            SELECT DISTINCT (nh.sprid)
            FROM ' || P_ORIGEN || '.sprentities_h@' || P_DBLINK_ORI || ' nh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE NH.LOGIDFROM = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT16B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT16B
            FROM (SELECT DISTINCT (mah.id_manzana)
            FROM ' || P_DESTINO || '.MANZANA_ATR_H mah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE MAH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (b.objectnameid)
            FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' l,
            ' || P_ORIGEN || '.smblocks@' || P_DBLINK_ORI || ' b,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l2,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l3
            WHERE l.objectid = b.blockid
            AND b.sprid = 311
            AND b.logidfrom = l2.logid
            AND l2.eventstatus = 0
            AND L.LOGIDFROM = l3.logid
            AND l3.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT17B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT17B
            FROM (SELECT DISTINCT (mah.id_calle)
            FROM ' || P_DESTINO || '.CALLE_ATR_H mah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE MAH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (l.objectid)
            FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' l,
            ' || P_ORIGEN || '.smstreetsection@' || P_DBLINK_ORI || ' b,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l2,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l3
            WHERE l.objectid = b.objectnameid
            AND b.logidfrom = l2.logid
            AND l2.eventstatus = 0
            AND L.LOGIDFROM = l3.logid
            AND l3.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT18B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT18B
            FROM (SELECT DISTINCT (vah.id_vereda)
            FROM ' || P_DESTINO || '.VEREDA_ATR_H vah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE vah.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (l.objectid)
            FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' l,
            ' || P_ORIGEN || '.smblockfacades@' || P_DBLINK_ORI || ' b,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' lo,
            ' || P_ORIGEN || '.smblocks@' || P_DBLINK_ORI || ' bl,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' lo2
            WHERE l.objectid = b.blockfacadeid
            AND l.logidfrom = lo.logid
            AND lo.eventstatus = 0
            and bl.sprid = 311
            AND B.BLOCKID = bl.blockid
            AND bl.logidfrom = lo2.logid
            AND lo2.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT19B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT19B
            FROM (SELECT DISTINCT (eh.id_ele)
            FROM ' || P_DESTINO || '.ELEMENTO_H eh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE EH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (ob.objectnameid)
            FROM ' || P_ORIGEN || '.sprobjects@' || P_DBLINK_ORI || ' ob, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ob.logidfrom = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT20B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1)  SCRIPT20B
            FROM (SELECT DISTINCT (eh.id_ele)
            FROM ' || P_DESTINO || '.ELEM_GEO_H eh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE EH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (ob.objectnameid)
            FROM ' || P_ORIGEN || '.sprobjects@' || P_DBLINK_ORI || ' ob, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ob.logidfrom = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT21B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT21B
            FROM (SELECT *
            FROM ' || P_ORIGEN || '.sprtopology@' || P_DBLINK_ORI || ' t1
            WHERE logidto = 0
            AND NOT EXISTS
            (SELECT (1)
            FROM ' || P_ORIGEN || '.sprtopology@' || P_DBLINK_ORI || ' t2
            WHERE t2.objectidfrom = t1.objectidto
            AND t1.objectidfrom = t2.objectidto
            AND t1.nodeindexfrom = t2.nodeindexto
            AND t2.nodeindexfrom = t1.nodeindexto
            AND T1.LOGIDFROM = t2.logidfrom
            AND t1.logidto = t2.logidto))';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT22B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT22B
            FROM (SELECT DISTINCT (eh.id_ele)
            FROM ' || P_DESTINO || '.ELEM_ATR_H eh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE EH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (ob.objectnameid)
            FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' li, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l, ' || P_ORIGEN || '.sprobjects@' || P_DBLINK_ORI || ' ob
            WHERE li.logidfrom = l.logid
            AND l.eventstatus = 0
            AND li.objectid = ob.objectid)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT23B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT23B
            FROM (SELECT AREAID
            FROM ' || P_ORIGEN || '.AMAREAS_H@' || P_DBLINK_ORI || ' ah, ' || P_ORIGEN || '.SPRLOG@' || P_DBLINK_ORI || ' l
            WHERE ah.LOGIDTO = 0 AND l.LOGID=ah.LOGIDFROM AND l.EVENTSTATUS=0
            MINUS
            SELECT ID_AREA
            FROM ' || P_DESTINO || '.AREA
            WHERE ID_AREA > 0 AND ID_INC_HASTA = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT24B_1' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT24B_1
            FROM (SELECT g.POLYGONID, X, Y
            FROM ' || P_ORIGEN || '.AMPOLYGONGEO_h@' || P_DBLINK_ORI || ' g
            INNER JOIN ' || P_ORIGEN || '.ampolygons_h@' || P_DBLINK_ORI || ' p ON p.polygonId = g.polygonId
            WHERE p.logidto = 0 AND g.logidto = 0
            MINUS
            SELECT ID_EXTRA, vtc.X, vtc.Y
            FROM ' || P_DESTINO || '.AREA_VTC vtc, ' || P_DESTINO || '.AREA_POL a
            WHERE a.ID_POL = vtc.ID_POL)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT24B_2' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT24B_2
            FROM (SELECT ID_EXTRA, vtc.X, vtc.Y
            FROM ' || P_DESTINO || '.AREA_VTC vtc, ' || P_DESTINO || '.AREA_POL a
            WHERE a.ID_POL = vtc.ID_POL
            MINUS
            SELECT g.POLYGONID, X, Y
            FROM ' || P_ORIGEN || '.AMPOLYGONGEO_h@' || P_DBLINK_ORI || ' g
            INNER JOIN ' || P_ORIGEN || '.ampolygons_h@' || P_DBLINK_ORI || ' p ON p.polygonId = g.polygonId
            WHERE p.logidto = 0 AND g.logidto = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT25B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT25B
            FROM (SELECT DISTINCT (ath.id_tipo_area)
            FROM ' || P_DESTINO || '.AREA_TIPO ath, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ATH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND ATH.ID_INC_HASTA = 0
            MINUS
            SELECT DISTINCT (ath.areatypeid)
            FROM ' || P_ORIGEN || '.AMAREATYPES_H@' || P_DBLINK_ORI || ' ath, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ath.logidfrom = l.logid
            AND l.eventstatus = 0
            AND ath.logidto = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT26B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT26B
            FROM (SELECT STREETID
            FROM ' || P_ORIGEN || '.SMSTREETS_H@' || P_DBLINK_ORI || '
            WHERE LOGIDTO = 0
            MINUS
            SELECT ID_CALLE_NOM
            FROM ' || P_DESTINO || '.CALLE_NOMBRE
            WHERE ID_INC_HASTA = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT27B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT27B
            FROM (SELECT DISTINCT (ch.id_tipo_calle)
            FROM ' || P_DESTINO || '.CALLE_TIPO ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND CH.ID_INC_HASTA = 0
            MINUS
            SELECT DISTINCT (streettypeid)
            FROM ' || P_ORIGEN || '.SMSTREETTYPES_H@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid
            AND sh.logidto = 0
            AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT28B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT28B
            FROM (SELECT DISTINCT (SH.OBJECTNAMEID)
            FROM ' || P_ORIGEN || '.SMSTREETsection@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid
            AND sh.logidto = 0
            AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (ch.id_calle_seg)
            FROM ' || P_DESTINO || '.CALLE_SEG ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND CH.ID_INC_HASTA = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT29B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT29B
            FROM (SELECT DISTINCT (SH.objectnameid)
            FROM ' || P_ORIGEN || '.SMBLOCKS@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid
            AND sh.logidto = 0
            AND l.eventstatus = 0
            and sh.sprid = 311
            MINUS
            SELECT DISTINCT (ch.id_manzana)
            FROM ' || P_DESTINO || '.MANZANA ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND CH.ID_INC_HASTA = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT30B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT30B
            FROM (SELECT DISTINCT (ch.id_usuario)
            FROM ' || P_DESTINO || '.USUARIO ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND CH.ID_INC_HASTA = 0
            MINUS
            SELECT DISTINCT (SH.userid)
            FROM ' || P_ORIGEN || '.USERS_H@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid
            AND sh.logidto = 0
            AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT31B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT31B
            FROM (SELECT DISTINCT (ch.id_vereda)
            FROM ' || P_DESTINO || '.VEREDA ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND CH.ID_INC_HASTA = 0
            MINUS
            SELECT DISTINCT (SH.blockfacadeid)
            FROM ' || P_ORIGEN || '.smblockfacades_h@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l, ' || P_ORIGEN || '.smblocks@' || P_DBLINK_ORI || ' b
            WHERE b.logidfrom = l.logid
            AND l.eventstatus = 0
            and b.sprid = 311
            AND b.blockid = sh.blockid
            AND b.logidto = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT32B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT32B
            FROM (SELECT DISTINCT (ADH.ID_ATR)
            FROM ' || P_DESTINO || '.ATR_DEF adh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ADH.ID_INC_HASTA = 0
            AND ADH.ID_INC_HASTA = l.logid
            AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (lh.linkid)
            FROM ' || P_ORIGEN || '.links_h@' || P_DBLINK_ORI || ' lh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE lh.logidto = 0
            AND lh.logidfrom = l.logid
            AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT33B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT33B
            FROM (SELECT DISTINCT (rh.id_red)
            FROM ' || P_DESTINO || '.RED rh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE RH.ID_INC_DESDE = l.logid
            AND RH.ID_INC_HASTA = 0
            AND L.EVENTSTATUS = 0
            MINUS
            SELECT DISTINCT (nettypeid)
            FROM ' || P_ORIGEN || '.nettypes_h@' || P_DBLINK_ORI || ' nh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE NH.LOGIDFROM = l.logid
            AND nh.logidto = 0
            AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT34B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT34B
            FROM (SELECT DISTINCT (rh.id_cat)
            FROM ' || P_DESTINO || '.CATEGORIA_H rh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE RH.ID_INC_DESDE = l.logid
            AND RH.ID_INC_HASTA = 0
            AND L.EVENTSTATUS = 0
            MINUS
            SELECT DISTINCT (nh.categid)
            FROM ' || P_ORIGEN || '.categories_h@' || P_DBLINK_ORI || ' nh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE NH.LOGIDFROM = l.logid
            AND nh.logidto = 0
            AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT35B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT35B
            FROM (SELECT DISTINCT (rh.id_clase)
            FROM ' || P_DESTINO || '.CLASE rh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE RH.ID_INC_DESDE = l.logid
            AND RH.ID_INC_HASTA = 0
            AND L.EVENTSTATUS = 0
            MINUS
            SELECT DISTINCT (nh.sprid)
            FROM ' || P_ORIGEN || '.sprentities_h@' || P_DBLINK_ORI || ' nh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE NH.LOGIDFROM = l.logid
            AND nh.logidto = 0
            AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT36B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT36B
            FROM (SELECT DISTINCT (mah.id_extra)
            FROM ' || P_DESTINO || '.MANZANA_ATR_H mah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE MAH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND MAH.ID_INC_HASTA = 0
            MINUS
            SELECT DISTINCT (l.objectid)
            FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' l,
            ' || P_ORIGEN || '.smblocks@' || P_DBLINK_ORI || ' b,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l2,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l3
            WHERE l.objectid = b.blockid
            AND b.logidto = 0
            AND l.logidto = 0
            AND b.sprid = 311
            AND b.logidfrom = l2.logid
            AND l2.eventstatus = 0
            AND L.LOGIDFROM = l3.logid
            AND l3.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT37B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT37B
            FROM (SELECT DISTINCT (mah.id_extra)
            FROM ' || P_DESTINO || '.CALLE_ATR_H mah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE MAH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND MAH.ID_INC_HASTA = 0
            MINUS
            SELECT DISTINCT (l.objectid)
            FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' l,
            ' || P_ORIGEN || '.smstreetsection@' || P_DBLINK_ORI || ' b,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l2,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l3
            WHERE l.objectid = b.streetsectionid
            AND b.logidto = 0
            AND l.logidto = 0
            AND b.logidfrom = l2.logid
            AND l2.eventstatus = 0
            AND L.LOGIDFROM = l3.logid
            AND l3.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT38B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT38B
            FROM (SELECT DISTINCT (vah.id_vereda)
            FROM ' || P_DESTINO || '.VEREDA_ATR_H vah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE vah.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND vah.ID_INC_HASTA = 0
            MINUS
            SELECT DISTINCT (l.objectid)
            FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' l,
            ' || P_ORIGEN || '.smblockfacades@' || P_DBLINK_ORI || ' b,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' lo,
            ' || P_ORIGEN || '.smblocks@' || P_DBLINK_ORI || ' bl,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' lo2
            WHERE l.objectid = b.blockfacadeid
            AND l.logidto = 0
            AND l.logidfrom = lo.logid
            AND lo.eventstatus = 0
            and bl.sprid = 311
            AND B.BLOCKID = bl.blockid
            AND bl.logidto = 0
            AND bl.logidfrom = lo2.logid
            AND lo2.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT39B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT39B
            FROM (SELECT DISTINCT (eh.id_ele)
            FROM ' || P_DESTINO || '.ELEMENTO_H eh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE EH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND EH.ID_INC_HASTA = 0
            MINUS
            SELECT DISTINCT (ob.objectnameid)
            FROM ' || P_ORIGEN || '.sprobjects@' || P_DBLINK_ORI || ' ob, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ob.logidfrom = l.logid
            AND l.eventstatus = 0
            AND ob.logidto = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT40B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT40B
            FROM (SELECT DISTINCT (eh.id_ele)
            FROM ' || P_DESTINO || '.ELEM_GEO_H eh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE EH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND EH.ID_INC_HASTA = 0
            MINUS
            SELECT DISTINCT (ob.objectnameid)
            FROM ' || P_ORIGEN || '.sprobjects@' || P_DBLINK_ORI || ' ob, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ob.logidfrom = l.logid
            AND l.eventstatus = 0
            AND ob.logidto = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT41B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT41B
            FROM (SELECT *
            FROM ' || P_ORIGEN || '.sprtopology@' || P_DBLINK_ORI || ' t1
            WHERE logidto = 0
            AND NOT EXISTS
            (SELECT (1)
            FROM ' || P_ORIGEN || '.sprtopology@' || P_DBLINK_ORI || ' t2
            WHERE t2.objectidfrom = t1.objectidto
            AND t1.objectidfrom = t2.objectidto
            AND t1.nodeindexfrom = t2.nodeindexto
            AND t2.nodeindexfrom = t1.nodeindexto
            AND T1.LOGIDFROM = t2.logidfrom
            AND t1.logidto = t2.logidto))';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT42B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT42B
            FROM (SELECT DISTINCT (eh.id_ele)
            FROM ' || P_DESTINO || '.ELEM_ATR_H eh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE EH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND EH.ID_INC_HASTA = 0
            MINUS
            SELECT DISTINCT (ob.objectnameid)
            FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' li, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l, ' || P_ORIGEN || '.sprobjects@' || P_DBLINK_ORI || ' ob
            WHERE li.logidfrom = l.logid
            AND l.eventstatus = 0
            AND li.logidto = 0
            AND li.objectid = ob.objectid
            AND ob.logidto = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT43B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT43B
            FROM (SELECT AREANAME, ID_INC_DESDE, ID_INC_HASTA FROM ' || P_DESTINO || '.DATOSTECNICOS
            MINUS
            SELECT AREANAME, LOGIDFROM, LOGIDTO FROM ' || P_ORIGEN || '.GIS_DET_AREA_H@' || P_DBLINK_ORI || ')';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT44B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT44B
            FROM (SELECT AREANAME, ID_INC_DESDE, ID_INC_HASTA
            FROM ' || P_DESTINO || '.DATOSTECNICOS
            WHERE ID_INC_HASTA = 0
            MINUS
            SELECT AREANAME, LOGIDFROM, LOGIDTO
            FROM ' || P_ORIGEN || '.GIS_DET_AREA_H@' || P_DBLINK_ORI || '
            WHERE LOGIDTO = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIP45B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT45B
            FROM (SELECT HUB, ID_INC_DESDE, ID_INC_HASTA FROM ' || P_DESTINO || '.GIS_DET_HUB
            MINUS
            SELECT HUB, LOGIDFROM, LOGIDTO FROM ' || P_ORIGEN || '.GIS_DET_HUB_H@' || P_DBLINK_ORI || ')';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT46B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT46B
            FROM (SELECT HUB, ID_INC_DESDE, ID_INC_HASTA
            FROM ' || P_DESTINO || '.GIS_DET_HUB
            WHERE ID_INC_HASTA = 0
            MINUS
            SELECT HUB, LOGIDFROM, LOGIDTO
            FROM ' || P_ORIGEN || '.GIS_DET_HUB_H@' || P_DBLINK_ORI || '
            WHERE LOGIDTO = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT47B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT47B
            FROM (SELECT SITIO_ID, ID_INC_DESDE, ID_INC_HASTA
            FROM ' || P_DESTINO || '.GIS_DET_SITIOS
            MINUS
            SELECT ID, LOGIDFROM, LOGIDTO FROM ' || P_ORIGEN || '.GIS_DET_SITIOS_H@' || P_DBLINK_ORI || ')';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT48B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT48B
            FROM (SELECT SITIO_ID, ID_INC_DESDE, ID_INC_HASTA
            FROM ' || P_DESTINO || '.GIS_DET_SITIOS
            WHERE ID_INC_HASTA = 0
            MINUS
            SELECT ID, LOGIDFROM, LOGIDTO
            FROM ' || P_ORIGEN || '.GIS_DET_SITIOS_H@' || P_DBLINK_ORI || '
            WHERE LOGIDTO = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT49B' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT49B
            FROM (SELECT ID FROM ' || P_DESTINO || '.VERSION
            MINUS
            SELECT LOGID
            FROM ' || P_ORIGEN || '.SPRLOG@' || P_DBLINK_ORI || '
            WHERE EVENTTYPE IN (32, 33) AND EVENTSTATUS = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        MU_DATA(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END MU_INCONS_B;
