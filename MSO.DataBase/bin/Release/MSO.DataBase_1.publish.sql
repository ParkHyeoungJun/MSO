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
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


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
PRINT N'[dbo].[sp_ManagementSub_GetVersion] 변경 중...';


GO
ALTER PROCEDURE [dbo].[sp_ManagementSub_GetVersion]
	@YYYY	char(4) =''	
AS
  SET NOCOUNT ON;
Declare @servion varchar(10)
Select * from(
Select ma.servion as servion from tb_ManagementSub  ma 
left join tb_ManagementMaster ms
on ma.Idx=ms.Idx
Where ms.YYYY =@YYYY
Group by ma.servion
)tab
order by servion
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
PRINT N'[dbo].[sp_ManagementSub_Ins] 변경 중...';


GO
ALTER proc [dbo].[sp_ManagementSub_Ins]
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
If not exists (Select top 1 * from tb_ManagementSub Where idx =@idx and servion =@servion) 
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
			--idx		=@idx		,
			--servion	=@servion	,
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
		Where idx		=@idx
			and servion	=@servion
	End
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

        b.plp                  ,

        b.plr                  ,

        b.rusult

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

        sum(b.raw) as raw                      ,

        sum(b.ass) as ass                      ,

        sum(b.plp) as plp                      ,

        sum(b.plr) as plr                      ,

        sum(b.rusult) as result

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

        sum(b.raw) as raw                      ,

        sum(b.ass) as ass                      ,

        sum(b.plp) as plp                      ,

        sum(b.plr) as plr                      ,

        sum(b.rusult) as result

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
PRINT N'[dbo].[sp_ManagementSub_SelInit] 변경 중...';


GO
/* 경영 계획기존 데이터가 없다면*/
ALTER PROCEDURE [dbo].[sp_ManagementSub_SelInit]
		@YYYY Char(4) =''
AS
Select * from 
(
    Select
        0 as itype												,
        ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum		,
        a.Idx													,
        0 as Num									,
        a.UserId												,
        RTRIM(c.VDESC) as UserName								,
        a.CusttomerCode											,
        a.CusttomerName											,
        '' servion												,     
        0 as p1													,
        0 as r1													,
        0 as p2													,
        0 as r2													,
        0 as p3													,
        0 as r3													,
        0 as q1p													,
        0 as q1r													,
        0 as p4													,
        0 as r4													,
        0 as p5													,
        0 as r5													,
        0 as p6													,
        0 as r6													,
        0 as q2p													,
        0 as q2r													,
        0 as s1p													,
        0 as s1r													,
        0 as p7													,
        0 as r7													,
        0 as p8													,
        0 as r8													,
        0 as p9													,
        0 as r9													,
        0 as q3p													,
        0 as q3r													,
        0 as p10													,
        0 as r10													,
        0 as p11													,
        0 as r11													,
        0 as p12													,
        0 as r12													,
        0 as q4p													,
        0 as q4r													,
        0 as s2p													,
        0 as s2r													,
        0 as yp													,
        0 as yr													,
        0 as raw													,
        0 as ass													,
        0 as plp													,
        0 as plr													,
        0 as rusult
        from tb_ManagementMaster a 
        left join  CSOPTFD c  on a.UserId=RTRIM(c.VALUE)
        Where a.YYYY =@YYYY        
        and  OPTFIELD = 'EMPL'

		union all

		
		Select
        0 as itype												,
        0  AS rownum		,
        0 as Idx													,
        0 as Num									,
        a.UserId												,
        '' as UserName								,
        '' as CusttomerCode											,
        'Sub Total:' CusttomerName											,
        '' servion												,     
        0 as p1													,
        0 as r1													,
        0 as p2													,
        0 as r2													,
        0 as p3													,
        0 as r3													,
        0 as q1p													,
        0 as q1r													,
        0 as p4													,
        0 as r4													,
        0 as p5													,
        0 as r5													,
        0 as p6													,
        0 as r6													,
        0 as q2p													,
        0 as q2r													,
        0 as s1p													,
        0 as s1r													,
        0 as p7													,
        0 as r7													,
        0 as p8													,
        0 as r8													,
        0 as p9													,
        0 as r9													,
        0 as q3p													,
        0 as q3r													,
        0 as p10													,
        0 as r10													,
        0 as p11													,
        0 as r11													,
        0 as p12													,
        0 as r12													,
        0 as q4p													,
        0 as q4r													,
        0 as s2p													,
        0 as s2r													,
        0 as yp													,
        0 as yr													,
        0 as raw													,
        0 as ass													,
        0 as plp													,
        0 as plr													,
        0 as rusult
        from tb_ManagementMaster a 
        Where a.YYYY =@YYYY 
		group by a.UserId

		union all 

		Select
        9 as itype												,
        0  AS rownum		,
        0 as Idx													,
        0 as Num									,
        'ZZZ' UserId												,
        'ZZZ' as UserName								,
        '' as CusttomerCode											,
        'Total:' CusttomerName											,
        '' servion												,     
        0 as p1													,
        0 as r1													,
        0 as p2													,
        0 as r2													,
        0 as p3													,
        0 as r3													,
        0 as q1p													,
        0 as q1r													,
        0 as p4													,
        0 as r4													,
        0 as p5													,
        0 as r5													,
        0 as p6													,
        0 as r6													,
        0 as q2p													,
        0 as q2r													,
        0 as s1p													,
        0 as s1r													,
        0 as p7													,
        0 as r7													,
        0 as p8													,
        0 as r8													,
        0 as p9													,
        0 as r9													,
        0 as q3p													,
        0 as q3r													,
        0 as p10													,
        0 as r10													,
        0 as p11													,
        0 as r11													,
        0 as p12													,
        0 as r12													,
        0 as q4p													,
        0 as q4r													,
        0 as s2p													,
        0 as s2r													,
        0 as yp													,
        0 as yr													,
        0 as raw													,
        0 as ass													,
        0 as plp													,
        0 as plr													,
        0 as rusult
)tab
order by UserId   Asc,CusttomerName ,itype DESC
GO
PRINT N'업데이트가 완료되었습니다.';


GO
