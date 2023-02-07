/*
 근무  야근인지 특근인지 알아 온다 
 exec sp_GetWoorkHoliYN '2022-04-06'
 


*/
Create Proc [dbo].[sp_GetWoorkHoliYN]
	@date Varchar(10) =''
--	set @date='2022-04-05'
As	
	Declare @BitData bit
	Declare @WEEKDAY int -- 주일 검사용


/* 공휴일 테이블 존재 여부 검사 후 공휴일이 존재하지 않다면 토,일은 공휴일으로 지정한다 */	
	set @weekday = DATEPART(WEEKDAY,@date); 
	IF EXISTS (SELECT * FROM Tb_Holiday WHERE  HoliDay =@date and yn=1 or @weekday=1 or @weekday=2)
	Begin
		set @BitData = 1
	End
Else
	Begin
		set @BitData = 0
	End
return @BitData 