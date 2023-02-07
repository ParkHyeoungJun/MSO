/*
MSOCOM의 배포 스크립트

이 코드는 도구를 사용하여 생성되었습니다.
파일 내용을 변경하면 잘못된 동작이 발생할 수 있으며, 코드를 다시 생성하면
변경 내용이 손실됩니다.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "MSOCOM"
:setvar DefaultFilePrefix "MSOCOM"
:setvar DefaultDataPath "D:\DataBase\Data_Mdf\"
:setvar DefaultLogPath "D:\DataBase\Log_Ldf\"

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
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'[dbo].[tb_CostSales]을(를) 만드는 중...';


GO
CREATE TABLE [dbo].[tb_CostSales] (
    [Num]      INT            IDENTITY (1, 1) NOT NULL,
    [CustCode] VARCHAR (10)   NULL,
    [CarNum]   VARCHAR (20)   NULL,
    [DateDay]  VARCHAR (10)   NULL,
    [Supply]   VARCHAR (15)   NULL,
    [Surtax]   VARCHAR (15)   NULL,
    [Total]    VARCHAR (20)   NULL,
    [Note]     VARCHAR (8000) NULL,
    [Regdate]  DATE           NULL,
    [Moddate]  DATE           NULL,
    PRIMARY KEY CLUSTERED ([Num] ASC)
);


GO
PRINT N'[dbo].[Tb_Holiday]을(를) 만드는 중...';


GO
CREATE TABLE [dbo].[Tb_Holiday] (
    [Num]     INT           IDENTITY (1, 1) NOT NULL,
    [YN]      BIT           NULL,
    [Title]   VARCHAR (100) NULL,
    [HoliDay] VARCHAR (10)  NULL,
    [RegDate] SMALLDATETIME NULL,
    [ModDate] SMALLDATETIME NULL,
    PRIMARY KEY CLUSTERED ([Num] ASC)
);


GO
PRINT N'[dbo].[tb_ManagementMaster]을(를) 만드는 중...';


GO
CREATE TABLE [dbo].[tb_ManagementMaster] (
    [Idx]           INT           IDENTITY (1, 1) NOT NULL,
    [UserId]        VARCHAR (20)  NULL,
    [UserName]      VARCHAR (20)  NULL,
    [CusttomerCode] VARCHAR (10)  NULL,
    [CusttomerName] VARCHAR (50)  NULL,
    [YYYY]          CHAR (4)      NULL,
    [Ip]            VARCHAR (15)  NULL,
    [RegDate]       SMALLDATETIME NULL,
    [ModDate]       SMALLDATETIME NULL,
    PRIMARY KEY CLUSTERED ([Idx] ASC)
);


GO
PRINT N'[dbo].[tb_ManagementSub]을(를) 만드는 중...';


GO
CREATE TABLE [dbo].[tb_ManagementSub] (
    [Num]     INT            IDENTITY (1, 1) NOT NULL,
    [idx]     INT            NOT NULL,
    [servion] INT            NOT NULL,
    [p1]      DECIMAL (7, 2) NULL,
    [r1]      DECIMAL (7, 2) NULL,
    [p2]      DECIMAL (7, 2) NULL,
    [r2]      DECIMAL (7, 2) NULL,
    [p3]      DECIMAL (7, 2) NULL,
    [r3]      DECIMAL (7, 2) NULL,
    [q1p]     DECIMAL (7, 2) NULL,
    [q1r]     DECIMAL (7, 2) NULL,
    [p4]      DECIMAL (7, 2) NULL,
    [r4]      DECIMAL (7, 2) NULL,
    [p5]      DECIMAL (7, 2) NULL,
    [r5]      DECIMAL (7, 2) NULL,
    [p6]      DECIMAL (7, 2) NULL,
    [r6]      DECIMAL (7, 2) NULL,
    [q2p]     DECIMAL (7, 2) NULL,
    [q2r]     DECIMAL (7, 2) NULL,
    [s1p]     DECIMAL (7, 2) NULL,
    [s1r]     DECIMAL (7, 2) NULL,
    [p7]      DECIMAL (7, 2) NULL,
    [r7]      DECIMAL (7, 2) NULL,
    [p8]      DECIMAL (7, 2) NULL,
    [r8]      DECIMAL (7, 2) NULL,
    [p9]      DECIMAL (7, 2) NULL,
    [r9]      DECIMAL (7, 2) NULL,
    [q3p]     DECIMAL (7, 2) NULL,
    [q3r]     DECIMAL (7, 2) NULL,
    [p10]     DECIMAL (7, 2) NULL,
    [r10]     DECIMAL (7, 2) NULL,
    [p11]     DECIMAL (7, 2) NULL,
    [r11]     DECIMAL (7, 2) NULL,
    [p12]     DECIMAL (7, 2) NULL,
    [r12]     DECIMAL (7, 2) NULL,
    [q4p]     DECIMAL (7, 2) NULL,
    [q4r]     DECIMAL (7, 2) NULL,
    [s2p]     DECIMAL (7, 2) NULL,
    [s2r]     DECIMAL (7, 2) NULL,
    [yp]      DECIMAL (7, 2) NULL,
    [yr]      DECIMAL (7, 2) NULL,
    [raw]     DECIMAL (7, 2) NULL,
    [ass]     DECIMAL (7, 2) NULL,
    [plp]     DECIMAL (7, 2) NULL,
    [plr]     DECIMAL (7, 2) NULL,
    [rusult]  DECIMAL (7, 2) NULL,
    [RegDate] DATETIME       NULL,
    [ModDate] DATETIME       NULL
);


GO
PRINT N'[dbo].[Tb_User]을(를) 만드는 중...';


GO
CREATE TABLE [dbo].[Tb_User] (
    [Num]        INT           IDENTITY (1, 1) NOT NULL,
    [UserId]     VARCHAR (20)  NULL,
    [UserName]   VARCHAR (50)  NOT NULL,
    [UserPwd]    VARCHAR (200) NOT NULL,
    [Email]      VARCHAR (250) NOT NULL,
    [LoginDate]  SMALLDATETIME NULL,
    [Retired]    BIT           NULL,
    [RetiredDay] SMALLDATETIME NULL,
    PRIMARY KEY CLUSTERED ([Num] ASC)
);


GO
PRINT N'[dbo].[tb_Work]을(를) 만드는 중...';


GO
CREATE TABLE [dbo].[tb_Work] (
    [Num]          INT          IDENTITY (1, 1) NOT NULL,
    [UserId]       VARCHAR (20) NULL,
    [AttenDay]     VARCHAR (10) NULL,
    [AttenTime]    VARCHAR (10) NULL,
    [LeaveTime]    VARCHAR (10) NULL,
    [Overtime]     VARCHAR (10) NULL,
    [WorkOvertime] VARCHAR (10) NULL,
    [WoorkTime]    VARCHAR (2)  NULL,
    [Regdate]      DATE         NULL,
    [Moddate]      DATE         NULL,
    PRIMARY KEY CLUSTERED ([Num] ASC)
);


GO
PRINT N'[dbo].[tb_CostSales]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[tb_CostSales]
    ADD DEFAULT (getdate()) FOR [Regdate];


GO
PRINT N'[dbo].[tb_CostSales]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[tb_CostSales]
    ADD DEFAULT (null) FOR [Moddate];


GO
PRINT N'[dbo].[Tb_Holiday]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[Tb_Holiday]
    ADD DEFAULT (1) FOR [YN];


GO
PRINT N'[dbo].[Tb_Holiday]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[Tb_Holiday]
    ADD DEFAULT (getDate()) FOR [RegDate];


GO
PRINT N'[dbo].[Tb_Holiday]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[Tb_Holiday]
    ADD DEFAULT (Null) FOR [ModDate];


GO
PRINT N'[dbo].[tb_ManagementMaster]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[tb_ManagementMaster]
    ADD DEFAULT (getDate()) FOR [RegDate];


GO
PRINT N'[dbo].[tb_ManagementMaster]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[tb_ManagementMaster]
    ADD DEFAULT (Null) FOR [ModDate];


GO
PRINT N'[dbo].[Tb_User]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[Tb_User]
    ADD DEFAULT (getDate()) FOR [LoginDate];


GO
PRINT N'[dbo].[Tb_User]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[Tb_User]
    ADD DEFAULT (0) FOR [Retired];


GO
PRINT N'[dbo].[Tb_User]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[Tb_User]
    ADD DEFAULT (null) FOR [RetiredDay];


GO
PRINT N'[dbo].[tb_Work]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[tb_Work]
    ADD DEFAULT (Getdate()) FOR [Regdate];


GO
PRINT N'[dbo].[tb_Work]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[tb_Work]
    ADD DEFAULT (Null) FOR [Moddate];


GO
PRINT N'[dbo].[fun_GetOvertime]을(를) 만드는 중...';


GO
Create FUNCTION dbo.fun_GetOvertime (
@UserId varchar(20)=''	,
@sday	Varchar(10)=''
)
RETURNS int
AS
BEGIN

 DECLARE @cnt int;
 SET @cnt = 0;

 BEGIN
  SET @cnt = (
Select SUM(CONVERT(INT,ISNULL(Overtime,0)))  
from tb_Work Where UserId=@UserId
and AttenDay between @sday and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@sday)));  
 END
RETURN @cnt;
END
GO
PRINT N'[dbo].[fun_GetWoorkTime]을(를) 만드는 중...';


GO
Create FUNCTION dbo.fun_GetWoorkTime (
@UserId varchar(20)=''	,
@sday	Varchar(10)=''
)
RETURNS int
AS
BEGIN

 DECLARE @cnt int;
 SET @cnt = 0;

 BEGIN
  SET @cnt = (
Select SUM(CONVERT(INT,ISNULL(WoorkTime,0)))  
from tb_Work Where UserId=@UserId
and AttenDay between @sday and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@sday)));  
 END
RETURN @cnt;
END
GO
PRINT N'[dbo].[fun_GetWorkOvertime]을(를) 만드는 중...';


GO
Create FUNCTION dbo.fun_GetWorkOvertime (
@UserId varchar(20)=''	,
@sday	Varchar(10)=''
)
RETURNS int
AS
BEGIN

 DECLARE @cnt int;
 SET @cnt = 0;

 BEGIN
  SET @cnt = (
Select SUM(CONVERT(INT,ISNULL(WorkOvertime,0)))  
from tb_Work Where UserId=@UserId
and AttenDay between @sday and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@sday)));  
 END
RETURN @cnt;
END
GO
PRINT N'[dbo].[func_GetWoorkHoliYN]을(를) 만드는 중...';


GO
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
GO
PRINT N'[dbo].[func_GetWoorkTime]을(를) 만드는 중...';


GO
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
if CAST(datename(hh,@edate)as int) <13
	Begin
		set @reVal =  DATEDIFF(HH,@sdate,@edate)
	End 
else if CAST(datename(hh,@edate)as int) <13
	Begin
		set @reVal = DATEDIFF(HH,@sdate,@edate)
		--set @reVal = @reVal +1
	End 

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
return @reval
End
GO
PRINT N'[dbo].[func_OverTime]을(를) 만드는 중...';


GO
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
GO
PRINT N'[dbo].[sp_EmpFind] 변경 중...';


GO
/*
 사원 검색 
*/

--exec sp_EmpFind 'NAMECUST','',2,10

ALTER Proc [dbo].[sp_EmpFind]
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
,(select COUNT(1) from ARCUS bb
Where 
Case when TRIM(@Searchtype)='IDCUST' then IDCUST 
	when TRIM(@Searchtype)='NAMECUST' then NAMECUST
	when TRIM(@Searchtype)='IDTAXREGI1' then bb.IDTAXREGI1
	when TRIM(@Searchtype)='TEXTSTRE1' then TEXTSTRE1
	when TRIM(@Searchtype)='TEXTSTRE2' then TEXTSTRE2
	when TRIM(@Searchtype)='CODEPSTL' then CODEPSTL
	when TRIM(@Searchtype)='NAMECTAC' then NAMECTAC
end like '%'+ @Searchtxt + '%'


) as cnt 
FROM ARCUS
) tab
Where 
Case when TRIM(@Searchtype)='IDCUST' then IDCUST 
	when TRIM(@Searchtype)='NAMECUST' then NAMECUST
	when TRIM(@Searchtype)='IDTAXREGI1' then TAXREGNO
	when TRIM(@Searchtype)='TEXTSTRE1' then ADDR1
	when TRIM(@Searchtype)='TEXTSTRE2' then ADDR2
	when TRIM(@Searchtype)='CODEPSTL' then CODEPSTL
	when TRIM(@Searchtype)='NAMECTAC' then NAMECTAC
end like '%'+ @Searchtxt + '%'
and rownum <= @pageNum * @amount
and rownum >(@pageNum-1) * @amount
GO
PRINT N'[dbo].[sp_CostSales_Del]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_CostSales_Del]
	@Num	int =0
AS
	delete  tb_CostSales Where Num =@Num
GO
PRINT N'[dbo].[sp_CostSales_Ins]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_CostSales_Ins]
	@Num			INT 				=0					,
	@CustCode		Varchar(10)			=''					,
	@CarNum			Varchar(20)			=''					,
	@DateDay		varchar(10)			=''					,
	@Supply			Varchar(15)			=''					,
	@Surtax			Varchar(15)			=''					,
	@Total			Varchar(20)			=''					,
	@Note			varchar(8000)		=''
AS
if @Num =0
	Begin
		insert tb_CostSales 
		(
			CustCode	,
			CarNum		,
			DateDay		,
			Supply		,
			Surtax		,
			Total		,
			Note	
		)
		Values 
		(
			@CustCode	,
			@CarNum		,
			@DateDay	,
			@Supply		,
			@Surtax		,
			@Total		,
			@Note	
		)
	End
Else
	Begin
		update tb_CostSales set 
		CustCode	=@CustCode,
		CarNum		=@CarNum	,
		DateDay		=@DateDay	,
		Supply		=@Supply	,
		Surtax		=@Surtax	,
		Total		=@Total		,
		Note		=@Note	
		Where Num =@Num
	End
GO
PRINT N'[dbo].[sp_CostSales_Sel]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_CostSales_Sel]
	@sDay varchar(10) ='',
	@eDay varchar(10) =''
AS
Select 
ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum
,RTRIM(VDESC) CARRIERNAME
,A.* 
from tb_CostSales a
left join CSOPTFD b on a.CustCode= RTRIM(b.VALUE)
Where OPTFIELD = 'CARRIER'
and DateDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
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
		return  DATEDIFF(MI,@sdate,@edate) / 60  --,DATEDIFF(MI,@sdate,@edate) % 60 AS OverTimeMi
	 End 
 else
	Begin
		return 0 
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
	@HoliDay Varchar(10) =''
AS
	Delete Tb_Holiday Where HoliDay =@HoliDay
GO
PRINT N'[dbo].[sp_Holiday_Ins]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_Holiday_Ins]
@YN				Bit	=1				,
@Title			Varchar(100)	=''	,
@HoliDay		Varchar(10)		=''

AS
	if ( NOT EXISTS(Select top 1 * from Tb_Holiday Where HoliDay =@HoliDay ))
Begin
	Insert Tb_Holiday
	(
		YN			,
		Title		,
		HoliDay		,
		RegDate
	)
	Values
	(
		@YN			,
		@Title		,
		@HoliDay	,
		GetDate()
	)
End
	Else
Begin
	Update Tb_Holiday set 
	YN		=@YN		,
	Title=@Title		,
	ModDate = GETDATE()
	Where HoliDay = @HoliDay
End
GO
PRINT N'[dbo].[sp_Holiday_Sel]을(를) 만드는 중...';


GO
/****** SSMS의 SelectTopNRows 명령 스크립트 ******/
Create Proc sp_Holiday_Sel
@month varchar(8) =''
As 
SELECT Num as id 
      ,[Title] as title
      ,[HoliDay] as start
	FROM [Tb_Holiday]
		Where HoliDay between @month+'-01'
	and DATEADD(DAY,-1, DATEADD(MONTH,1,@month+'-01'))
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
RTRIM(VDESC)	UserName
,a.CusttomerCode	,
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
left join CSOPTFD  c on a.UserId= RTRIM(c.VALUE)
wHERE  OPTFIELD = 'EMPL'
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
Create proc [dbo].[sp_Management_List]
	@YYYY char(4) =''	, 
	@servion int =1
As
Select
ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum,
a.Idx,
isnull(b.Num,0) as Num	,
a.UserId,
RTRIM(VDESC)	UserName
,a.CusttomerCode	,
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
from tb_ManagementMaster a 
left join tb_ManagementSub b
on a.Idx=b.Idx
left join CSOPTFD  c on a.UserId= RTRIM(c.VALUE)
Where a.YYYY=@YYYY 
and isnull(b.servion,@servion) = @servion
and OPTFIELD = 'EMPL'
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
PRINT N'[dbo].[sp_ManagementMaster_Del]을(를) 만드는 중...';


GO
Create Proc sp_ManagementMaster_Del
	@UserId		varchar(20)	='',
	@CusttomerCode Varchar(10) ='',
	@YYYY		Char(4)=''
As
	Delete tb_ManagementMaster Where UserId =@UserId
	and CusttomerCode =@CusttomerCode
	and YYYY =@YYYY
GO
PRINT N'[dbo].[sp_ManagementMaster_List]을(를) 만드는 중...';


GO
Create Proc sp_ManagementMaster_List
@UserId		Varchar(20) =''	,
@YYYY		Char(4)		=''
As
Select * from tb_ManagementMaster
Where YYYY =@YYYY and UserId =@UserId
GO
PRINT N'[dbo].[sp_ManagementSub_GetVersion]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_ManagementSub_GetVersion]
	@YYYY	char(4) =''	
AS
  SET NOCOUNT ON;
Declare @servion varchar(10)
Select * from(Select ma.servion+1 as servion from tb_ManagementSub  ma 
left join tb_ManagementMaster ms
on ma.Idx=ms.Idx
Where ms.YYYY =@YYYY
Group by ma.servion
union all select 1 as servion
)tab
order by servion
GO
PRINT N'[dbo].[sp_ManagementSub_Ins]을(를) 만드는 중...';


GO
Create proc [dbo].[sp_ManagementSub_Ins]
	@Num				INT				=0	,
	@idx				int				=0	,
	@servion			int				=0	,
	@p1				varchar(10) ='0'	,
	@r1				varchar(10) ='0'	,
	@p2				varchar(10) ='0'	,
	@r2				varchar(10) ='0'	,
	@p3				varchar(10) ='0'	,
	@r3				varchar(10) ='0'	,
	@q1p			varchar(10) ='0'	,
	@q1r			varchar(10) ='0'	,
	@p4				varchar(10) ='0'	,
	@r4				varchar(10) ='0'	,
	@p5				varchar(10) ='0'	,
	@r5				varchar(10) ='0'	,
	@p6				varchar(10) ='0'	,
	@r6				varchar(10) ='0'	,
	@q2p			varchar(10) ='0'	,
	@q2r			varchar(10) ='0'	,
	@s1p			varchar(10) ='0'	,
	@s1r			varchar(10) ='0'	,
	@p7				varchar(10) ='0'	,
	@r7				varchar(10) ='0'	,
	@p8				varchar(10) ='0'	,
	@r8				varchar(10) ='0'	,
	@p9				varchar(10) ='0'	,
	@r9				varchar(10) ='0'	,
	@q3p			varchar(10) ='0'	,
	@q3r			varchar(10) ='0'	,
	@p10			varchar(10) ='0'	,
	@r10			varchar(10) ='0'	,
	@p11			varchar(10) ='0'	,
	@r11			varchar(10) ='0'	,
	@p12			varchar(10) ='0'	,
	@r12			varchar(10) ='0'	,
	@q4p			varchar(10) ='0'	,
	@q4r			varchar(10) ='0'	,
	@s2p			varchar(10) ='0'	,
	@s2r			varchar(10) ='0'	,
	@yp				varchar(10) ='0'	,
	@yr				varchar(10) ='0'	,
	@raw			varchar(10) ='0'	,
	@ass			varchar(10) ='0'	,
	@plp			varchar(10) ='0'	,
	@plr			varchar(10) ='0'	,
	@rusult			varchar(10) ='0'	
	
	
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
			CONVERT(decimal,@p1)			,
			CONVERT(decimal,@r1)			,
			CONVERT(decimal,@p2)			,
			CONVERT(decimal,@r2)			,
			CONVERT(decimal,@p3)			,
			CONVERT(decimal,@r3)			,
			CONVERT(decimal,@q1p)		,
			CONVERT(decimal,@q1r)		,
			CONVERT(decimal,@p4	)		,
			CONVERT(decimal,@r4	)		,
			CONVERT(decimal,@p5	)		,
			CONVERT(decimal,@r5	)		,
			CONVERT(decimal,@p6	)		,
			CONVERT(decimal,@r6	)		,
			CONVERT(decimal,@q2p)		,
			CONVERT(decimal,@q2r)		,
			CONVERT(decimal,@s1p)		,
			CONVERT(decimal,@s1r)		,
			CONVERT(decimal,@p7	)		,
			CONVERT(decimal,@r7	)		,
			CONVERT(decimal,@p8	)		,
			CONVERT(decimal,@r8	)		,
			CONVERT(decimal,@p9	)		,
			CONVERT(decimal,@r9	)		,
			CONVERT(decimal,@q3p)		,
			CONVERT(decimal,@q3r)		,
			CONVERT(decimal,@p10)		,
			CONVERT(decimal,@r10)		,
			CONVERT(decimal,@p11)		,
			CONVERT(decimal,@r11)		,
			CONVERT(decimal,@p12)		,
			CONVERT(decimal,@r12)		,
			CONVERT(decimal,@q4p)		,
			CONVERT(decimal,@q4r)		,
			CONVERT(decimal,@s2p)		,
			CONVERT(decimal,@s2r)		,
			CONVERT(decimal,@yp	)		,
			CONVERT(decimal,@yr	)		,
			CONVERT(decimal,@raw)		,
			CONVERT(decimal,@ass)		,
			CONVERT(decimal,@plp)		,
			CONVERT(decimal,@plr)		,
			CONVERT(decimal,@rusult)	,
			GETDATE()	
		)
	End
Else
	Begin
		update tb_ManagementSub set 
			idx		=@idx		,
			servion	=@servion	,
			p1		=CONVERT(decimal,@p1)		,
			r1		=CONVERT(decimal,@r1)		,
			p2		=CONVERT(decimal,@p2)		,
			r2		=CONVERT(decimal,@r2)		,
			p3		=CONVERT(decimal,@p3)		,
			r3		=CONVERT(decimal,@r3)		,
			q1p		=CONVERT(decimal,@q1p)		,
			q1r		=CONVERT(decimal,@q1r)		,
			p4		=CONVERT(decimal,@p4)		,
			r4		=CONVERT(decimal,@r4	)		,
			p5		=CONVERT(decimal,@p5	)		,
			r5		=CONVERT(decimal,@r5	)		,
			p6		=CONVERT(decimal,@p6	)		,
			r6		=CONVERT(decimal,@r6	)		,
			q2p		=CONVERT(decimal,@q2p)		,
			q2r		=CONVERT(decimal,@q2r)		,
			s1p		=CONVERT(decimal,@s1p)		,
			s1r		=CONVERT(decimal,@s1r)		,
			p7		=CONVERT(decimal,@p7	)		,
			r7		=CONVERT(decimal,@r7	)		,
			p8		=CONVERT(decimal,@p8	)		,
			r8		=CONVERT(decimal,@r8	)		,
			p9		=CONVERT(decimal,@p9	)		,
			r9		=CONVERT(decimal,@r9	)		,
			q3p		=CONVERT(decimal,@q3p)		,
			q3r		=CONVERT(decimal,@q3r)		,
			p10		=CONVERT(decimal,@p10)		,
			r10		=CONVERT(decimal,@r10)		,
			p11		=CONVERT(decimal,@p11)		,
			r11		=CONVERT(decimal,@r11)		,
			p12		=CONVERT(decimal,@p12)		,
			r12		=CONVERT(decimal,@r12)		,
			q4p		=CONVERT(decimal,@q4p)		,
			q4r		=CONVERT(decimal,@q4r)		,
			s2p		=CONVERT(decimal,@s2p)		,
			s2r		=CONVERT(decimal,@s2r)		,
			yp		=CONVERT(decimal,@yp	)		,
			yr		=CONVERT(decimal,@yr	)		,
			raw		=CONVERT(decimal,@raw)		,
			ass		=CONVERT(decimal,@ass)		,
			plp		=CONVERT(decimal,@plp)		,
			plr		=CONVERT(decimal,@plr)		,
			rusult	=CONVERT(decimal,@rusult)	,
		ModDate = GETDATE()
	Where Num =@Num
	End
GO
PRINT N'[dbo].[sp_ManagementSub_Sel]을(를) 만드는 중...';


GO
/* 경영 계획기존 데이터가 있다면*/
CREATE   PROCEDURE [dbo].[sp_ManagementSub_Sel]
	@YYYY Char(4) ='',
	@Servion int =1
AS
Select
ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum,
a.Idx,
isnull(b.Num,0) as Num	,
a.UserId,
RTRIM(c.VDESC) as UserName,
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
left join  CSOPTFD c  on a.UserId=RTRIM(c.VALUE)
Where a.YYYY =@YYYY
and b.servion = @Servion
and  OPTFIELD = 'EMPL'
GO
PRINT N'[dbo].[sp_ManagementSub_SelInit]을(를) 만드는 중...';


GO
/* 경영 계획기존 데이터가 없다면*/
CREATE PROCEDURE [dbo].[sp_ManagementSub_SelInit]
		@YYYY Char(4) =''
AS
Select
ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum,
a.Idx,
isnull(b.Num,0) as Num	,
a.UserId,
RTRIM(c.VDESC) as UserName,
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
left join  CSOPTFD c  on a.UserId=RTRIM(c.VALUE)
Where a.YYYY =@YYYY
and  OPTFIELD = 'EMPL'
GO
PRINT N'[dbo].[sp_User_Del]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_User_Del]
	@UserId		varchar(20) =''
AS
Declare @Errmsg nvarchar(255)
set @Errmsg ='특근관리에 사용자 정보가 있습니다'
	if Not exists(Select  top 1 *
	from tb_Work Where UserId=@UserId)
	Begin
		Delete Tb_User Where UserId =@UserId
		
	End
	Else 
Begin
	RAISERROR (@Errmsg, -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );  
End
GO
PRINT N'[dbo].[sp_User_Ins]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_User_Ins]
	@UserId		Varchar(20)		='',
	@UserName	Varchar(50)		='',
	@UserPwd	Varchar(200)	='',
	@Email		Varchar(250)	='',
	@Retired	bit             =0

AS
	if not exists(Select top 1 * from Tb_User Where UserId=@UserId )
	Begin
		insert Tb_User 
		(
			UserId		,
			UserName	,
			UserPwd		,
			Email		,
			Retired
		)
		Values
		(
			@UserId		,
			@UserName	,
			@UserPwd	,
			@Email		,
			@Retired
		)
	End
	Else 
Begin
		update Tb_User set 
		UserName	=@UserName	,
		UserPwd		=@UserPwd	,
		Email		=@Email		,
		Retired		=@Retired
		Where UserId=@UserId 
		/**/
		if (@Retired =1)
		Begin
			update Tb_User set
			RetiredDay = GETDATE()
			Where UserId=@UserId 
		End
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
Create Proc [dbo].[sp_User_Sel]
@Searchtype Varchar(20) ='', 
@Searchtxt	Varchar(100) ='', 
@pageNum int =1				,
@amount	int =10
As
 
Select rownum
,Num
,UserId
,UserName
,UserPwd
,Email
,LoginDate
,Retired
,(case  Retired  when 'Y' then RetiredDay else null end) RetiredDay
,cnt
from 
(
SELECT 
ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum
,Num
,UserId
,UserName
,UserPwd
,Email
,LoginDate
,(CASE Retired
            WHEN 1 THEN 'Y'
			else 'N' end) as Retired
,RetiredDay 
, (Select count(1) from Tb_User
Where case when @Searchtype='UserName' then [UserName] when @Searchtype='UserId'  then [Userid] when @Searchtype='Email' then [Email] end  like '%'+ @Searchtxt +'%'
) as cnt 
FROM Tb_User
Where case when @Searchtype='UserName' then [UserName] when @Searchtype='UserId'  then [Userid] when @Searchtype='Email' then [Email] end  like '%'+ @Searchtxt +'%'
) Tab 
Where rownum <= @pageNum * @amount
and rownum >(@pageNum-1) * @amount 
ORDER BY Num
GO
PRINT N'[dbo].[sp_Woork_Del]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_Woork_Del]
	@Num		Int =0
AS
	Delete tb_Work Where Num =@Num
GO
PRINT N'[dbo].[sp_Work_ExcelIns]을(를) 만드는 중...';


GO
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
GO
PRINT N'[dbo].[sp_Work_ExcelUp]을(를) 만드는 중...';


GO
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
GO
PRINT N'[dbo].[sp_Work_GetMM]을(를) 만드는 중...';


GO
/*
	sp_Work_GetMM '2022-01-01','2022-05-1'
	월별 합계 위한 쿼리
*/
Create Proc sp_Work_GetMM
@sDay varchar(10) ='',
@eDay varchar(10) =''
As
SELECT 
DATEPART(MM, AttenDay) AS MM -- 월별 
--,DATEPART(mm, AttenDay) AS MM -- 월별 
	from tb_Work
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
group by DATEPART(MM, AttenDay) 
ORDER BY DATEPART(MM, AttenDay) Asc --,UserId Asc
GO
PRINT N'[dbo].[sp_Work_GetWW]을(를) 만드는 중...';


GO
/*
	sp_Work_GetWW '2022-01-01','2022-05-1'
	주별 합계 위한 쿼리
*/
Create Proc sp_Work_GetWW
@sDay varchar(10) ='',
@eDay varchar(10) =''
As
SELECT 
DATEPART(ww, AttenDay) AS WW -- 주별 
--,DATEPART(mm, AttenDay) AS MM -- 월별 
	from tb_Work
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
group by DATEPART(ww, AttenDay) 
ORDER BY DATEPART(ww, AttenDay) Asc --,UserId Asc
GO
PRINT N'[dbo].[sp_Work_GroupSel]을(를) 만드는 중...';


GO
/*
사용자별 근태 화면 조회 sp

*/
Create Proc [dbo].[sp_Work_GroupSel]
@sDay varchar(10) ='',
@eDay varchar(10) =''
AS
Select UserId,UserName,YY,MM,Email
,(Select dbo.fun_GetWoorkTime(UserId,YY+'-'+MM+'-01')) as WoorkTime
,(Select dbo.fun_GetWorkOvertime(UserId,YY+'-'+MM+'-01')) as WorkOvertime
,(Select dbo.fun_GetOvertime(UserId,YY+'-'+MM+'-01')) as Overtime

from 
(
SELECT 
	distinct
	work.UserId
	,users.UserName
	,users.Email
	,SUBSTRING(CONVERT(CHAR(8), AttenDay,112),0,5) as YY
	,SUBSTRING(CONVERT(CHAR(8), AttenDay,112),6,2) as MM
from tb_Work work
join Tb_User users
on work.UserId= users.UserId
Where 
AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
group by users.UserName, work.UserId,work.AttenDay
,users.Email
)tab
GO
PRINT N'[dbo].[sp_Work_Ins]을(를) 만드는 중...';


GO
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
GO
PRINT N'[dbo].[sp_Work_Sel]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_Work_Sel]
	@sDay varchar(10) ='',
	@eDay varchar(10) =''
AS
	SELECT 
	ROW_NUMBER() OVER(ORDER BY DATEPART(ww, AttenDay) Asc ,UserId Asc) AS rownum
,* 
,CASE WHEN(DATEPART(WEEKDAY,AttenDay) = '1') THEN '(일)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '2') THEN '(월)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '3') THEN '(화)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '4') THEN '(수)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '5') THEN '(목)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '6') THEN '(금)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '7') THEN '(토)' END AS DATENA
,DATEPART(ww, AttenDay) AS WW -- 주별 
,DATEPART(mm, AttenDay) AS MM -- 월별 
	from tb_Work
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
ORDER BY DATEPART(ww, AttenDay) Asc ,UserId Asc
GO
PRINT N'[dbo].[sp_Work_UserGetMM]을(를) 만드는 중...';


GO
Create Proc [dbo].[sp_Work_UserGetMM]
@sDay varchar(10) ='',
@eDay varchar(10) ='',
@UserId	varchar(20)=''
As
SELECT 
DATEPART(MM, AttenDay) AS MM -- 월별 
--,DATEPART(mm, AttenDay) AS MM -- 월별 
	from tb_Work
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
and UserId =@UserId
group by DATEPART(MM, AttenDay) 
ORDER BY DATEPART(MM, AttenDay) Asc --,UserId Asc
GO
PRINT N'[dbo].[sp_Work_UserGetWW]을(를) 만드는 중...';


GO
Create Proc [dbo].[sp_Work_UserGetWW]
@sDay varchar(10) ='',
@eDay varchar(10) ='', 
@UserId	varchar(20)=''
As
SELECT 
DATEPART(ww, AttenDay) AS WW -- 주별 
--,DATEPART(mm, AttenDay) AS MM -- 월별 
	from tb_Work
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
and UserId =@UserId
group by DATEPART(ww, AttenDay) 
ORDER BY DATEPART(ww, AttenDay) Asc --,UserId Asc
GO
PRINT N'[dbo].[sp_Work_UserSel]을(를) 만드는 중...';


GO
Create Proc [dbo].[sp_Work_UserSel]
	@sDay varchar(10) ='',
	@eDay varchar(10) ='',
	@UserId	Varchar(20) =''
AS
	SELECT 
	ROW_NUMBER() OVER(ORDER BY DATEPART(ww, AttenDay) Asc ,w.UserId Asc) AS rownum
,w.* 
,CASE WHEN(DATEPART(WEEKDAY,AttenDay) = '1') THEN '(일)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '2') THEN '(월)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '3') THEN '(화)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '4') THEN '(수)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '5') THEN '(목)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '6') THEN '(금)'
            WHEN(DATEPART(WEEKDAY,AttenDay) = '7') THEN '(토)' END AS DATENA
,DATEPART(ww, AttenDay) AS WW -- 주별 
,DATEPART(mm, AttenDay) AS MM -- 월별 
,DATEPART(YY, AttenDay) AS YY -- 월별 
,u.UserName
,u.Email
	from tb_Work w
	left join Tb_User u
	on w.UserId = u.UserId


	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
and w.UserId=@UserId
ORDER BY DATEPART(ww, AttenDay) Asc
GO
PRINT N'업데이트가 완료되었습니다.';


GO
