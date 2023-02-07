/*
 근무 시간을 알아 온다 
  0~8시만 입력 야근 및 특근은 다른 컬럼으로 관리
		9  :0시
		10 :1시 
		11 :2시
		12 :3시
		13 :3시
		14 :4시 
		15 :5시
		16 :6시
		17 :7시
		18 :8시
exec sp_GetWoorkTime'2022-04-05 09:00','2022-04-05 19:00'
*/
Create proc [sp_GetWoorkTime] 
 @sdate Varchar(18)		 =''		,
 @edate Varchar(18)		 =''
-- set @sdate ='2022-04-05 09:00'
-- set @edate ='2022-04-05 18:00'
As
 declare @reVal varchar(20);
if CAST(datename(hh,@edate)as int) <13
	Begin
		set @reVal =  DATEDIFF(HH,@sdate,@edate)
	End 
else if CAST(datename(hh,@edate)as int) <13
	Begin
		set @reVal = DATEDIFF(HH,@sdate,@edate)
		--set @reVal = @reVal +1
	End 
/*
else if CAST(datename(hh,@edate)as int) <=16
	Begin
		set @reVal = DATEDIFF(HH,@sdate,@edate)-1
		--set @reVal = @reVal +1
	End 
*/
Else
Begin
	if(CAST(datename(hh,@edate)as int) >=18)
		Begin
			set @reVal =8
		End
	Else
		Begin
		set @reVal =   DATEDIFF(HH,@sdate,@edate)-1
		End
End

		Select @reVal
Go





