Create Proc [dbo].[sp_Work_UserGetMM]
@sDay varchar(10) ='',
@eDay varchar(10) ='',
@UserId	varchar(20)=''
As
SELECT 
DATEPART(MM, AttenDay) AS MM -- 월별 
--,DATEPART(mm, AttenDay) AS MM -- 월별 
	from tb_Work
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
and UserId =@UserId
group by DATEPART(MM, AttenDay) 
ORDER BY DATEPART(MM, AttenDay) Asc --,UserId Asc
Go