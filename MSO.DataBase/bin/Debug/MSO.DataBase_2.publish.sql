/*
DEVCOM의 배포 스크립트

이 코드는 도구를 사용하여 생성되었습니다.
파일 내용을 변경하면 잘못된 동작이 발생할 수 있으며, 코드를 다시 생성하면
변경 내용이 손실됩니다.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DEVCOM"
:setvar DefaultFilePrefix "DEVCOM"
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
PRINT N'[dbo].[tb_ManagementMaster]에 대한 명명되지 않은 제약 조건 삭제 중...';


GO
ALTER TABLE [dbo].[tb_ManagementMaster] DROP CONSTRAINT [DF__tb_Manage__RegDa__5A5A5133];


GO
PRINT N'[dbo].[tb_ManagementMaster]에 대한 명명되지 않은 제약 조건 삭제 중...';


GO
ALTER TABLE [dbo].[tb_ManagementMaster] DROP CONSTRAINT [DF__tb_Manage__ModDa__5B4E756C];


GO
PRINT N'[dbo].[Tb_User]에 대한 명명되지 않은 제약 조건 삭제 중...';


GO
ALTER TABLE [dbo].[Tb_User] DROP CONSTRAINT [DF__Tb_User__Retired__61FB72FB];


GO
PRINT N'[dbo].[tb_ManagementSub]에 대한 명명되지 않은 제약 조건 삭제 중...';


GO
ALTER TABLE [dbo].[tb_ManagementSub] DROP CONSTRAINT [DF__tb_Manage__RegDa__2E46C4CB];


GO
PRINT N'[dbo].[tb_ManagementSub]에 대한 명명되지 않은 제약 조건 삭제 중...';


GO
ALTER TABLE [dbo].[tb_ManagementSub] DROP CONSTRAINT [DF__tb_Manage__ModDa__2F3AE904];


GO
PRINT N'[dbo].[tb_ManagementSub]에 대한 명명되지 않은 제약 조건 삭제 중...';


GO
ALTER TABLE [dbo].[tb_ManagementSub] DROP CONSTRAINT [PK__tb_Manag__C7D08B633F428974];


GO
PRINT N'[dbo].[tb_ManagementMaster] 테이블 다시 빌드 시작...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_tb_ManagementMaster] (
    [Idx]           INT           IDENTITY (1, 1) NOT NULL,
    [UserId]        VARCHAR (20)  NULL,
    [UserName]      VARCHAR (20)  NULL,
    [CusttomerCode] VARCHAR (10)  NULL,
    [CusttomerName] VARCHAR (50)  NULL,
    [YYYY]          CHAR (4)      NULL,
    [Ip]            VARCHAR (15)  NULL,
    [RegDate]       SMALLDATETIME DEFAULT (getDate()) NULL,
    [ModDate]       SMALLDATETIME DEFAULT (NULL) NULL,
    PRIMARY KEY CLUSTERED ([Idx] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[tb_ManagementMaster])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_tb_ManagementMaster] ON;
        INSERT INTO [dbo].[tmp_ms_xx_tb_ManagementMaster] ([Idx], [UserId], [CusttomerCode], [CusttomerName], [YYYY], [Ip], [RegDate], [ModDate])
        SELECT   [Idx],
                 [UserId],
                 [CusttomerCode],
                 [CusttomerName],
                 [YYYY],
                 [Ip],
                 [RegDate],
                 [ModDate]
        FROM     [dbo].[tb_ManagementMaster]
        ORDER BY [Idx] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_tb_ManagementMaster] OFF;
    END

DROP TABLE [dbo].[tb_ManagementMaster];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_tb_ManagementMaster]', N'tb_ManagementMaster';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'[dbo].[Tb_User] 변경 중...';


GO
ALTER TABLE [dbo].[Tb_User] ALTER COLUMN [RetiredDay] VARCHAR (10) NULL;


GO
PRINT N'[dbo].[Tb_User]에 대한 명명되지 않은 제약 조건을(를) 만드는 중...';


GO
ALTER TABLE [dbo].[Tb_User]
    ADD DEFAULT (null) FOR [RetiredDay];


GO
PRINT N'[dbo].[func_GetWoorkHoliYN] 변경 중...';


GO
/*
  공휴일 , 토, 일 ,tb_hoilday테이블에 yn=1은 공휴일
  공휴일 여부
*/
ALTER FUNCTION [dbo].[func_GetWoorkHoliYN] (
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
PRINT N'[dbo].[func_GetWoorkTime] 변경 중...';


GO
/*
	평일 하루 근무시간을 알아온다 
	해당 날 출근시간,퇴근시간 하루 근무는 8시간이 최대 
*/
ALTER FUNCTION [dbo].[func_GetWoorkTime] (
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
PRINT N'[dbo].[func_OverTime] 변경 중...';


GO
/*
 평일 야근 시간을 알아 온다 18:30 부터 야근 시간.. 
  퇴근시간에 시간차을 알아 온다 

*/
ALTER FUNCTION dbo.func_OverTime (
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
PRINT N'[dbo].[sp_Management_Init] 변경 중...';


GO
/*
	 마스터 데이터 가지고 오는 화면 

*/
ALTER proc [dbo].[sp_Management_Init]
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
PRINT N'[dbo].[sp_Management_Ins] 변경 중...';


GO
/*
	경영 계획 마스터입력 및 수정 
	idx가 0이면 입력 
	idx 가 0이 아니면 수정 모드
*/
ALTER PROCEDURE [dbo].[sp_Management_Ins]
	@Idx			int		=0							,
	@UserId				varchar(20)		 =''			,
	@CusttomerCode		Varchar(10)		=''				,
	@CusttomerName		Varchar(50)		 =''			,	
	@YYYY				Char(4)			 =''			,
	@Ip					Varchar(15)		 =''
AS
	if not exists(Select top 1 * from tb_ManagementMaster Where UserId=@UserId 	
	and CusttomerCode=@CusttomerCode and CusttomerName =@CusttomerName and YYYY=@YYYY  )
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
			Select @idx= @@IDENTITY
			
			declare @LastVer int;
			set @LastVer=(select max(servion)+1 from tb_ManagementSub ms 
			left join tb_ManagementMaster mm on ms.idx= mm.Idx
			Where mm.YYYY=@YYYY			
			); --where  @LastYear=@YYYY
			

			insert into tb_ManagementSub 		
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
			
			Values(@idx,
			@LastVer	,
			0			,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0		,
			0	,
			GETDATE());


		End
	Else
		Begin
			update tb_ManagementMaster set 			
			ModDate =GETDATE()
			Where UserId=@UserId 	
			and CusttomerCode=@CusttomerCode and CusttomerName =@CusttomerName and YYYY=@YYYY
			Select Idx from tb_ManagementMaster Where UserId=@UserId 	
			and CusttomerCode=@CusttomerCode and CusttomerName =@CusttomerName and YYYY=@YYYY
		End
GO
PRINT N'[dbo].[sp_ManagementMaster_Del] 변경 중...';


GO
ALTER Proc sp_ManagementMaster_Del
	@UserId		varchar(20)	='',
	@CusttomerCode Varchar(10) ='',
	@YYYY		Char(4)=''
As
	Delete tb_ManagementMaster Where UserId =@UserId
	and CusttomerCode =@CusttomerCode
	and YYYY =@YYYY
GO
PRINT N'[dbo].[sp_ManagementSub_GetSubtotal] 변경 중...';


GO
ALTER PROCEDURE [dbo].[sp_ManagementSub_GetSubtotal]
	@YYYY Char(4) =''
AS
Select
count(CusttomerName) as count 
from tb_ManagementMaster a left join tb_ManagementSub b
on a.Idx=b.Idx

Where a.YYYY =@YYYY
and CusttomerName ='Sub Total:'
group by CusttomerName
GO
PRINT N'[dbo].[sp_ManagementSub_InitUser] 변경 중...';


GO
/*
	사용자 아이디 
*/
ALTER PROCEDURE [dbo].[sp_ManagementSub_InitUser]
		@YYYY Char(4) =''
AS
Select
a.UserId

from tb_ManagementMaster a left join tb_ManagementSub b
on a.Idx=b.Idx
Where a.YYYY =@YYYY
group by a.UserId
GO
PRINT N'[dbo].[sp_ManagementSub_Sel] 변경 중...';


GO
/* 경영 계획기존 데이터가 있다면*/




ALTER  PROCEDURE [dbo].[sp_ManagementSub_Sel]
	@YYYY Char(4) ='',
	@Servion int =1
AS
select *

from (

 

        Select

        0 as itype,

        ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum,

        a.Idx,

        isnull(b.Num,0) as Num   ,

        a.UserId,

        RTRIM(c.VDESC) as UserName,

        a.CusttomerCode ,

        a.CusttomerName ,

        b.servion              ,      

        b.p1                   ,

        b.r1                   ,

        b.p2                   ,

        b.r2                   ,

        b.p3                   ,

        b.r3                   ,

        (p1+p2+p3) as q1p      ,

        (r1+r2+r3) as q1r      ,

        b.p4                   ,

        b.r4                   ,

        b.p5                   ,

        b.r5                   ,

        b.p6                   ,

        b.r6                   ,

        (p4+p5+p6) q2p                  ,

        (r4+r5+r6) q2r                  ,

        (p1+p2+p3+p4+p5+p6) as s1p                  ,

        (r1+r2+r3+r4+r5+r6) as s1r                  ,

        b.p7                   ,

        b.r7                   ,

        b.p8                   ,

        b.r8                   ,

        b.p9                   ,

        b.r9                   ,

        (p7+p8+p9) as q3p                  ,

        (r7+r8+r9) as q3r                  ,

        b.p10                  ,

        b.r10                  ,

        b.p11                  ,

        b.r11                  ,

        b.p12                  ,

        b.r12                  ,

        (p10+p11+p12) as q4p                  ,

        (r10+r11+r12) as q4r                  ,

        (p7+p8+p9+p10+p11+p12)as s2p                  ,

        (r7+r8+r9+r10+r11+r12) s2r                  ,

        (p1+p2+p3+p4+p5+p6+p7+p8+p9+p10+p11+p12) as yp                   ,

        (r1+r2+r3+r4+r5+r6+r7+r8+r9+r10+r11+r12) as yr                   ,

        b.raw                  ,

        b.ass                  ,
		
		--b.plp                  ,
        round((p1+p2+p3+p4+p5+p6+p7+p8+p9+p10+p11+p12) * ((100 - (b.raw + b.ass)) / 100), 0) as plp,

        --b.plr                  ,
		round((r1+r2+r3+r4+r5+r6+r7+r8+r9+r10+r11+r12) * ((100 - (b.raw + b.ass)) / 100), 0) as plr,

        --b.rusult
		0 as rusult

        from tb_ManagementMaster a left join tb_ManagementSub b

        on a.Idx=b.Idx

        left join  CSOPTFD c  on a.UserId=RTRIM(c.VALUE)

        Where a.YYYY =@YYYY

        and b.servion = @Servion

        and a.CusttomerName <> 'Sub Total:'
        and  OPTFIELD = 'EMPL'

        union all

 

        Select

        1 as itype,

        1 AS rownum,

        0 as Idx,

        0 as Num ,

        a.UserId,

        '' as UserName,

        '' CusttomerCode ,

        'Sub Total:' as CusttomerName    ,

        b.servion              ,      

        sum(b.p1) as p1                 ,

        sum(b.r1) as r1                 ,

        sum(b.p2) as p2                 ,

        sum(b.r2) as r2                 ,

        sum(b.p3) as p3                 ,

        sum(b.r3) as r3                 ,

        sum(b.q1p) as q1p                      ,

        sum(b.q1r) as q1r                      ,

        sum(b.p4) as p4                 ,

        sum(b.r4) as r4                 ,

        sum(b.p5) as p5                 ,

        sum(b.r5) as r5                 ,

        sum(b.p6) as p6                 ,

        sum(b.r6) as r6                 ,

        sum(b.q2p) as q2p                      ,

        sum(b.q2r) as q2r                      ,

        sum(b.s1p) as s1p                      ,

        sum(b.s1r) as s1r                      ,

        sum(b.p7) as p7                 ,

        sum(b.r7) as r7                 ,

        sum(b.p8) as p8                 ,

        sum(b.r8) as r8                 ,

        sum(b.p9) as p9                 ,

        sum(b.r9) as r9                 ,

        sum(b.q3p) as q3p                      ,

        sum(b.q3r) as q3r                      ,

        sum(b.p10) as p10                      ,

        sum(b.r10) as r10                      ,

        sum(b.p11) as p11                      ,

        sum(b.r11) as r11                      ,

        sum(b.p12) as p12                      ,

        sum(b.r12) as r12                      ,

        sum(b.q4p) as q4p                      ,

        sum(b.q4r) as q4r                      ,

        sum(b.s2p) as s2p                      ,

        sum(b.s2r) as s2r                      ,

        sum(b.yp) as yp                 ,

        sum(b.yr) as yr                 ,

		0 as raw                      ,

		0 as ass                      ,

        sum(b.plp) as plp                      ,

        sum(b.plr) as plr                      ,

        --sum(b.rusult) as result
		case when sum(b.plp) = 0 then 0 else round((sum(b.plr) / sum(b.plp)) * 100, 0) end as result

        from tb_ManagementMaster a left join tb_ManagementSub b

        on a.Idx=b.Idx

        left join  CSOPTFD c  on a.UserId=RTRIM(c.VALUE)

        Where a.YYYY =@YYYY

        and b.servion = @Servion

        and  OPTFIELD = 'EMPL'

        and a.CusttomerName <> 'Sub Total:'

        group by a.UserId, RTRIM(c.VDESC), b.servion    

 

 

        union all

 

        Select

        9 as itype,

        1 AS rownum,

        0 as Idx,

        0 as Num ,

        'ZZZ' as UserId,

        '' as UserName,

        '' CusttomerCode ,

        'Total:' as CusttomerName ,

        b.servion              ,      

        sum(b.p1) as p1                 ,

        sum(b.r1) as r1                 ,

        sum(b.p2) as p2                 ,

        sum(b.r2) as r2                 ,

        sum(b.p3) as p3                 ,

        sum(b.r3) as r3                 ,

        sum(b.q1p) as q1p                      ,

        sum(b.q1r) as q1r                      ,

        sum(b.p4) as p4                 ,

        sum(b.r4) as r4                 ,

        sum(b.p5) as p5                 ,

        sum(b.r5) as r5                 ,

        sum(b.p6) as p6                 ,

        sum(b.r6) as r6                 ,

        sum(b.q2p) as q2p                      ,

        sum(b.q2r) as q2r                      ,

        sum(b.s1p) as s1p                      ,

        sum(b.s1r) as s1r                      ,

        sum(b.p7) as p7                 ,

        sum(b.r7) as r7                 ,

        sum(b.p8) as p8                 ,

        sum(b.r8) as r8                 ,

        sum(b.p9) as p9                 ,

        sum(b.r9) as r9                 ,

        sum(b.q3p) as q3p                      ,

        sum(b.q3r) as q3r                      ,

        sum(b.p10) as p10                      ,

        sum(b.r10) as r10                      ,

        sum(b.p11) as p11                      ,

        sum(b.r11) as r11                      ,

        sum(b.p12) as p12                      ,

        sum(b.r12) as r12                      ,

        sum(b.q4p) as q4p                      ,

        sum(b.q4r) as q4r                      ,

        sum(b.s2p) as s2p                      ,

        sum(b.s2r) as s2r                      ,

        sum(b.yp) as yp                 ,

        sum(b.yr) as yr                 ,

        0 as raw                      ,

        0 as ass                      ,

        sum(b.plp) as plp                      ,

        sum(b.plr) as plr                      ,

        0 as result

        from tb_ManagementMaster a left join tb_ManagementSub b

        on a.Idx=b.Idx

        left join  CSOPTFD c  on a.UserId=RTRIM(c.VALUE)

        Where a.YYYY =@YYYY

        and b.servion = @Servion

        and  OPTFIELD = 'EMPL'

        and a.CusttomerName <> 'Sub Total:'

        group by b.servion     

 

) a

order by UserId, itype, CusttomerCode Asc
GO
PRINT N'[dbo].[sp_CostSales_Sel] 변경 중...';


GO
ALTER PROCEDURE [dbo].[sp_CostSales_Sel]
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
PRINT N'[dbo].[sp_GetWoorkOverTime] 변경 중...';


GO
/*
	야근 및 특근 계산 알고리즘 
	exec sp_GetWoorkOverTime '2022-04-05 20:30'

*/
ALTER PROCEDURE [dbo].[sp_GetWoorkOverTime]
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
PRINT N'[dbo].[sp_GetWoorkTime] 변경 중...';


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
ALTER proc [sp_GetWoorkTime] 
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
PRINT N'[dbo].[sp_Holiday_Get] 변경 중...';


GO
/****** SSMS의 SelectTopNRows 명령 스크립트 ******/
ALTER Proc sp_Holiday_Get
@HoliDay varchar(8) ='10'
As 
SELECT *
	FROM [Tb_Holiday]
		Where HoliDay =@HoliDay
GO
PRINT N'[dbo].[sp_Holiday_GetYear] 변경 중...';


GO
ALTER Proc sp_Holiday_GetYear
	@yyyy varchar(4) =''
As
SELECT 
Num
,CASE WHEN YN =1 THEN 'Y' ELSE 'N' END YN
,Title
,HoliDay
,RegDate
,ModDate
	FROM [Tb_Holiday] Where 
	HoliDay between @yyyy+'-01-01'
	and DATEADD(DAY,-1, DATEADD(MONTH,1,@yyyy+'-12-31'))
order by HoliDay asc
GO
PRINT N'[dbo].[sp_Holiday_Sel] 변경 중...';


GO
/****** SSMS의 SelectTopNRows 명령 스크립트 ******/
ALTER Proc sp_Holiday_Sel
@month varchar(8) =''
As 
SELECT Num as id 
      ,[Title] as title
      ,[HoliDay] as start
	FROM [Tb_Holiday]
		Where HoliDay between @month+'-01'
	and DATEADD(DAY,-1, DATEADD(MONTH,1,@month+'-01'))
GO
PRINT N'[dbo].[sp_Work_GetWW] 변경 중...';


GO
/*
	sp_Work_GetWW '2022-01-01','2022-05-1'
	주별 합계 위한 쿼리
*/
ALTER Proc sp_Work_GetWW
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
PRINT N'[dbo].[sp_User_Login]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_User_Login]
	@param1 int = 0,
	@param2 int
AS
	SELECT @param1, @param2
RETURN 0
GO
PRINT N'[dbo].[sp_Management_Del] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_Management_Del]';


GO
PRINT N'[dbo].[sp_Management_List] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_Management_List]';


GO
PRINT N'[dbo].[sp_Management_Sel] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_Management_Sel]';


GO
PRINT N'[dbo].[sp_ManagementMaster_List] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_ManagementMaster_List]';


GO
PRINT N'[dbo].[sp_ManagementSub_GetVersion] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_ManagementSub_GetVersion]';


GO
PRINT N'[dbo].[sp_ManagementSub_SelInit] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_ManagementSub_SelInit]';


GO
PRINT N'[dbo].[sp_Work_GroupSel] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_Work_GroupSel]';


GO
PRINT N'[dbo].[sp_User_Del] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_User_Del]';


GO
PRINT N'[dbo].[sp_User_Ins] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_User_Ins]';


GO
PRINT N'[dbo].[sp_User_Sel] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_User_Sel]';


GO
PRINT N'[dbo].[sp_Work_UserSel] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_Work_UserSel]';


GO
PRINT N'[dbo].[sp_Work_ExcelUp] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_Work_ExcelUp]';


GO
PRINT N'[dbo].[sp_Work_Ins] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_Work_Ins]';


GO
PRINT N'업데이트가 완료되었습니다.';


GO
