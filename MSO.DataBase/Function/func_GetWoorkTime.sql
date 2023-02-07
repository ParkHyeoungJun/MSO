/*
	평일 하루 근무시간을 알아온다 
	해당 날 출근시간,퇴근시간 하루 근무는 8시간이 최대 
*/
Create FUNCTION [dbo].[func_GetWoorkTime] (
@sdate Varchar(18)		 =''		,
@edate Varchar(18)		 =''
)  
RETURNS int  
AS  
Begin
 declare @reVal varchar(20);
if(CAST(datename(hh,@edate)as int) >=18)
	Begin
		set @reVal =8
		--set @reVal = @reVal +1
	End 
else if CAST(datename(hh,@edate)as int) <13
	Begin
		set @reVal =  DATEDIFF(HH,@sdate,@edate)
	End 
else if CAST(datename(hh,@edate)as int) >=13
	Begin
		set @reVal =  DATEDIFF(HH,@sdate,@edate)-1
	End 
Else
Begin
	set @reVal =   DATEDIFF(HH,@sdate,@edate)
End
return @reval
End