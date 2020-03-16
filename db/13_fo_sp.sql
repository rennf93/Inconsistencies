create or replace PROCEDURE FO_INCONS
AS

result number;
exec_begin DATE;
exec_end DATE;

    CURSOR INCO IS
        select * from REPORTES_INCONSISTENCIAS where SUBGROUP='FO' order by REPORT_ID;

BEGIN

    FOR reg IN INCO
    LOOP
    if reg.REPORT_ID = 'INTERNO FO 1' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            select count(*) into result from sprobjects o
            where objectid in (
                select objectid from sprlinks l1
                where linkid = 243
                and logidto !=0
                and objectid in (
                    select objectid from sprlinks l2
                    where  linkid = 243
                    group by objectid
                    having count(*) =1 )
            )
            and logidto = 0;
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

    if reg.REPORT_ID = 'INTERNO FO 2' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            select count(*) into result
                from    sprlinks sl,
                        sprobjects ob
                where   sl.linkid = 243
                and     sl.logidto = 0
                and     ob.objectid = sl.objectid
                and     ob.logidto = 0
                and     ob.sprid in (99,139,150,151,152,153,154,192)
                --and     ob.projectid =0
                and     ob.sprid = ob.sprid
                and     sl.linkvalue not in (select objectnameid from sprobjects where logidto = 0);
        END;

        BEGIN
            select SYSDATE into exec_END from dual;
        END;
    end if;

    if reg.REPORT_ID = 'INTERNO FO 3' and reg.REPORT_ENABLED = 1 then
        BEGIN
            select SYSDATE into exec_BEGIN from dual;
        END;

        BEGIN
            select count(*) into result from
               ( select qq.*,
               (select /*+ INDEX (l1 SPRLINKS_LNK) */ /*+ INDEX (o1 SPROBJ_SPRID_IDTO) */ count(1) from sprlinks l1, sprobjects o1 where l1.linkid = 243 and l1.linkvalue = rpad( to_char(qq.objectnameid) , 30, ' ') and l1.logidto = 0 and l1.objectid = o1.objectid and o1.sprid = 153 and o1.logidto = 0 )AS pelos ,
               (select /*+ INDEX (l1 SPRLINKS_LNK) */ /*+ INDEX (o1 SPROBJ_SPRID_IDTO) */ count(1) from sprlinks l1, sprobjects o1 where l1.linkid = 243 and l1.linkvalue = rpad( to_char(qq.objectnameid) , 30, ' ') and l1.logidto = 0 and l1.objectid = o1.objectid and o1.sprid = 154 and o1.logidto = 0 )AS tubos
            from  ( select /*+ INDEX (o SPROBJ_SPRID_IDTO) */ /*+ INDEX (l SPRLNKS_LNK_IDTO) */
                         o.objectid AS cable,
                         o.projectid,
                         o.objectnameid AS objectnameid,
                         o.datefrom,
                         TO_NUMBER (REGEXP_SUBSTR (l.linkvalue, '(\d{1,})', 1, 1)) AS cpelos,
                         TO_NUMBER (REGEXP_SUBSTR (l.linkvalue, '(\d{1,})', 1, 2))AS ctubos
                       from sprobjects o, sprlinks l
                       where o.objectid = l.objectid
                         and sprid in (71, 76, 254) and o.logidto = 0
                         and l.linkid = 411 and l.logidto = 0
                       ) qq
                 ) sq left outer join  sprgprojects p on sq.projectid = p.projectid
            where ( cpelos  != pelos or ctubos != tubos );
        END;

        BEGIN
            select SYSDATE into exec_end from dual;
        END;
    end if;

        RESULT_REPORT(reg.REPORT_ID, reg.DESCRIPTION, RESULT, reg.REPORT_ENABLED, EXEC_BEGIN, EXEC_END, reg.EXPECTED);
    END LOOP;
    COMMIT;

END FO_INCONS;
/