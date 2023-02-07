CREATE PROCEDURE [dbo].[sp_CostSales_Ins]
	@Num			INT 				=0					,
	@CustCode		Varchar(10)			=''					,
	@CarNum			Varchar(20)			=''					,
	@DateDay		varchar(10)			=''					,
	@Supply			Varchar(15)			=''					,
	@Surtax			Varchar(15)			=''					,
	@Total			Varchar(20)			=''					,
	@Note			varchar(8000)		=''
AS
if @Num =0
	Begin
		insert tb_CostSales 
		(
			CustCode	,
			CarNum		,
			DateDay		,
			Supply		,
			Surtax		,
			Total		,
			Note	
		)
		Values 
		(
			@CustCode	,
			@CarNum		,
			@DateDay	,
			@Supply		,
			@Surtax		,
			@Total		,
			@Note	
		)
	End
Else
	Begin
		update tb_CostSales set 
		CustCode	=@CustCode,
		CarNum		=@CarNum	,
		DateDay		=@DateDay	,
		Supply		=@Supply	,
		Surtax		=@Surtax	,
		Total		=@Total		,
		Note		=@Note	
		Where Num =@Num
	End
Go