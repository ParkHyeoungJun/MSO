CREATE PROCEDURE [dbo].[sp_CostSales_Del]
	@Num	int =0
AS
	delete  tb_CostSales Where Num =@Num
Go
