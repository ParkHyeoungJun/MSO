/* 경영 계획기존 데이터가 있다면*/




CREATE  PROCEDURE [dbo].[sp_ManagementSub_Sel]
	@YYYY Char(4) ='',
	@Servion int =1
AS
select *

from (

 

        Select

        0 as itype,

        ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum,

        a.Idx,

        isnull(b.Num,0) as Num   ,

        a.UserId,

        RTRIM(c.VDESC) as UserName,

        a.CusttomerCode ,

        a.CusttomerName ,

        b.servion              ,      

        b.p1                   ,

        b.r1                   ,

        b.p2                   ,

        b.r2                   ,

        b.p3                   ,

        b.r3                   ,

        (p1+p2+p3) as q1p      ,

        (r1+r2+r3) as q1r      ,

        b.p4                   ,

        b.r4                   ,

        b.p5                   ,

        b.r5                   ,

        b.p6                   ,

        b.r6                   ,

        (p4+p5+p6) q2p                  ,

        (r4+r5+r6) q2r                  ,

        (p1+p2+p3+p4+p5+p6) as s1p                  ,

        (r1+r2+r3+r4+r5+r6) as s1r                  ,

        b.p7                   ,

        b.r7                   ,

        b.p8                   ,

        b.r8                   ,

        b.p9                   ,

        b.r9                   ,

        (p7+p8+p9) as q3p                  ,

        (r7+r8+r9) as q3r                  ,

        b.p10                  ,

        b.r10                  ,

        b.p11                  ,

        b.r11                  ,

        b.p12                  ,

        b.r12                  ,

        (p10+p11+p12) as q4p                  ,

        (r10+r11+r12) as q4r                  ,

        (p7+p8+p9+p10+p11+p12)as s2p                  ,

        (r7+r8+r9+r10+r11+r12) s2r                  ,

        (p1+p2+p3+p4+p5+p6+p7+p8+p9+p10+p11+p12) as yp                   ,

        (r1+r2+r3+r4+r5+r6+r7+r8+r9+r10+r11+r12) as yr                   ,

        b.raw                  ,

        b.ass                  ,
		
		--b.plp                  ,
        round((p1+p2+p3+p4+p5+p6+p7+p8+p9+p10+p11+p12) * ((100 - (b.raw + b.ass)) / 100), 0) as plp,

        --b.plr                  ,
		round((r1+r2+r3+r4+r5+r6+r7+r8+r9+r10+r11+r12) * ((100 - (b.raw + b.ass)) / 100), 0) as plr,

        --b.rusult
		0 as rusult

        from tb_ManagementMaster a left join tb_ManagementSub b

        on a.Idx=b.Idx

        left join  CSOPTFD c  on a.UserId=RTRIM(c.VALUE)

        Where a.YYYY =@YYYY

        and b.servion = @Servion

        and a.CusttomerName <> 'Sub Total:'
        and  OPTFIELD = 'EMPL'

        union all

 

        Select

        1 as itype,

        1 AS rownum,

        0 as Idx,

        0 as Num ,

        a.UserId,

        '' as UserName,

        '' CusttomerCode ,

        'Sub Total:' as CusttomerName    ,

        b.servion              ,      

        sum(b.p1) as p1                 ,

        sum(b.r1) as r1                 ,

        sum(b.p2) as p2                 ,

        sum(b.r2) as r2                 ,

        sum(b.p3) as p3                 ,

        sum(b.r3) as r3                 ,

        sum(b.q1p) as q1p                      ,

        sum(b.q1r) as q1r                      ,

        sum(b.p4) as p4                 ,

        sum(b.r4) as r4                 ,

        sum(b.p5) as p5                 ,

        sum(b.r5) as r5                 ,

        sum(b.p6) as p6                 ,

        sum(b.r6) as r6                 ,

        sum(b.q2p) as q2p                      ,

        sum(b.q2r) as q2r                      ,

        sum(b.s1p) as s1p                      ,

        sum(b.s1r) as s1r                      ,

        sum(b.p7) as p7                 ,

        sum(b.r7) as r7                 ,

        sum(b.p8) as p8                 ,

        sum(b.r8) as r8                 ,

        sum(b.p9) as p9                 ,

        sum(b.r9) as r9                 ,

        sum(b.q3p) as q3p                      ,

        sum(b.q3r) as q3r                      ,

        sum(b.p10) as p10                      ,

        sum(b.r10) as r10                      ,

        sum(b.p11) as p11                      ,

        sum(b.r11) as r11                      ,

        sum(b.p12) as p12                      ,

        sum(b.r12) as r12                      ,

        sum(b.q4p) as q4p                      ,

        sum(b.q4r) as q4r                      ,

        sum(b.s2p) as s2p                      ,

        sum(b.s2r) as s2r                      ,

        sum(b.yp) as yp                 ,

        sum(b.yr) as yr                 ,

		0 as raw                      ,

		0 as ass                      ,

        sum(b.plp) as plp                      ,

        sum(b.plr) as plr                      ,

        --sum(b.rusult) as result
		case when sum(b.plp) = 0 then 0 else round((sum(b.plr) / sum(b.plp)) * 100, 0) end as result

        from tb_ManagementMaster a left join tb_ManagementSub b

        on a.Idx=b.Idx

        left join  CSOPTFD c  on a.UserId=RTRIM(c.VALUE)

        Where a.YYYY =@YYYY

        and b.servion = @Servion

        and  OPTFIELD = 'EMPL'

        and a.CusttomerName <> 'Sub Total:'

        group by a.UserId, RTRIM(c.VDESC), b.servion    

 

 

        union all

 

        Select

        9 as itype,

        1 AS rownum,

        0 as Idx,

        0 as Num ,

        'ZZZ' as UserId,

        '' as UserName,

        '' CusttomerCode ,

        'Total:' as CusttomerName ,

        b.servion              ,      

        sum(b.p1) as p1                 ,

        sum(b.r1) as r1                 ,

        sum(b.p2) as p2                 ,

        sum(b.r2) as r2                 ,

        sum(b.p3) as p3                 ,

        sum(b.r3) as r3                 ,

        sum(b.q1p) as q1p                      ,

        sum(b.q1r) as q1r                      ,

        sum(b.p4) as p4                 ,

        sum(b.r4) as r4                 ,

        sum(b.p5) as p5                 ,

        sum(b.r5) as r5                 ,

        sum(b.p6) as p6                 ,

        sum(b.r6) as r6                 ,

        sum(b.q2p) as q2p                      ,

        sum(b.q2r) as q2r                      ,

        sum(b.s1p) as s1p                      ,

        sum(b.s1r) as s1r                      ,

        sum(b.p7) as p7                 ,

        sum(b.r7) as r7                 ,

        sum(b.p8) as p8                 ,

        sum(b.r8) as r8                 ,

        sum(b.p9) as p9                 ,

        sum(b.r9) as r9                 ,

        sum(b.q3p) as q3p                      ,

        sum(b.q3r) as q3r                      ,

        sum(b.p10) as p10                      ,

        sum(b.r10) as r10                      ,

        sum(b.p11) as p11                      ,

        sum(b.r11) as r11                      ,

        sum(b.p12) as p12                      ,

        sum(b.r12) as r12                      ,

        sum(b.q4p) as q4p                      ,

        sum(b.q4r) as q4r                      ,

        sum(b.s2p) as s2p                      ,

        sum(b.s2r) as s2r                      ,

        sum(b.yp) as yp                 ,

        sum(b.yr) as yr                 ,

        0 as raw                      ,

        0 as ass                      ,

        sum(b.plp) as plp                      ,

        sum(b.plr) as plr                      ,

        0 as result

        from tb_ManagementMaster a left join tb_ManagementSub b

        on a.Idx=b.Idx

        left join  CSOPTFD c  on a.UserId=RTRIM(c.VALUE)

        Where a.YYYY =@YYYY

        and b.servion = @Servion

        and  OPTFIELD = 'EMPL'

        and a.CusttomerName <> 'Sub Total:'

        group by b.servion     

 

) a

order by UserId, itype, CusttomerCode Asc