CREATE PROCEDURE [dbo].[sp_Work_Sel]
	@sDay varchar(10) ='',
	@eDay varchar(10) =''
AS
	SELECT 
	ROW_NUMBER() OVER(ORDER BY DATEPART(ww, AttenDay) Asc ,UserId Asc) AS rownum
,* 
,CASE WHEN(DATEPART(WEEKDAY,AttenDay) = '1') THEN '(일)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '2') THEN '(월)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '3') THEN '(화)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '4') THEN '(수)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '5') THEN '(목)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '6') THEN '(금)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '7') THEN '(토)' END AS DATENA
,DATEPART(ww, AttenDay) AS WW -- 주별 
,DATEPART(mm, AttenDay) AS MM -- 월별 
	from tb_Work
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
ORDER BY DATEPART(ww, AttenDay) Asc ,UserId Asc
GO