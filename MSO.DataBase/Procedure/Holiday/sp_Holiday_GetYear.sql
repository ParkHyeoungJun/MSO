Create Proc sp_Holiday_GetYear
	@yyyy varchar(4) =''
As
SELECT 
Num
,CASE WHEN YN =1 THEN 'Y' ELSE 'N' END YN
,Title
,HoliDay
,RegDate
,ModDate
	FROM [Tb_Holiday] Where 
	HoliDay between @yyyy+'-01-01'
	and DATEADD(DAY,-1, DATEADD(MONTH,1,@yyyy+'-12-31'))
order by HoliDay asc 
Go