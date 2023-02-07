Create PROCEDURE [dbo].[sp_Work_Ins]
	@Num			Int							=0			, 
	@UserId			Varchar(20)					=''			,  -- 아이디
	@AttenDay		Varchar(10)					=''			,  -- 출근일
	@AttenTime		Varchar(10)					=''			,  -- 출근시간
	@LeaveTime		varchar(10)					=''			  -- 퇴근 시간 
	--@Overtime		decimal(2, 2)				=0			, -- 야근시간
	--@WorkOvertime	decimal(2, 2)               =0			  --특근시간 
AS
Declare		@HoilYn Bit
set @HoilYn = dbo.func_GetWoorkHoliYN(@AttenDay) --  특근 ,야근 여부 1은 특근, 0은 야근 
--Declare @Overtime varchar(max)
Declare @str1 varchar(max)
set @str1=  CONVERT (DATETIME, @AttenDay +' '+ @AttenTime)
Declare @str varchar(max)
set @str =  CONVERT (DATETIME, @AttenDay +' '+ @LeaveTime)
Declare @WoorkTime int
set @WoorkTime = dbo.func_GetWoorkTime(@str1,@str)-- 평일 하루 최대 근무시간
--exec @Overtime =sp_GetWoorkOverTime @str

if @Num =0 
Begin
-- 평일이라면 
	if @HoilYn =0
		Begin
			insert tb_Work 
			(
				UserId			,
				AttenDay		,
				AttenTime		,
				LeaveTime		,
				Overtime		,
				WorkOvertime	,
				WoorkTime
			)
			Values
			(
				@UserId			,
				@AttenDay		,
				@AttenTime		,
				@LeaveTime		,
				(Select dbo.func_OverTime(@str))		,
				0
				,@WoorkTime
			)
		End
	Else
			Begin
				insert tb_Work 
			(
				UserId			,
				AttenDay		,
				AttenTime		,
				LeaveTime		,
				Overtime		,
				WorkOvertime	,
				WoorkTime
			)
			Values
			(
				@UserId			,
				@AttenDay		,
				@AttenTime		,
				@LeaveTime		,
				0				,
				(Select dbo.func_OverTime(@str))	
				,@WoorkTime
			)
			End
		
End
Else
	Begin
		if @HoilYn =0 
		Begin
			Update tb_Work set 
			UserId		=@UserId		,
			AttenDay	=@AttenDay		,
			AttenTime	=@AttenTime		,
			LeaveTime	=@LeaveTime		,
			Overtime	=(Select dbo.func_OverTime(@str))		,
			WorkOvertime=0,
			WoorkTime=@WoorkTime 
			Where Num = @Num
		End
		Else
		Begin
				Update tb_Work set 
			UserId		=@UserId		,
			AttenDay	=@AttenDay		,
			AttenTime	=@AttenTime		,
			LeaveTime	=@LeaveTime		,
			Overtime	=0		,
			WorkOvertime=(Select dbo.func_OverTime(@str))
			,WoorkTime=@WoorkTime 
			Where Num = @Num
		End
	End
