/****** SSMS의 SelectTopNRows 명령 스크립트 ******/
Create Proc [dbo].[sp_Holiday_Get]
@HoliDay varchar(10) =''
As 
SELECT YN,
Title
	FROM [Tb_Holiday]
		Where HoliDay =@HoliDay