Create Proc sp_Work_ExcelUp
@UserId			Varchar(20)					=''			,  -- 아이디
@AttenDay		Varchar(10)					=''			,  -- 출근일
@LeaveTime		varchar(10)					=''
As
Begin
--
Declare		@HoilYn Bit
Declare		@AttenTime Varchar(10)
set @HoilYn = dbo.func_GetWoorkHoliYN(@AttenDay)
Select @AttenTime = AttenTime  from tb_Work Where UserId=@UserId and AttenDay=@AttenDay

--set @strsdate=  CONVERT (DATETIME, @AttenDay +' '+ @AttenTime)
Declare @str varchar(max)
set @str =  CONVERT (DATETIME, @AttenDay +' '+ @LeaveTime)
Declare @WoorkTime int
set @WoorkTime = dbo.func_GetWoorkTime(@AttenTime,@str)
--
update tb_Work set 
LeaveTime	=@LeaveTime		,
Overtime	=(Select dbo.func_OverTime(@str))		,
WorkOvertime=0,
WoorkTime=@WoorkTime 
Where UserId=@UserId and AttenDay=@AttenDay
End
Go