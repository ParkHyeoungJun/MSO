/*
  공휴일 , 토, 일 ,tb_hoilday테이블에 yn=1은 공휴일
  공휴일 여부
*/
Create FUNCTION [dbo].[func_GetWoorkHoliYN] (
@date Varchar(10) =''
)  
RETURNS bit  
AS  
Begin
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
End