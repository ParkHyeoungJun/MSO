CREATE PROCEDURE [dbo].[sp_Holiday_Del]
	@HoliDay Varchar(10) =''
AS
	Delete Tb_Holiday Where HoliDay =@HoliDay
Go