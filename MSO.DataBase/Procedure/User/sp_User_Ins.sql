CREATE PROCEDURE [dbo].[sp_User_Ins]
	@UserId		Varchar(20)		='',
	@UserName	Varchar(50)		='',
	@UserPwd	Varchar(200)	='',
	@Email		Varchar(250)	='',
	@Retired	bit             =0,
	@RetiredDay	varchar(10)=''
AS
	if not exists(Select top 1 * from Tb_User Where UserId=@UserId )
	Begin
		insert Tb_User 
		(
			UserId		,
			UserName	,
			UserPwd		,
			Email		,
			Retired		,
			RetiredDay
		)
		Values
		(
			@UserId		,
			@UserName	,
			@UserPwd	,
			@Email		,
			@Retired	, 
			@RetiredDay
		)
	End
	Else 
Begin
		update Tb_User set 
		UserName	=@UserName	,
		UserPwd		=@UserPwd	,
		Email		=@Email		,
		Retired		=@Retired	, 
		RetiredDay  =@RetiredDay
		Where UserId=@UserId 
		
End