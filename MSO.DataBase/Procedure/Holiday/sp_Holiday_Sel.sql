/****** SSMS의 SelectTopNRows 명령 스크립트 ******/
Create  Proc [dbo].[sp_Holiday_Sel]
@month varchar(10) =''
As 
SELECT Num as id 
      ,[Title] as title
      ,[HoliDay] as start
	  ,YN
	FROM [Tb_Holiday]
		Where HoliDay between @month+'-01'
	and DATEADD(DAY,-1, DATEADD(MONTH,1,@month+'-01'))
	Go