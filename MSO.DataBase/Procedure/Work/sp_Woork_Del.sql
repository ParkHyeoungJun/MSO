CREATE PROCEDURE [dbo].[sp_Woork_Del]
	@Num		Int =0
AS
	Delete tb_Work Where Num =@Num
Go