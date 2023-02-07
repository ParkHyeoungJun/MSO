/*
	sp_Work_GetWW '2022-01-01','2022-05-1'
	주별 합계 위한 쿼리
*/
Create Proc sp_Work_GetWW
@sDay varchar(10) ='',
@eDay varchar(10) =''
As
SELECT 
DATEPART(ww, AttenDay) AS WW -- 주별 
--,DATEPART(mm, AttenDay) AS MM -- 월별 
	from tb_Work
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
group by DATEPART(ww, AttenDay) 
ORDER BY DATEPART(ww, AttenDay) Asc --,UserId Asc
Go