/*
MSO.DataBase의 배포 스크립트

이 코드는 도구를 사용하여 생성되었습니다.
파일 내용을 변경하면 잘못된 동작이 발생할 수 있으며, 코드를 다시 생성하면
변경 내용이 손실됩니다.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "MSO.DataBase"
:setvar DefaultFilePrefix "MSO.DataBase"
:setvar DefaultDataPath "C:\Users\박형준\AppData\Local\Microsoft\VisualStudio\SSDT\MSO"
:setvar DefaultLogPath "C:\Users\박형준\AppData\Local\Microsoft\VisualStudio\SSDT\MSO"

GO
:on error exit
GO
/*
SQLCMD 모드가 지원되지 않으면 SQLCMD 모드를 검색하고 스크립트를 실행하지 않습니다.
SQLCMD 모드를 설정한 후에 이 스크립트를 다시 사용하려면 다음을 실행합니다.
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'이 스크립트를 실행하려면 SQLCMD 모드를 사용하도록 설정해야 합니다.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'[dbo].[sp_EmpFind]을(를) 만드는 중...';


GO
/*
 사원 검색 
*/

--exec sp_EmpFind 'NAMECUST','',2,10

Create Proc sp_EmpFind
@Searchtype Varchar(20) ='', 
@Searchtxt	Varchar(100) ='', 
@pageNum int =1				,
@amount	int =10
As
 
Select * from 
(
SELECT 
ROW_NUMBER() OVER(ORDER BY (IDCUST)) AS rownum,
RTRIM(IDCUST) AS IDCUST,				-- 거래첱코드
RTRIM(NAMECUST) AS NAMECUST,			-- 거래처명
RTRIM(IDTAXREGI1) AS TAXREGNO,			-- 사업자번호
RTRIM(TEXTSTRE1) AS ADDR1,				-- 주소1
RTRIM(TEXTSTRE2) AS ADDR2,				-- 주서2
RTRIM(CODEPSTL) AS CODEPSTL,			--우편번호
TRIM(NAMECTAC) AS NAMECTAC,				--담당자
RTRIM(TEXTPHON1) AS PHONE, RTRIM(EMAIL1) AS EMAIL -- 이메일
, (Select count(1) from ARCUS
Where @Searchtype like '%'+ @Searchtxt +'%'
) as cnt 
FROM ARCUS
Where @Searchtype like '%'+ @Searchtxt +'%'
) Tab 
Where rownum <= @pageNum * @amount
and rownum >(@pageNum-1) * @amount 
ORDER BY IDCUST
GO
PRINT N'[dbo].[sp_GetEmp]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_GetEmp]
AS
SELECT A.EMPL, A.EMPLNAME

FROM (

        SELECT RTRIM(VALUE) AS EMPL, RTRIM(VDESC) EMPLNAME, CASE WHEN VALUE = 'COM' THEN 9 WHEN VALUE = 'KDH' THEN 1 ELSE 2 END SORT

        FROM CSOPTFD

        WHERE OPTFIELD = 'EMPL'

) A

ORDER BY A.SORT, A.EMPL
GO
PRINT N'[dbo].[sp_GetWoorkHoliYN]을(를) 만드는 중...';


GO
/*
 근무  야근인지 특근인지 알아 온다 
 exec sp_GetWoorkHoliYN '2022-04-06'
 


*/
Create Proc sp_GetWoorkHoliYN
	@date Varchar(10) =''
--	set @date='2022-04-05'
As	
	Declare @BitData bit
	Declare @WEEKDAY int -- 주일 검사용


/* 공휴일 테이블 존재 여부 검사 후 공휴일이 존재하지 않다면 토,일은 공휴일으로 지정한다 */	
	set @weekday = DATEPART(WEEKDAY,@date); 
	IF EXISTS (SELECT 1 FROM Tb_Holiday WHERE  HoliDay =@date or @weekday=1 or @weekday=2)
	Begin
		set @BitData = 1
	End
Else
	Begin
		set @BitData = 0
	End
Select @BitData
GO
PRINT N'[dbo].[sp_GetWoorkOverTime]을(를) 만드는 중...';


GO
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
		Select DATEDIFF(MI,@sdate,@edate) / 60 as OverTime --,DATEDIFF(MI,@sdate,@edate) % 60 AS OverTimeMi
	 End 
 else
	Begin
		Select 0 as OverTime
	eND
GO
PRINT N'[dbo].[sp_GetWoorkTime]을(를) 만드는 중...';


GO
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
GO
PRINT N'[dbo].[sp_GetYear]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_GetYear]
AS

SELECT FSCYEAR

FROM CSFSC

ORDER BY FSCYEAR ASC
GO
PRINT N'[dbo].[sp_Holiday_Del]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_Holiday_Del]
	@Num int =0
AS
	Delete Tb_Holiday Where Num =@Num
GO
PRINT N'[dbo].[sp_Holiday_Ins]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_Holiday_Ins]
@Num			int				=0	,
@Title			Varchar(100)	=''	,
@HoliDay		Varchar(10)		=''

AS
	if @Num =0
Begin
	Insert Tb_Holiday
	(
		Title		,
		HoliDay		,
		RegDate
	)
	Values
	(
		@Title		,
		@HoliDay	,
		GetDate()
	)
End
	Else
Begin
	Update Tb_Holiday set 
	Title=@Title		,
	HoliDay =@HoliDay	,
	ModDate = GETDATE()
	Where Num = @Num
End
GO
PRINT N'[dbo].[sp_Management_Del]을(를) 만드는 중...';


GO
/*
	경영 계획 삭제 
*/
CREATE PROCEDURE [dbo].[sp_Management_Del]
	@Idx			int		=0
AS
	Delete tb_ManagementMaster Where idx =@Idx
GO
PRINT N'[dbo].[sp_Management_Init]을(를) 만드는 중...';


GO
/*
	 마스터 데이터 가지고 오는 화면 

*/
Create proc [dbo].[sp_Management_Init]
As
Select 
a.Idx,
isnull(b.Num,0) as Num	,
ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum,
a.UserId,
a.CusttomerCode	,
a.CusttomerName	,
b.servion		,	
b.p1			,
b.r1			,
b.p2			,
b.r2			,
b.p3			,
b.r3			,
b.q1p			,
b.q1r			,
b.p4			,
b.r4			,
b.p5			,
b.r5			,
b.p6			,
b.r6			,
b.q2p			,
b.q2r			,
b.s1p			,
b.s1r			,
b.p7			,
b.r7			,
b.p8			,
b.r8			,
b.p9			,
b.r9			,
b.q3p			,
b.q3r			,
b.p10			,
b.r10			,
b.p11			,
b.r11			,
b.p12			,
b.r12			,
b.q4p			,
b.q4r			,
b.s2p			,
b.s2r			,
b.yp			,
b.yr			,
b.raw			,
b.ass			,
b.plp			,
b.plr			,
b.rusult
from tb_ManagementMaster a left join tb_ManagementSub b
on a.Idx=b.Idx
GO
PRINT N'[dbo].[sp_Management_Ins]을(를) 만드는 중...';


GO
/*
	경영 계획 마스터입력 및 수정 
	idx가 0이면 입력 
	idx 가 0이 아니면 수정 모드
*/
CREATE PROCEDURE [dbo].[sp_Management_Ins]
	@Idx			int		=0							,
	@UserId				varchar(20)		 =''			,
	@CusttomerCode		Varchar(10)		=''				,
	@CusttomerName		Varchar(50)		 =''			,	
	@YYYY				Char(4)			 =''			,
	@Ip					Varchar(15)		 =''
AS
	if @Idx =0
		Begin
			insert tb_ManagementMaster 
			(
				UserId					,
				CusttomerCode			,
				CusttomerName			,
				YYYY					,
				[Ip]					,
				RegDate			
			)
			Values
			(
				@UserId					,
				@CusttomerCode			,
				@CusttomerName			,
				@YYYY					,
				@Ip						,
				GETDATE()
			)
		End
	Else
		Begin
			update tb_ManagementMaster set 
			UserId =@UserId			,
			CusttomerName =@CusttomerName	,
			YYYY =@YYYY	,
			ModDate =GETDATE()
			Where Idx = @Idx
		End
GO
PRINT N'[dbo].[sp_Management_List]을(를) 만드는 중...';


GO
/*
	 마스터 데이터 가지고 오는 화면 

*/
Create  proc [dbo].[sp_Management_List]
	@YYYY char(4) =''	, 
	@servion int =1
As
Select
ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum,
a.Idx,
isnull(b.Num,0) as Num	,
a.UserId,
a.CusttomerCode	,
a.CusttomerName	,
b.servion		,	
b.p1			,
b.r1			,
b.p2			,
b.r2			,
b.p3			,
b.r3			,
b.q1p			,
b.q1r			,
b.p4			,
b.r4			,
b.p5			,
b.r5			,
b.p6			,
b.r6			,
b.q2p			,
b.q2r			,
b.s1p			,
b.s1r			,
b.p7			,
b.r7			,
b.p8			,
b.r8			,
b.p9			,
b.r9			,
b.q3p			,
b.q3r			,
b.p10			,
b.r10			,
b.p11			,
b.r11			,
b.p12			,
b.r12			,
b.q4p			,
b.q4r			,
b.s2p			,
b.s2r			,
b.yp			,
b.yr			,
b.raw			,
b.ass			,
b.plp			,
b.plr			,
b.rusult
from tb_ManagementMaster a left join tb_ManagementSub b
on a.Idx=b.Idx
Where a.YYYY=@YYYY and b.servion = @servion
GO
PRINT N'[dbo].[sp_Management_Sel]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_Management_Sel]
AS
	SELECT *
FROM ( 

SELECT ROW_NUMBER() OVER (ORDER BY Idx DESC) AS ROW_NUM, *
FROM tb_ManagementMaster

) T1
GO
PRINT N'[dbo].[sp_ManagementSub_GetVersion]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_ManagementSub_GetVersion]
	@YYYY	char(4) =''
AS
Select  ma.servion from tb_ManagementSub  ma left join tb_ManagementMaster ms
on ma.Idx=ms.Idx
Where ms.YYYY =@YYYY
Group by ma.servion
GO
PRINT N'[dbo].[sp_ManagementSub_Ins]을(를) 만드는 중...';


GO
Create PROCEDURE [dbo].[sp_ManagementSub_Ins]
	@Num				INT				=0	,
	@idx				int				=0	,
	@servion			int				=0	,
	@p1				decimal(7, 2) =0	,
	@r1				decimal(7, 2) =0	,
	@p2				decimal(7, 2) =0	,
	@r2				decimal(7, 2) =0	,
	@p3				decimal(7, 2) =0	,
	@r3				decimal(7, 2) =0	,
	@q1p			decimal(7, 2) =0	,
	@q1r			decimal(7, 2) =0	,
	@p4				decimal(7, 2) =0	,
	@r4				decimal(7, 2) =0	,
	@p5				decimal(7, 2) =0	,
	@r5				decimal(7, 2) =0	,
	@p6				decimal(7, 2) =0	,
	@r6				decimal(7, 2) =0	,
	@q2p			decimal(7, 2) =0	,
	@q2r			decimal(7, 2) =0	,
	@s1p			decimal(7, 2) =0	,
	@s1r			decimal(7, 2) =0	,
	@p7				decimal(7, 2) =0	,
	@r7				decimal(7, 2) =0	,
	@p8				decimal(7, 2) =0	,
	@r8				decimal(7, 2) =0	,
	@p9				decimal(7, 2) =0	,
	@r9				decimal(7, 2) =0	,
	@q3p			decimal(7, 2) =0	,
	@q3r			decimal(7, 2) =0	,
	@p10			decimal(7, 2) =0	,
	@r10			decimal(7, 2) =0	,
	@p11			decimal(7, 2) =0	,
	@r11			decimal(7, 2) =0	,
	@p12			decimal(7, 2) =0	,
	@r12			decimal(7, 2) =0	,
	@q4p			decimal(7, 2) =0	,
	@q4r			decimal(7, 2) =0	,
	@s2p			decimal(7, 2) =0	,
	@s2r			decimal(7, 2) =0	,
	@yp				decimal(7, 2) =0	,
	@yr				decimal(7, 2) =0	,
	@raw			decimal(7, 2) =0	,
	@ass			decimal(7, 2) =0	,
	@plp			decimal(7, 2) =0	,
	@plr			decimal(7, 2) =0	,
	@rusult			decimal(7, 2) =0	
	
	
AS
If @Num=0
	Begin
		insert tb_ManagementSub 
		(
			idx		,
			servion	,
			p1		,
			r1		,
			p2		,
			r2		,
			p3		,
			r3		,
			q1p		,
			q1r		,
			p4		,
			r4		,
			p5		,
			r5		,
			p6		,
			r6		,
			q2p		,
			q2r		,
			s1p		,
			s1r		,
			p7		,
			r7		,
			p8		,
			r8		,
			p9		,
			r9		,
			q3p		,
			q3r		,
			p10		,
			r10		,
			p11		,
			r11		,
			p12		,
			r12		,
			q4p		,
			q4r		,
			s2p		,
			s2r		,
			yp		,
			yr		,
			raw		,
			ass		,
			plp		,
			plr		,
			rusult	,
			RegDate
		)
		Values
		(
			@idx		,
			@servion	,
			@p1			,
			@r1			,
			@p2			,
			@r2			,
			@p3			,
			@r3			,
			@q1p		,
			@q1r		,
			@p4			,
			@r4			,
			@p5			,
			@r5			,
			@p6			,
			@r6			,
			@q2p		,
			@q2r		,
			@s1p		,
			@s1r		,
			@p7			,
			@r7			,
			@p8			,
			@r8			,
			@p9			,
			@r9			,
			@q3p		,
			@q3r		,
			@p10		,
			@r10		,
			@p11		,
			@r11		,
			@p12		,
			@r12		,
			@q4p		,
			@q4r		,
			@s2p		,
			@s2r		,
			@yp			,
			@yr			,
			@raw		,
			@ass		,
			@plp		,
			@plr		,
			@rusult		,
			GETDATE()	
		)
	End
Else
	Begin
		update tb_ManagementSub set 
			idx		=@idx		,
			servion	=@servion	,
			p1		=@p1		,
			r1		=@r1		,
			p2		=@p2		,
			r2		=@r2		,
			p3		=@p3		,
			r3		=@r3		,
			q1p		=@q1p		,
			q1r		=@q1r		,
			p4		=@p4		,
			r4		=@r4		,
			p5		=@p5		,
			r5		=@r5		,
			p6		=@p6		,
			r6		=@r6		,
			q2p		=@q2p		,
			q2r		=@q2r		,
			s1p		=@s1p		,
			s1r		=@s1r		,
			p7		=@p7		,
			r7		=@r7		,
			p8		=@p8		,
			r8		=@r8		,
			p9		=@p9		,
			r9		=@r9		,
			q3p		=@q3p		,
			q3r		=@q3r		,
			p10		=@p10		,
			r10		=@r10		,
			p11		=@p11		,
			r11		=@r11		,
			p12		=@p12		,
			r12		=@r12		,
			q4p		=@q4p		,
			q4r		=@q4r		,
			s2p		=@s2p		,
			s2r		=@s2r		,
			yp		=@yp		,
			yr		=@yr		,
			raw		=@raw		,
			ass		=@ass		,
			plp		=@plp		,
			plr		=@plr		,
			rusult	=@rusult	,
		ModDate = GETDATE()
	Where Num =@Num
	End
GO
PRINT N'[dbo].[sp_ManagementSub_Sel]을(를) 만드는 중...';


GO
CREATE  PROCEDURE [dbo].[sp_ManagementSub_Sel]
	@YYYY Char(4) ='',
	@Servion int =1
AS
Select
ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum,
a.Idx,
isnull(b.Num,0) as Num	,
a.UserId,
a.CusttomerCode	,
a.CusttomerName	,
b.servion		,	
b.p1			,
b.r1			,
b.p2			,
b.r2			,
b.p3			,
b.r3			,
b.q1p			,
b.q1r			,
b.p4			,
b.r4			,
b.p5			,
b.r5			,
b.p6			,
b.r6			,
b.q2p			,
b.q2r			,
b.s1p			,
b.s1r			,
b.p7			,
b.r7			,
b.p8			,
b.r8			,
b.p9			,
b.r9			,
b.q3p			,
b.q3r			,
b.p10			,
b.r10			,
b.p11			,
b.r11			,
b.p12			,
b.r12			,
b.q4p			,
b.q4r			,
b.s2p			,
b.s2r			,
b.yp			,
b.yr			,
b.raw			,
b.ass			,
b.plp			,
b.plr			,
b.rusult
from tb_ManagementMaster a left join tb_ManagementSub b
on a.Idx=b.Idx
Where a.YYYY =@YYYY
and isnull(b.servion,1) = @Servion
GO
PRINT N'[dbo].[sp_User_Del]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_User_Del]
	@UserId		varchar(20) =''
AS
	Delete Tb_User Where UserId =@UserId
GO
PRINT N'[dbo].[sp_User_Ins]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_User_Ins]
	@Num		Int				=0,
	@UserId		Varchar(20)		='',
	@UserName	Varchar(50)		='',
	@UserPwd	Varchar(200)	='',
	@Email		Varchar(250)	=''



AS
	if @Num = 0
	Begin
		insert Tb_User 
		(
			UserId		,
			UserName	,
			UserPwd		,
			Email		
		)
		Values
		(
			@UserId		,
			@UserName	,
			@UserPwd	,
			@Email
		)
	End
	Else 
	Begin
		update Tb_User set 
		UserId		=@UserId	,
		UserName	=@UserName	,
		UserPwd		=@UserPwd	,
		Email		=@Email
		Where Num =@Num
	End
GO
PRINT N'[dbo].[sp_User_Login]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_User_Login]
	@param1 int = 0,
	@param2 int
AS
	SELECT @param1, @param2
RETURN 0
GO
PRINT N'[dbo].[sp_User_Sel]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_User_Sel]
	@param1 int = 0,
	@param2 int
AS
	SELECT @param1, @param2
RETURN 0
GO
PRINT N'[dbo].[sp_Woork_Del]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_Woork_Del]
	@param1 int = 0,
	@param2 int
AS
	SELECT @param1, @param2
RETURN 0
GO
PRINT N'[dbo].[sp_Work_Ins]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_Work_Ins]
	@Num			Int							=0			, 
	@UserId			Varchar(20)					=''			,  -- 아이디
	@AttenDay		Varchar(10)					=''			,  -- 출근일
	@AttenTime		Varchar(10)					=''			,  -- 출근시간
	@LeaveTime		varchar(10)					=''			  -- 퇴근 시간 
	--@Overtime		decimal(2, 2)				=0			, -- 야근시간
	--@WorkOvertime	decimal(2, 2)               =0			  --특근시간 
AS
Declare		@HoilYn Bit
exec @HoilYn = sp_GetWoorkHoliYN @AttenDay --  특근 ,야근 여부 1은 특근, 0은 야근 
Declare @Overtime Decimal(2,2)
Declare @str varchar(max)
set @str = @AttenDay +' '+ @LeaveTime
exec @Overtime =sp_GetWoorkOverTime @str	

if @Num =0 
Begin
	if @HoilYn =0
		Begin
			insert tb_Work 
			(
				UserId			,
				AttenDay		,
				AttenTime		,
				LeaveTime		,
				Overtime		,
				WorkOvertime	
			)
			Values
			(
				@UserId			,
				@AttenDay		,
				@AttenTime		,
				@LeaveTime		,
				@Overtime		,
				0	
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
				WorkOvertime	
			)
			Values
			(
				@UserId			,
				@AttenDay		,
				@AttenTime		,
				@LeaveTime		,
				0				,
				@Overtime		
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
			Overtime	=@Overtime		,
			WorkOvertime=0
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
			WorkOvertime=@Overtime
			Where Num = @Num
		End
	End
GO
PRINT N'업데이트가 완료되었습니다.';


GO
