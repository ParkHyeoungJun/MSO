/*
사용자별 근태 화면 조회 sp

*/
Create Proc [dbo].[sp_Work_GroupSel]
@sDay varchar(10) ='',
@eDay varchar(10) =''
AS
Select UserId,UserName,YY,MM,Email
,(Select dbo.fun_GetWoorkTime(UserId,YY+'-'+MM+'-01')) as WoorkTime
,(Select dbo.fun_GetWorkOvertime(UserId,YY+'-'+MM+'-01')) as WorkOvertime
,(Select dbo.fun_GetOvertime(UserId,YY+'-'+MM+'-01')) as Overtime

from 
(
SELECT 
	distinct
	work.UserId
	,users.UserName
	,users.Email
	,SUBSTRING(CONVERT(CHAR(8), AttenDay,112),0,5) as YY
	,SUBSTRING(CONVERT(CHAR(8), AttenDay,112),6,2) as MM
from tb_Work work
join Tb_User users
on work.UserId= users.UserId
Where 
AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
group by users.UserName, work.UserId,work.AttenDay
,users.Email
)tab 