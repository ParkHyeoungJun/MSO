CREATE PROCEDURE [dbo].[sp_Holiday_Ins]
@YN				Bit	=1				,
@Title			Varchar(100)	=''	,
@HoliDay		Varchar(10)		=''

AS
	if ( NOT EXISTS(Select top 1 * from Tb_Holiday Where HoliDay =@HoliDay ))
Begin
	Insert Tb_Holiday
	(
		YN			,
		Title		,
		HoliDay		,
		RegDate
	)
	Values
	(
		@YN			,
		@Title		,
		@HoliDay	,
		GetDate()
	)
End
	Else
Begin
	Update Tb_Holiday set 
	YN		=@YN		,
	Title=@Title		,
	ModDate = GETDATE()
	Where HoliDay = @HoliDay
End
