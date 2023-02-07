/*
UATCOM의 배포 스크립트

이 코드는 도구를 사용하여 생성되었습니다.
파일 내용을 변경하면 잘못된 동작이 발생할 수 있으며, 코드를 다시 생성하면
변경 내용이 손실됩니다.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "UATCOM"
:setvar DefaultFilePrefix "UATCOM"
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
PRINT N'[dbo].[sp_Management_Ins] 변경 중...';


GO
/*
	경영 계획 마스터입력 및 수정 
	idx가 0이면 입력 
	idx 가 0이 아니면 수정 모드
*/
ALTER  PROCEDURE [dbo].[sp_Management_Ins]
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
			Select @@IDENTITY
		End
	Else
		Begin
			update tb_ManagementMaster set 			
			ModDate =GETDATE()
			Where UserId=@UserId 	
			and CusttomerCode=@CusttomerCode and CusttomerName =@CusttomerName and YYYY=@YYYY
		End
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
ALTER   PROCEDURE [dbo].[sp_ManagementSub_Sel]
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
PRINT N'[dbo].[sp_ManagementSub_SelInit] 변경 중...';


GO
/* 경영 계획기존 데이터가 없다면*/
ALTER PROCEDURE [dbo].[sp_ManagementSub_SelInit]
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
order by UserId ,CusttomerCode Asc
GO
PRINT N'업데이트가 완료되었습니다.';


GO
