/*
	sp_Work_GetMM '2022-01-01','2022-05-1'
	월별 합계 위한 쿼리
*/
Create Proc sp_Work_GetMM
@sDay varchar(10) ='',
@eDay varchar(10) =''
As
SELECT 
DATEPART(MM, AttenDay) AS MM -- 월별 
--,DATEPART(mm, AttenDay) AS MM -- 월별 
	from tb_Work
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
group by DATEPART(MM, AttenDay) 
ORDER BY DATEPART(MM, AttenDay) Asc --,UserId Asc
Go