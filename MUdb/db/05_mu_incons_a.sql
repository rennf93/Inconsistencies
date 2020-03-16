create or replace PROCEDURE MU_INCONS_A(P_ORIGEN VARCHAR, P_DESTINO VARCHAR, P_DBLINK_ORI VARCHAR)
AS

result number := 0;
exec_begin DATE := SYSDATE;
exec_end DATE := SYSDATE;
v_script VARCHAR2(2000);

    CURSOR INCO IS
        select * from MU_INCONSISTENCIAS WHERE CUSTOM_INDEX = 'A' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP

        if reg.REPORT_ID = 'SCRIPT1A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :=
            'SELECT COUNT (1) SCRIPT1A
            FROM (SELECT DISTINCT (ah.areaid)
            FROM ' || P_ORIGEN || '.amareas_h@' || P_DBLINK_ORI || ' ah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE AH.LOGIDFROM = l.LOGID AND l.EVENTSTATUS = 0
            MINUS
            SELECT id_area FROM ' || P_DESTINO || '.AREA_H)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT2A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT2A
            FROM (SELECT DISTINCT (aph.areaid)
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
            AND am.areaid = aph.areaid
            MINUS
            SELECT DISTINCT (gaph.id_area)
            FROM ' || P_DESTINO || '.area_pol_h gaph, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE GAPH.ID_INC_DESDE = l.logid AND L.EVENTSTATUS = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT3A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT3A
            FROM (SELECT DISTINCT (ath.areatypeid)
            FROM ' || P_ORIGEN || '.AMAREATYPES_H@' || P_DBLINK_ORI || ' ath, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ath.logidfrom = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (ath.id_tipo_area)
            FROM ' || P_DESTINO || '.AREA_TIPO_H ath, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ATH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT4A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT4A
            FROM (SELECT DISTINCT (streetid)
            FROM ' || P_ORIGEN || '.smstreets_h@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (id_calle)
            FROM ' || P_DESTINO || '.CALLE_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT5A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT5A
            FROM (SELECT DISTINCT (streetid)
            FROM ' || P_ORIGEN || '.smstreets_h@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (id_calle_nom)
            FROM ' || P_DESTINO || '.CALLE_NOMBRE_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT6A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT6A
            FROM (SELECT DISTINCT (streettypeid)
            FROM ' || P_ORIGEN || '.SMSTREETTYPES_H@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (ch.id_tipo_calle)
            FROM ' || P_DESTINO || '.CALLE_TIPO_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT7A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT7A
            FROM (SELECT DISTINCT (SH.OBJECTNAMEID)
            FROM ' || P_ORIGEN || '.SMSTREETsection@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (ch.id_calle_seg)
            FROM ' || P_DESTINO || '.CALLE_SEG_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT8A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT8A
            FROM (SELECT DISTINCT (SH.objectnameid)
            FROM ' || P_ORIGEN || '.SMBLOCKS@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid AND l.eventstatus = 0  and sh.sprid = 311
            MINUS
            SELECT DISTINCT (ch.id_manzana)
            FROM ' || P_DESTINO || '.MANZANA_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT9A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT9A
            FROM (SELECT DISTINCT (ch.id_usuario)
            FROM ' || P_DESTINO || '.USUARIO_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (SH.userid)
            FROM ' || P_ORIGEN || '.USERS_H@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT10A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT10A
            FROM (SELECT DISTINCT (SH.blockfacadeid)
            FROM ' || P_ORIGEN || '.smblockfacades@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l, ' || P_ORIGEN || '.smblocks@' || P_DBLINK_ORI || ' b
            WHERE b.logidfrom = l.logid
            AND l.eventstatus = 0
            and b.sprid = 311
            AND b.blockid = sh.blockid
            MINUS
            SELECT DISTINCT (ch.id_vereda)
            FROM ' || P_DESTINO || '.VEREDA_H ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT12A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT12A
            FROM (SELECT DISTINCT (lh.linkid)
            FROM ' || P_ORIGEN || '.links_h@' || P_DBLINK_ORI || ' lh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE lh.logidfrom = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (ADH.ID_ATR)
            FROM ' || P_DESTINO || '.ATR_DEF_H adh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ADH.ID_INC_HASTA = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT13A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT13A
            FROM (SELECT DISTINCT (nettypeid)
            FROM ' || P_ORIGEN || '.nettypes_h@' || P_DBLINK_ORI || ' nh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE NH.LOGIDFROM = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (rh.id_red)
            FROM ' || P_DESTINO || '.RED_H rh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE RH.ID_INC_DESDE = l.logid AND L.EVENTSTATUS = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT14A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT14A
            FROM (SELECT DISTINCT (nh.categid)
            FROM ' || P_ORIGEN || '.categories_h@' || P_DBLINK_ORI || ' nh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE NH.LOGIDFROM = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (rh.id_cat)
            FROM ' || P_DESTINO || '.CATEGORIA_H rh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE RH.ID_INC_DESDE = l.logid AND L.EVENTSTATUS = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT15A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT15A
            FROM (SELECT DISTINCT (nh.sprid)
            FROM ' || P_ORIGEN || '.sprentities_h@' || P_DBLINK_ORI || ' nh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE NH.LOGIDFROM = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (rh.id_clase)
            FROM ' || P_DESTINO || '.CLASE_H rh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE RH.ID_INC_DESDE = l.logid AND L.EVENTSTATUS = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT16A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT16A
            FROM (SELECT DISTINCT (b.objectnameid)
            FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' l,
            ' || P_ORIGEN || '.smblocks@' || P_DBLINK_ORI || ' b,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l2,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l3
            WHERE l.objectid = b.blockid
            AND b.sprid = 311
            AND b.logidfrom = l2.logid
            AND l2.eventstatus = 0
            AND L.LOGIDFROM = l3.logid
            AND l3.eventstatus = 0
            MINUS
            SELECT DISTINCT (mah.id_manzana)
            FROM ' || P_DESTINO || '.MANZANA_ATR_H mah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE MAH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT17A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT17A
            FROM (SELECT DISTINCT (l.objectid)
            FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' l,
            ' || P_ORIGEN || '.smstreetsection@' || P_DBLINK_ORI || ' b,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l2,
            ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l3
            WHERE l.objectid = b.objectnameid
            AND b.logidfrom = l2.logid
            AND l2.eventstatus = 0
            AND L.LOGIDFROM = l3.logid
            AND l3.eventstatus = 0
            MINUS
            SELECT DISTINCT (mah.id_calle)
            FROM ' || P_DESTINO || '.CALLE_ATR_H mah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE MAH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT18A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT18A
            FROM (SELECT DISTINCT (l.objectid)
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
            AND lo2.eventstatus = 0
            MINUS
            SELECT DISTINCT (vah.id_vereda)
            FROM ' || P_DESTINO || '.VEREDA_ATR_H vah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE vah.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT19A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT19A
            FROM (SELECT DISTINCT (ob.objectnameid)
            FROM ' || P_ORIGEN || '.sprobjects@' || P_DBLINK_ORI || ' ob, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ob.logidfrom = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (eh.id_ele)
            FROM ' || P_DESTINO || '.ELEMENTO_H eh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE EH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT20A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1)  SCRIPT20A
            FROM (SELECT DISTINCT (ob.objectnameid)
            FROM ' || P_ORIGEN || '.sprobjects@' || P_DBLINK_ORI || ' ob, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ob.logidfrom = l.logid AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (eh.id_ele)
            FROM ' || P_DESTINO || '.ELEM_GEO_H eh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE EH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT21A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT SUM (cc)  SCRIPT21A
            FROM (SELECT COUNT (*) cc
            FROM ' || P_ORIGEN || '.sprtopology@' || P_DBLINK_ORI || ' t1, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l1
            WHERE t1.logidfrom = l1.logid AND l1.eventstatus = 0
            UNION
            SELECT COUNT (*) * -1 cc FROM ' || P_DESTINO || '.TOPOLOGIA_H
            UNION
            SELECT COUNT (*) * -2 cc FROM ' || P_DESTINO || '.elem_rel_h)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT22A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT22A
            FROM (SELECT DISTINCT (ob.objectnameid)
            FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' li, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l, ' || P_ORIGEN || '.sprobjects@' || P_DBLINK_ORI || ' ob
            WHERE li.logidfrom = l.logid
            AND l.eventstatus = 0
            AND li.objectid = ob.objectid
            MINUS
            SELECT DISTINCT (eh.id_ele)
            FROM ' || P_DESTINO || '.ELEM_ATR_H eh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE EH.ID_INC_DESDE = l.logid AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT23A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT23A
            FROM (SELECT ID_AREA
              FROM ' || P_DESTINO || '.AREA
              WHERE ID_AREA > 0 AND ID_INC_HASTA = 0
              MINUS
              SELECT AREAID
              FROM ' || P_ORIGEN || '.AMAREAS_H@' || P_DBLINK_ORI || ' ah, ' || P_ORIGEN || '.SPRLOG@' || P_DBLINK_ORI || ' l
              WHERE ah.LOGIDTO = 0 AND l.LOGID=ah.LOGIDFROM AND l.EVENTSTATUS=0)';

              EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT24A_1' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT24A_1
            FROM (SELECT AREAID, POLYGONID
              FROM ' || P_ORIGEN || '.AMPOLYGONS_H@' || P_DBLINK_ORI || '
              WHERE LOGIDTO = 0
              MINUS
              SELECT ID_AREA, ID_EXTRA FROM ' || P_DESTINO || '.AREA_POL)';

              EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT24A_2' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT24A_2
            FROM (SELECT ID_AREA, ID_EXTRA FROM ' || P_DESTINO || '.AREA_POL
              MINUS
              SELECT AREAID, POLYGONID
              FROM ' || P_ORIGEN || '.AMPOLYGONS_H@' || P_DBLINK_ORI || '
              WHERE LOGIDTO = 0)';

              EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT25A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT25A
            FROM (SELECT DISTINCT (ath.areatypeid)
            FROM ' || P_ORIGEN || '.AMAREATYPES_H@' || P_DBLINK_ORI || ' ath, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ath.logidfrom = l.logid
            AND l.eventstatus = 0
            AND ath.logidto = 0
            MINUS
            SELECT DISTINCT (ath.id_tipo_area)
            FROM ' || P_DESTINO || '.AREA_TIPO ath, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE ATH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND ATH.ID_INC_HASTA = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT26A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT26A
            FROM (SELECT ID_CALLE_NOM
              FROM ' || P_DESTINO || '.CALLE_NOMBRE
              WHERE ID_INC_HASTA = 0
              MINUS
              SELECT STREETID
              FROM ' || P_ORIGEN || '.SMSTREETS_H@' || P_DBLINK_ORI || '
              WHERE LOGIDTO = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT27A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT27A
            FROM (SELECT DISTINCT (streettypeid)
            FROM ' || P_ORIGEN || '.SMSTREETTYPES_H@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid
            AND sh.logidto = 0
            AND l.eventstatus = 0
            MINUS
            SELECT DISTINCT (ch.id_tipo_calle)
            FROM ' || P_DESTINO || '.CALLE_TIPO ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND CH.ID_INC_HASTA = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT28A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT28A
            FROM (SELECT DISTINCT (ch.id_calle_seg)
            FROM ' || P_DESTINO || '.CALLE_SEG ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND CH.ID_INC_HASTA = 0
            MINUS
            SELECT DISTINCT (SH.OBJECTNAMEID)
            FROM ' || P_ORIGEN || '.SMSTREETsection@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid
            AND sh.logidto = 0
            AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT29A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT29A
            FROM (SELECT DISTINCT (ch.id_manzana)
            FROM ' || P_DESTINO || '.MANZANA ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE CH.ID_INC_DESDE = l.logid
            AND l.eventstatus = 0
            AND CH.ID_INC_HASTA = 0
            MINUS
            SELECT DISTINCT (SH.objectnameid)
            FROM ' || P_ORIGEN || '.SMBLOCKS@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
            WHERE sh.logidfrom = l.logid
            AND sh.logidto = 0
            and sh.sprid = 311
            AND l.eventstatus = 0)';

            EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT30A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT30A
             FROM (SELECT DISTINCT (SH.userid)
             FROM ' || P_ORIGEN || '.USERS_H@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE sh.logidfrom = l.logid
             AND sh.logidto = 0
             AND l.eventstatus = 0
             MINUS
             SELECT DISTINCT (ch.id_usuario)
             FROM ' || P_DESTINO || '.USUARIO ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE CH.ID_INC_DESDE = l.logid
             AND l.eventstatus = 0
             AND CH.ID_INC_HASTA = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT31A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT31A
             FROM (SELECT DISTINCT (SH.blockfacadeid)
             FROM ' || P_ORIGEN || '.smblockfacades@' || P_DBLINK_ORI || ' sh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l, ' || P_ORIGEN || '.smblocks@' || P_DBLINK_ORI || ' b
             WHERE b.logidfrom = l.logid
             AND l.eventstatus = 0
             AND b.blockid = sh.blockid
             and b.sprid = 311
             AND b.logidto = 0
             MINUS
             SELECT DISTINCT (ch.id_vereda)
             FROM ' || P_DESTINO || '.VEREDA ch, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE CH.ID_INC_DESDE = l.logid
             AND l.eventstatus = 0
             AND CH.ID_INC_HASTA = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT32A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT32A
             FROM (SELECT DISTINCT (lh.linkid)
             FROM ' || P_ORIGEN || '.links_h@' || P_DBLINK_ORI || ' lh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE lh.logidto = 0
             AND lh.logidfrom = l.logid
             AND l.eventstatus = 0
             MINUS
             SELECT DISTINCT (ADH.ID_ATR)
             FROM ' || P_DESTINO || '.ATR_DEF adh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE ADH.ID_INC_HASTA = 0
             AND ADH.ID_INC_HASTA = l.logid
             AND l.eventstatus = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT33A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT33A
             FROM (SELECT DISTINCT (nettypeid)
             FROM ' || P_ORIGEN || '.nettypes_h@' || P_DBLINK_ORI || ' nh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE NH.LOGIDFROM = l.logid
             AND nh.logidto = 0
             AND l.eventstatus = 0
             MINUS
             SELECT DISTINCT (rh.id_red)
             FROM ' || P_DESTINO || '.RED rh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE RH.ID_INC_DESDE = l.logid
             AND RH.ID_INC_HASTA = 0
             AND L.EVENTSTATUS = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT34A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT34A
             FROM (SELECT DISTINCT (nh.categid)
             FROM ' || P_ORIGEN || '.categories_h@' || P_DBLINK_ORI || ' nh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE NH.LOGIDFROM = l.logid
             AND nh.logidto = 0
             AND l.eventstatus = 0
             MINUS
             SELECT DISTINCT (rh.id_cat)
             FROM ' || P_DESTINO || '.CATEGORIA_H rh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE RH.ID_INC_DESDE = l.logid
             AND RH.ID_INC_HASTA = 0
             AND L.EVENTSTATUS = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT35A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT35A
             FROM (SELECT DISTINCT (nh.sprid)
             FROM ' || P_ORIGEN || '.sprentities_h@' || P_DBLINK_ORI || ' nh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE NH.LOGIDFROM = l.logid
             AND nh.logidto = 0
             AND l.eventstatus = 0
             MINUS
             SELECT DISTINCT (rh.id_clase)
             FROM ' || P_DESTINO || '.CLASE rh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE RH.ID_INC_DESDE = l.logid
             AND RH.ID_INC_HASTA = 0
             AND L.EVENTSTATUS = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT36A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT36A
             FROM (SELECT DISTINCT (l.objectid)
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
             AND l3.eventstatus = 0
             MINUS
             SELECT DISTINCT (mah.id_extra)
             FROM ' || P_DESTINO || '.MANZANA_ATR_H mah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE MAH.ID_INC_DESDE = l.logid
             AND l.eventstatus = 0
             AND MAH.ID_INC_HASTA = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT37A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT37A
             FROM (SELECT DISTINCT (l.objectid)
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
             AND l3.eventstatus = 0
             MINUS
             SELECT DISTINCT (mah.id_extra)
             FROM ' || P_DESTINO || '.CALLE_ATR_H mah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE MAH.ID_INC_DESDE = l.logid
             AND l.eventstatus = 0
             AND MAH.ID_INC_HASTA = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT38A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT38A
             FROM (SELECT DISTINCT (l.objectid)
             FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' l,
             ' || P_ORIGEN || '.smblockfacades@' || P_DBLINK_ORI || ' b,
             ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' lo,
             ' || P_ORIGEN || '.smblocks@' || P_DBLINK_ORI || ' bl,
             ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' lo2
             WHERE l.objectid = b.blockfacadeid
             AND l.logidto = 0
             AND l.logidfrom = lo.logid
             AND lo.eventstatus = 0
             AND B.BLOCKID = bl.blockid
             and bl.sprid = 311
             AND bl.logidto = 0
             AND bl.logidfrom = lo2.logid
             AND lo2.eventstatus = 0
             MINUS
             SELECT DISTINCT (vah.id_vereda)
             FROM ' || P_DESTINO || '.VEREDA_ATR_H vah, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE vah.ID_INC_DESDE = l.logid
             AND l.eventstatus = 0
             AND vah.ID_INC_HASTA = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT39A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT39A
             FROM (SELECT DISTINCT (ob.objectnameid)
             FROM ' || P_ORIGEN || '.sprobjects@' || P_DBLINK_ORI || ' ob, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE ob.logidfrom = l.logid
             AND l.eventstatus = 0
             AND ob.logidto = 0
             MINUS
             SELECT DISTINCT (eh.id_ele)
             FROM ' || P_DESTINO || '.ELEMENTO_H eh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE EH.ID_INC_DESDE = l.logid
             AND l.eventstatus = 0
             AND EH.ID_INC_HASTA = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT40A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT40A
             FROM (SELECT DISTINCT (ob.objectnameid)
             FROM ' || P_ORIGEN || '.sprobjects@' || P_DBLINK_ORI || ' ob, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE ob.logidfrom = l.logid
             AND l.eventstatus = 0
             AND ob.logidto = 0
             MINUS
             SELECT DISTINCT (eh.id_ele)
             FROM ' || P_DESTINO || '.ELEM_GEO_H eh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE EH.ID_INC_DESDE = l.logid
             AND l.eventstatus = 0
             AND EH.ID_INC_HASTA = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT41A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT SUM (cc) SCRIPT41A
             FROM (SELECT COUNT (*) cc
             FROM ' || P_ORIGEN || '.sprtopology@' || P_DBLINK_ORI || ' t1, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l1
             WHERE t1.logidto = 0
             AND t1.logidfrom = l1.logid
             AND l1.eventstatus = 0
             UNION
             SELECT COUNT (*) * -1 cc
             FROM ' || P_DESTINO || '.TOPOLOGIA_H
             WHERE id_inc_hasta = 0
             UNION
             SELECT COUNT (*) * -2 cc
             FROM ' || P_DESTINO || '.elem_rel_h
             WHERE id_inc_hasta = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT42A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT42A
             FROM (SELECT DISTINCT (ob.objectnameid)
             FROM ' || P_ORIGEN || '.sprlinks@' || P_DBLINK_ORI || ' li, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l, ' || P_ORIGEN || '.sprobjects@' || P_DBLINK_ORI || ' ob
             WHERE li.logidfrom = l.logid
             AND l.eventstatus = 0
             AND li.logidto = 0
             AND li.objectid = ob.objectid
             AND ob.logidto = 0
             MINUS
             SELECT DISTINCT (eh.id_ele)
             FROM ' || P_DESTINO || '.ELEM_ATR_H eh, ' || P_ORIGEN || '.sprlog@' || P_DBLINK_ORI || ' l
             WHERE EH.ID_INC_DESDE = l.logid
             AND l.eventstatus = 0
             AND EH.ID_INC_HASTA = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT43A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT43A
             FROM (SELECT AREANAME, LOGIDFROM, LOGIDTO FROM ' || P_ORIGEN || '.GIS_DET_AREA_H@' || P_DBLINK_ORI || '
             MINUS
             SELECT AREANAME, ID_INC_DESDE, ID_INC_HASTA FROM ' || P_DESTINO || '.DATOSTECNICOS)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT44A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN
            v_script :='
            SELECT COUNT (1) SCRIPT44A
             FROM (SELECT AREANAME, LOGIDFROM, LOGIDTO
             FROM ' || P_ORIGEN || '.GIS_DET_AREA_H@' || P_DBLINK_ORI || '
             WHERE LOGIDTO = 0
             MINUS
             SELECT AREANAME, ID_INC_DESDE, ID_INC_HASTA
             FROM ' || P_DESTINO || '.DATOSTECNICOS
             WHERE ID_INC_HASTA = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIP45A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT45A
             FROM (SELECT HUB, LOGIDFROM, LOGIDTO FROM ' || P_ORIGEN || '.GIS_DET_HUB_H@' || P_DBLINK_ORI || '
             MINUS
             SELECT HUB, ID_INC_DESDE, ID_INC_HASTA FROM ' || P_DESTINO || '.GIS_DET_HUB)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT46A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT46A
             FROM (SELECT HUB, LOGIDFROM, LOGIDTO
             FROM ' || P_ORIGEN || '.GIS_DET_HUB_H@' || P_DBLINK_ORI || '
             WHERE LOGIDTO = 0
             MINUS
             SELECT HUB, ID_INC_DESDE, ID_INC_HASTA
             FROM ' || P_DESTINO || '.GIS_DET_HUB
             WHERE ID_INC_HASTA = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT47A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT47A
             FROM (SELECT ID, LOGIDFROM, LOGIDTO FROM ' || P_ORIGEN || '.GIS_DET_SITIOS_H@' || P_DBLINK_ORI || '
             MINUS
             SELECT SITIO_ID, ID_INC_DESDE, ID_INC_HASTA
             FROM ' || P_DESTINO || '.GIS_DET_SITIOS)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT48A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT48A
             FROM (SELECT ID, LOGIDFROM, LOGIDTO
             FROM ' || P_ORIGEN || '.GIS_DET_SITIOS_H@' || P_DBLINK_ORI || '
             WHERE LOGIDTO = 0
             MINUS
             SELECT SITIO_ID, ID_INC_DESDE, ID_INC_HASTA
             FROM ' || P_DESTINO || '.GIS_DET_SITIOS
             WHERE ID_INC_HASTA = 0)';

             EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        if reg.REPORT_ID = 'SCRIPT49A' and reg.REPORT_ENABLED = 1 then
            BEGIN
                select SYSDATE into exec_BEGIN from dual;
            END;

            BEGIN

            v_script :='
            SELECT COUNT (1) SCRIPT49A
            FROM (SELECT LOGID
              FROM ' || P_ORIGEN || '.SPRLOG@' || P_DBLINK_ORI || '
              WHERE EVENTTYPE IN (32, 33) AND EVENTSTATUS = 0
              MINUS
              SELECT ID FROM ' || P_DESTINO || '.VERSION)';

              EXECUTE IMMEDIATE v_script INTO result;

            END;

            BEGIN
                select SYSDATE into exec_end from dual;
            END;
        end if;

        MU_DATA(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END MU_INCONS_A;
