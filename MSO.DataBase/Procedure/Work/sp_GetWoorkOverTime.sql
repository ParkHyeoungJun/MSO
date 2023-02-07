/*
	야근 및 특근 계산 알고리즘 
	exec sp_GetWoorkOverTime '2022-04-05 20:30'

*/
CREATE PROCEDURE [dbo].[sp_GetWoorkOverTime]
	@edate Varchar(18)		 =''
-- set @edate ='2022-04-05 18:00'
AS
 declare @sdate Varchar(18)
 set @sdate = SUBSTRING(@edate,0,11)+' 18:30';
 if datename(hh,@edate) >18
	 Begin
		return  DATEDIFF(MI,@sdate,@edate) / 60  --,DATEDIFF(MI,@sdate,@edate) % 60 AS OverTimeMi
	 End 
 else
	Begin
		return 0 
	eND