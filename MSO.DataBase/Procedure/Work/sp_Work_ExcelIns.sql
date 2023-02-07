Create Proc [dbo].[sp_Work_ExcelIns]
@UserId			Varchar(20)					=''			,  -- 아이디
@AttenDay		Varchar(10)					=''			,  -- 출근일
@AttenTime		Varchar(10)					=''		
As
if not  exists(Select top 1 * from tb_Work Where UserId=@UserId and AttenDay =@AttenDay)
Begin 

	insert tb_Work 
	(
	UserId,
	AttenDay,
	AttenTime,
	LeaveTime,
	Overtime,
	WorkOvertime,
	WoorkTime	,
	Regdate
	)
	Values 
	(
	@UserId,
	@AttenDay,
	@AttenTime,
	@AttenTime,
	0			,
	0			,
	0			,
	GETDATE()
	)
End
Else

Begin
	update tb_Work set 
	AttenTime = @AttenTime
	Where UserId=@UserId and AttenDay =@AttenDay
End 
Go