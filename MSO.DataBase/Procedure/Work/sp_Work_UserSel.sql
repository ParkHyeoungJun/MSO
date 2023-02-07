Create Proc [dbo].[sp_Work_UserSel]
	@sDay varchar(10) ='',
	@eDay varchar(10) ='',
	@UserId	Varchar(20) =''
AS
	Select * from 
(
	SELECT 
	0 as itype
	,ROW_NUMBER() OVER(ORDER BY DATEPART(ww, AttenDay) Asc ,w.UserId Asc) AS rownum
,w.* 
,CASE WHEN(DATEPART(WEEKDAY,AttenDay) = '1') THEN '(일)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '2') THEN '(월)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '3') THEN '(화)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '4') THEN '(수)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '5') THEN '(목)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '6') THEN '(금)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '7') THEN '(토)' END AS DATENA
,DATEPART(ww, AttenDay) AS WW -- 주별 
,DATEPART(mm, AttenDay) AS MM -- 월별 
,DATEPART(YY, AttenDay) AS YY -- 월별 
,u.UserName
,u.Email
	from tb_Work w
	left join Tb_User u
	on w.UserId = u.UserId
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
and w.UserId=@UserId

union all 
SELECT 
1 as itype
,0 AS rownum
,null Num
,'주간 합계' as UserId
,'' AttenDay
,'' AttenTime
,'' LeaveTime
,sum(CONVERT(int ,Overtime)) as Overtime
,sum(CONVERT(int ,WorkOvertime)) as WorkOvertime
,sum(CONVERT(int ,WoorkTime)) as WoorkTime
,getdate() as  Regdate
,getdate() as Moddate

,'' AS DATENA
,DATEPART(ww, AttenDay) AS WW -- 주별 
,'' AS MM -- 월별 
,'' AS YY -- 월별 
,'주간 합계' UserName
,'' Email
	from tb_Work w
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
and w.UserId=@UserId
group by w.UserId, DATEPART(ww, AttenDay)

union all

SELECT 
9 as itype
,0 AS rownum
,null Num
,'월간 합계' as UserId
,'' AttenDay
,'' AttenTime
,'' LeaveTime
,sum(CONVERT(int ,Overtime)) as Overtime
,sum(CONVERT(int ,WorkOvertime)) as WorkOvertime
,sum(CONVERT(int ,WoorkTime)) as WoorkTime
,getdate() as  Regdate
,getdate() as Moddate

,'' AS DATENA
,9999 AS WW -- 주별 
,'' AS MM -- 월별 
,'' AS YY -- 월별 
,'월간 합계' UserName
,'' Email
	from tb_Work w
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
and w.UserId=@UserId
group by w.UserId, DATEPART(MM, AttenDay)

)tab

ORDER BY  WW,itype--, Regdate Asc,itype desc 
Go