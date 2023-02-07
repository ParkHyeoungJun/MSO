/*
 평일 야근 시간을 알아 온다 18:30 부터 야근 시간.. 
  퇴근시간에 시간차을 알아 온다 

*/
CREATE FUNCTION dbo.func_OverTime (
@edate Varchar(max)		 =''
)  
RETURNS int  
AS  
Begin
declare @sdate Varchar(18)
 declare @reval int
 set @sdate = SUBSTRING(@edate,0,11)+' 18:30';
 if datename(hh,@edate) >18
	 Begin
		set @reval =  DATEDIFF(MI,@sdate,@edate) / 60  --,DATEDIFF(MI,@sdate,@edate) % 60 AS OverTimeMi
	 End 
 else
	Begin
		set @reval =0 
	eND
return @reval
End


/*
Select dbo.func_OverTime('2022-04-05 22:00')
*/