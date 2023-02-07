Create Proc [dbo].[sp_Work_UserGetWW]
@sDay varchar(10) ='',
@eDay varchar(10) ='', 
@UserId	varchar(20)=''
As
SELECT 
DATEPART(ww, AttenDay) AS WW -- 주별 
--,DATEPART(mm, AttenDay) AS MM -- 월별 
	from tb_Work
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
and UserId =@UserId
group by DATEPART(ww, AttenDay) 
ORDER BY DATEPART(ww, AttenDay) Asc --,UserId Asc
