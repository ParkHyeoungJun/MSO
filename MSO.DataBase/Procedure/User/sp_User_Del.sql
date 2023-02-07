CREATE PROCEDURE [dbo].[sp_User_Del]
	@UserId		varchar(20) =''
AS
Declare @Errmsg nvarchar(255)
set @Errmsg ='특근관리에 사용자 정보가 있습니다'
	if Not exists(Select  top 1 *
	from tb_Work Where UserId=@UserId)
	Begin
		Delete Tb_User Where UserId =@UserId
		
	End
	Else 
Begin
	RAISERROR (@Errmsg, -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );  
End