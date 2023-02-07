/*
	 마스터 데이터 가지고 오는 화면 

*/
Create proc [dbo].[sp_Management_List]
	@YYYY char(4) =''	, 
	@servion int =1
As
Select
ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum,
a.Idx,
isnull(b.Num,0) as Num	,
a.UserId,
RTRIM(VDESC)	UserName
,a.CusttomerCode	,
a.CusttomerName	,
b.servion		,	
b.p1			,
b.r1			,
b.p2			,
b.r2			,
b.p3			,
b.r3			,
b.q1p			,
b.q1r			,
b.p4			,
b.r4			,
b.p5			,
b.r5			,
b.p6			,
b.r6			,
b.q2p			,
b.q2r			,
b.s1p			,
b.s1r			,
b.p7			,
b.r7			,
b.p8			,
b.r8			,
b.p9			,
b.r9			,
b.q3p			,
b.q3r			,
b.p10			,
b.r10			,
b.p11			,
b.r11			,
b.p12			,
b.r12			,
b.q4p			,
b.q4r			,
b.s2p			,
b.s2r			,
b.yp			,
b.yr			,
b.raw			,
b.ass			,
b.plp			,
b.plr			,
b.rusult
from tb_ManagementMaster a 
left join tb_ManagementSub b
on a.Idx=b.Idx
left join CSOPTFD  c on a.UserId= RTRIM(c.VALUE)
Where a.YYYY=@YYYY 
and isnull(b.servion,@servion) = @servion
and OPTFIELD = 'EMPL'
Go
