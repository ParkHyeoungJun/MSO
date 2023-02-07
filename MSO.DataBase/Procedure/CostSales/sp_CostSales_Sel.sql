CREATE PROCEDURE [dbo].[sp_CostSales_Sel]
	@sDay varchar(10) ='',
	@eDay varchar(10) =''
AS
Select 
ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum
,RTRIM(VDESC) CARRIERNAME
,A.* 
from tb_CostSales a
left join CSOPTFD b on a.CustCode= RTRIM(b.VALUE)
Where OPTFIELD = 'CARRIER'
and DateDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
Go
