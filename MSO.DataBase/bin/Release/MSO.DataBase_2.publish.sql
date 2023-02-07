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
PRINT N'[dbo].[Tb_User]에 대한 명명되지 않은 제약 조건 삭제 중...';


GO
ALTER TABLE [dbo].[Tb_User] DROP CONSTRAINT [DF__Tb_User__Retired__48CFD27E];


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
PRINT N'[dbo].[sp_User_Ins] 변경 중...';


GO
ALTER PROCEDURE [dbo].[sp_User_Ins]
	@UserId		Varchar(20)		='',
	@UserName	Varchar(50)		='',
	@UserPwd	Varchar(200)	='',
	@Email		Varchar(250)	='',
	@Retired	bit             =0,
	@RetiredDay	varchar(10)=''
AS
	if not exists(Select top 1 * from Tb_User Where UserId=@UserId )
	Begin
		insert Tb_User 
		(
			UserId		,
			UserName	,
			UserPwd		,
			Email		,
			Retired		,
			RetiredDay
		)
		Values
		(
			@UserId		,
			@UserName	,
			@UserPwd	,
			@Email		,
			@Retired	, 
			@RetiredDay
		)
	End
	Else 
Begin
		update Tb_User set 
		UserName	=@UserName	,
		UserPwd		=@UserPwd	,
		Email		=@Email		,
		Retired		=@Retired	, 
		RetiredDay  =@RetiredDay
		Where UserId=@UserId 
		
End
GO
PRINT N'[dbo].[sp_User_Sel] 변경 중...';


GO
ALTER Proc [dbo].[sp_User_Sel]
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
,(case  Retired  when 'Y' then CONVERT(CHAR(10), RetiredDay, 23) else null end) RetiredDay
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
PRINT N'[dbo].[sp_Work_UserSel] 변경 중...';


GO
ALTER Proc [dbo].[sp_Work_UserSel]
	@sDay varchar(10) ='',
	@eDay varchar(10) ='',
	@UserId	Varchar(20) =''
AS
	Select * from 
(
	SELECT 
	0 as itype
	,ROW_NUMBER() OVER(ORDER BY DATEPART(ww, AttenDay) Asc ,w.UserId Asc) AS rownum
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

union all 
SELECT 
1 as itype
,0 AS rownum
,null Num
,'주간 합계' as UserId
,'' AttenDay
,'' AttenTime
,'' LeaveTime
,sum(CONVERT(int ,Overtime)) as Overtime
,sum(CONVERT(int ,WorkOvertime)) as WorkOvertime
,sum(CONVERT(int ,WoorkTime)) as WoorkTime
,getdate() as  Regdate
,getdate() as Moddate

,'' AS DATENA
,DATEPART(ww, AttenDay) AS WW -- 주별 
,'' AS MM -- 월별 
,'' AS YY -- 월별 
,'주간 합계' UserName
,'' Email
	from tb_Work w
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
and w.UserId=@UserId
group by w.UserId, DATEPART(ww, AttenDay)

union all

SELECT 
9 as itype
,0 AS rownum
,null Num
,'월간 합계' as UserId
,'' AttenDay
,'' AttenTime
,'' LeaveTime
,sum(CONVERT(int ,Overtime)) as Overtime
,sum(CONVERT(int ,WorkOvertime)) as WorkOvertime
,sum(CONVERT(int ,WoorkTime)) as WoorkTime
,getdate() as  Regdate
,getdate() as Moddate

,'' AS DATENA
,9999 AS WW -- 주별 
,'' AS MM -- 월별 
,'' AS YY -- 월별 
,'월간 합계' UserName
,'' Email
	from tb_Work w
	Where 
	AttenDay between @sDay and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@eDay))
and w.UserId=@UserId
group by w.UserId, DATEPART(MM, AttenDay)

)tab

ORDER BY  WW,itype--, Regdate Asc,itype desc 
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
PRINT N'[dbo].[sp_ManagementMaster_List] 변경 중...';


GO
ALTER Proc [dbo].[sp_ManagementMaster_List]
@UserId		Varchar(20) =''	,
@YYYY		Char(4)		=''
As
Select * from tb_ManagementMaster
Where YYYY =@YYYY and UserId =@UserId
and CusttomerName <> 'Sub Total:'
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
PRINT N'[dbo].[sp_CustomerFind]을(를) 만드는 중...';


GO
Create Proc sp_CustomerFind
@Searchtype Varchar(20) ='', 
@Searchtxt	Varchar(100) ='', 
@pageNum int =1				,
@amount	int =10
As
Select * from (
SELECT 
ROW_NUMBER() OVER(ORDER BY (RTRIM(IDCUST))) AS rownum,
RTRIM(IDCUST) AS IDCUST, 
RTRIM(NAMECUST) AS NAMECUST, 
RTRIM(IDTAXREGI1) AS TAXREGNO, 
RTRIM(TEXTSTRE1) AS ADDR1, 
RTRIM(TEXTSTRE2) AS ADDR2, 
RTRIM(CODEPSTL) AS CODEPSTL, 
TRIM(NAMECTAC) AS NAMECTAC, 
RTRIM(TEXTPHON1) AS PHONE, 
RTRIM(EMAIL1) AS EMAIL
,(select count(1) FROM ARCUS
Where 
Case when TRIM(@Searchtype)='IDCUST' then RTRIM(RTRIM(IDCUST)) 
	when TRIM(@Searchtype)='NAMECUST' then RTRIM(NAMECUST)
	when TRIM(@Searchtype)='TAXREGNO' then RTRIM(IDTAXREGI1)
	when TRIM(@Searchtype)='ADDR1' then RTRIM(TEXTSTRE1)
	when TRIM(@Searchtype)='ADDR2' then RTRIM(TEXTSTRE2)
	when TRIM(@Searchtype)='CODEPSTL' then RTRIM(CODEPSTL)
	when TRIM(@Searchtype)='CODEPSTL' then RTRIM(CODEPSTL)
	when TRIM(@Searchtype)='NAMECTAC' then RTRIM(NAMECTAC)
	when TRIM(@Searchtype)='PHONE' then RTRIM(TEXTPHON1)
	when TRIM(@Searchtype)='EMAIL' then RTRIM(EMAIL1)
end like '%'+ @Searchtxt + '%') as cnt
FROM ARCUS
Where 
Case when TRIM(@Searchtype)='IDCUST' then RTRIM(RTRIM(IDCUST)) 
	when TRIM(@Searchtype)='NAMECUST' then RTRIM(NAMECUST)
	when TRIM(@Searchtype)='TAXREGNO' then RTRIM(IDTAXREGI1)
	when TRIM(@Searchtype)='ADDR1' then RTRIM(TEXTSTRE1)
	when TRIM(@Searchtype)='ADDR2' then RTRIM(TEXTSTRE2)
	when TRIM(@Searchtype)='CODEPSTL' then RTRIM(CODEPSTL)
	when TRIM(@Searchtype)='CODEPSTL' then RTRIM(CODEPSTL)
	when TRIM(@Searchtype)='NAMECTAC' then RTRIM(NAMECTAC)
	when TRIM(@Searchtype)='PHONE' then RTRIM(TEXTPHON1)
	when TRIM(@Searchtype)='EMAIL' then RTRIM(EMAIL1)
end like '%'+ @Searchtxt + '%'
) tab 
Where rownum <= @pageNum * @amount
and rownum >(@pageNum-1) * @amount 
ORDER BY IDCUST
GO
PRINT N'[dbo].[sp_Holiday_Get]을(를) 만드는 중...';


GO
/****** SSMS의 SelectTopNRows 명령 스크립트 ******/
Create Proc sp_Holiday_Get
@HoliDay varchar(8) ='10'
As 
SELECT *
	FROM [Tb_Holiday]
		Where HoliDay =@HoliDay
GO
PRINT N'[dbo].[sp_Holiday_GetYear]을(를) 만드는 중...';


GO
Create Proc sp_Holiday_GetYear
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
PRINT N'[dbo].[sp_ItemFind]을(를) 만드는 중...';


GO
Create Proc sp_ItemFind
@Searchtype Varchar(20) ='', 
@Searchtxt	Varchar(100) ='', 
@pageNum int =1				,
@amount	int =10
As
Select * from 
(
SELECT
ROW_NUMBER() OVER(ORDER BY (ITEMNO)) AS rownum,
RTRIM(A.FMTITEMNO) AS ITEMNO, --품목코드
RTRIM(A.[DESC]) AS ITEMNAME, --품목명칭
RTRIM(A.STOCKUNIT) AS UNIT, -- 단위
RTRIM(A.CNTLACCT) AS ACCTSET, --계정 집합
RTRIM(B.[DESC]) AS ACCTSETDESC,-- 계정 집합 명칭 
CASE WHEN LOTITEM = 0 THEN 'No' ELSE 'Yes' END LOTITEM -- LOT 품목여부
,( select count(1) from ICITEM A
LEFT OUTER JOIN ICACCT B ON A.CNTLACCT = B.CNTLACCT
Where 
Case when TRIM(@Searchtype)='ITEMNO' then RTRIM(A.FMTITEMNO) 
	when TRIM(@Searchtype)='ITEMNAME' then RTRIM(A.[DESC])
	when TRIM(@Searchtype)='UNIT' then RTRIM(A.STOCKUNIT)
	when TRIM(@Searchtype)='ACCTSET' then RTRIM(A.CNTLACCT)	
end like '%'+ @Searchtxt + '%'
) as cnt

FROM ICITEM A
LEFT OUTER JOIN ICACCT B ON A.CNTLACCT = B.CNTLACCT
Where 
Case when TRIM(@Searchtype)='ITEMNO' then RTRIM(A.FMTITEMNO) 
	when TRIM(@Searchtype)='ITEMNAME' then RTRIM(A.[DESC])
	when TRIM(@Searchtype)='UNIT' then RTRIM(A.STOCKUNIT)
	when TRIM(@Searchtype)='ACCTSET' then RTRIM(A.CNTLACCT)	
end like '%'+ @Searchtxt + '%'
) tab 
Where rownum <= @pageNum * @amount
and rownum >(@pageNum-1) * @amount 
ORDER BY tab.ITEMNO
GO
PRINT N'[dbo].[sp_ManagementSub_GetSubtotal]을(를) 만드는 중...';


GO
CREATE PROCEDURE [dbo].[sp_ManagementSub_GetSubtotal]
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
PRINT N'[dbo].[SP_OZ3120_Cust]을(를) 만드는 중...';


GO
CREATE PROC [dbo].[SP_OZ3120_Cust]
	@sDate_F  CHAR(8),		-- 매출일자_FROM
	@sDate_T  CHAR(8),		-- 매출일자_TO
	@sCust_F  VARCHAR(24),	-- 판매처_FROM
	@sCust_T  VARCHAR(24)	-- 판매처_TO
AS


SELECT RTRIM(A.CUSTOMER) AS CUSTOMER, RTRIM(A.NAMECUST) AS NAMECUST, RTRIM(A.PONUMBER) AS PONUMBER, RTRIM(A.ORDNUMBER) AS ORDNUMBER, A.ORDDATE,
	A.ORDAMT, --A.ORDETAXTOT, A.ORDNETWTX,
	A.DOCTYPE, RTRIM(A.INVNUMBER) AS INVNUMBER, A.INVDATE, A.INVSUBTOT, --A.INVETAXTOT, A.INVNETWTX,
	A.AR, A.ARTYPE
FROM (
	--Invoice
	SELECT A.CUSTOMER, B.NAMECUST, A.PONUMBER, A.ORDNUMBER, A.ORDDATE,
		ISNULL(ORD.ORDAMT, 0) AS ORDAMT, 0 AS ORDETAXTOT, 0 AS ORDNETWTX, 1 AS DOCTYPE, A.INVNUMBER, A.INVDATE, A.INVSUBTOT, 0 AS INVETAXTOT, 0 AS INVNETWTX,
		'Yes' AS AR, ISNULL(OPT.VDESC, '') AS ARTYPE
	FROM OEINVH A
	LEFT OUTER JOIN ARCUS B ON A.CUSTOMER = B.IDCUST
	LEFT OUTER JOIN OEINVHO ARTYPE ON A.INVUNIQ = ARTYPE.INVUNIQ AND ARTYPE.OPTFIELD = 'SALESTYPE'
	LEFT OUTER JOIN CSOPTFD OPT ON ARTYPE.OPTFIELD = OPT.OPTFIELD AND ARTYPE.[VALUE] = OPT.[VALUE]
	LEFT OUTER JOIN (
		SELECT A.ORDNUMBER, SUM(CASE WHEN B.LINETYPE = 1 THEN (ISNULL(B.QTYBACKORD, 0) + ISNULL(B.QTYSHPTODT, 0)) * ISNULL(B.UNITPRICE, 0) ELSE ISNULL(B.EXTINVMISC, 0) END) AS ORDAMT
		FROM OEORDH A
		LEFT OUTER JOIN OEORDD B ON A.ORDUNIQ = B.ORDUNIQ
		GROUP BY A.ORDNUMBER
	) ORD ON A.ORDNUMBER = ORD.ORDNUMBER
	WHERE A.INVDATE BETWEEN @sDate_F AND @sDate_T
		AND A.CUSTOMER BETWEEN @sCust_F AND @sCust_T

	UNION ALL

	--Credit/Debit
	SELECT A.CUSTOMER, B.NAMECUST, A.PONUMBER, A.ORDNUMBER, A.ORDDATE,
		ISNULL(ORD.ORDAMT, 0) AS ORDAMT, 0 AS ORDETAXTOT, 0 AS ORDNETWTX, CASE WHEN A.ADJTYPE = 1 THEN 3 ELSE 2 END AS DOCTYPE, A.CRDNUMBER, A.CRDDATE, (A.CRDSUBTOT * CASE WHEN A.ADJTYPE = 1 THEN -1 ELSE 1 END) CRDSUBTOT, (A.CRDETAXTOT * CASE WHEN A.ADJTYPE = 1 THEN -1 ELSE 1 END) CRDETAXTOT, (A.CRDNETWTX * CASE WHEN A.ADJTYPE = 1 THEN -1 ELSE 1 END) CRDNETWTX,
		'Yes' AS AR, ISNULL(OPT.VDESC, '') AS ARTYPE
	FROM OECRDH A
	LEFT OUTER JOIN ARCUS B ON A.CUSTOMER = B.IDCUST
	LEFT OUTER JOIN OECRDHO ARTYPE ON A.CRDUNIQ = ARTYPE.CRDUNIQ AND ARTYPE.OPTFIELD = 'SALESTYPE'
	LEFT OUTER JOIN CSOPTFD OPT ON ARTYPE.OPTFIELD = OPT.OPTFIELD AND ARTYPE.[VALUE] = OPT.[VALUE]
	LEFT OUTER JOIN (
		SELECT A.ORDNUMBER, SUM(CASE WHEN B.LINETYPE = 1 THEN (ISNULL(B.QTYBACKORD, 0) + ISNULL(B.QTYSHPTODT, 0)) * ISNULL(B.UNITPRICE, 0) ELSE ISNULL(B.EXTINVMISC, 0) END) AS ORDAMT
		FROM OEORDH A
		LEFT OUTER JOIN OEORDD B ON A.ORDUNIQ = B.ORDUNIQ
		GROUP BY A.ORDNUMBER
	) ORD ON A.ORDNUMBER = ORD.ORDNUMBER
	WHERE A.CRDDATE BETWEEN @sDate_F AND @sDate_T
		AND A.CUSTOMER BETWEEN @sCust_F AND @sCust_T

	UNION ALL

	--ORDER
	SELECT A.CUSTOMER, A.NAMECUST, A.PONUMBER, A.ORDNUMBER, A.ORDDATE,
		SUM(A.ORDAMT) AS ORDAMT, SUM(A.ORDETAXTOT) AS ORDETAXTOT, SUM(A.ORDNETWTX) AS ORDNETWTX, 9 AS DOCTYPE, '' AS INVNUMBER, 0 AS INVDATE, 0 AS INVSUBTOT, 0 AS INVETAXTOT, 0 AS INVNETWTX,
		'No' AS AR, A.ARTYPE
	FROM (

		SELECT A.CUSTOMER, B.NAMECUST, A.PONUMBER, A.ORDNUMBER, A.ORDDATE, A.INVSUBTOT AS ORDAMT, A.INVETAXTOT AS ORDETAXTOT, A.INVNETWTX AS ORDNETWTX, ISNULL(OPT.VDESC, '') AS ARTYPE
		FROM OEORDH A
		LEFT OUTER JOIN ARCUS B ON A.CUSTOMER = B.IDCUST
		LEFT OUTER JOIN OEORDHO ARTYPE ON A.ORDUNIQ = ARTYPE.ORDUNIQ AND ARTYPE.OPTFIELD = 'SALESTYPE'
		LEFT OUTER JOIN CSOPTFD OPT ON ARTYPE.OPTFIELD = OPT.OPTFIELD AND ARTYPE.[VALUE] = OPT.[VALUE]
		WHERE A.INVSUBTOT <> 0

		UNION ALL

		SELECT A.CUSTOMER, B.NAMECUST, A.PONUMBER, A.ORDNUMBER, A.ORDDATE, A.SHISUBTOT AS ORDAMT, A.SHIETAXTOT AS ORDETAXTOT, A.SHINETWTX AS ORDNETWTX, ISNULL(OPT.VDESC, '') AS ARTYPE
		FROM OESHIH	A
		LEFT OUTER JOIN ARCUS B ON A.CUSTOMER = B.IDCUST
		LEFT OUTER JOIN OESHIHO ARTYPE ON A.SHIUNIQ = ARTYPE.SHIUNIQ AND ARTYPE.OPTFIELD = 'SALESTYPE'
		LEFT OUTER JOIN CSOPTFD OPT ON ARTYPE.OPTFIELD = OPT.OPTFIELD AND ARTYPE.[VALUE] = OPT.[VALUE]
		WHERE NUMINVOICE = 0

	) A
	WHERE A.CUSTOMER BETWEEN @sCust_F AND @sCust_T
	GROUP BY A.CUSTOMER, A.NAMECUST, A.PONUMBER, A.ORDNUMBER, A.ORDDATE, A.ARTYPE

) A 
ORDER BY A.AR DESC, A.CUSTOMER, A.ORDDATE, A.INVDATE
GO
PRINT N'[dbo].[SP_OZ3120_Cust_Items]을(를) 만드는 중...';


GO
CREATE PROC [dbo].[SP_OZ3120_Cust_Items]
	@sDate_F  CHAR(8),		-- 매출일자_FROM
	@sDate_T  CHAR(8),		-- 매출일자_TO
	@sItem_F  VARCHAR(24),	-- 품목코드_FROM
	@sItem_T  VARCHAR(24)	-- 품목코드_TO
AS


SELECT RTRIM(A.ITEM) AS ITEMNO, RTRIM(ISNULL(ITEM.[DESC], MISC.[DESC])) AS ITEMDESC, SUM(A.ORDAMT) AS ORDAMT, SUM(A.EXTINVMISC) AS EXTINVMISC, A.AR, A.ARTYPE
FROM (
	--Invoice
	SELECT CASE WHEN B.LINETYPE = 1 THEN B.ITEM ELSE B.MISCCHARGE END ITEM, ISNULL(ORD.ORDAMT, 0) AS ORDAMT, B.EXTINVMISC, 'Yes' AS AR, ISNULL(OPT.VDESC, '') AS ARTYPE
	FROM OEINVH A
	LEFT OUTER JOIN OEINVD B ON A.INVUNIQ = B.INVUNIQ
	LEFT OUTER JOIN OEINVHO ARTYPE ON A.INVUNIQ = ARTYPE.INVUNIQ AND ARTYPE.OPTFIELD = 'SALESTYPE'
	LEFT OUTER JOIN CSOPTFD OPT ON ARTYPE.OPTFIELD = OPT.OPTFIELD AND ARTYPE.[VALUE] = OPT.[VALUE]
	LEFT OUTER JOIN (
		SELECT CASE WHEN B.LINETYPE = 1 THEN B.ITEM ELSE B.MISCCHARGE END ITEM, SUM(CASE WHEN B.LINETYPE = 1 THEN (ISNULL(B.QTYBACKORD, 0) + ISNULL(B.QTYSHPTODT, 0)) * ISNULL(B.UNITPRICE, 0) ELSE ISNULL(B.EXTINVMISC, 0) END) AS ORDAMT
		FROM OEORDH A
		LEFT OUTER JOIN OEORDD B ON A.ORDUNIQ = B.ORDUNIQ
		WHERE B.ORDUNIQ IS NOT NULL
		GROUP BY CASE WHEN B.LINETYPE = 1 THEN B.ITEM ELSE B.MISCCHARGE END
	) ORD ON CASE WHEN B.LINETYPE = 1 THEN B.ITEM ELSE B.MISCCHARGE END = ORD.ITEM
	WHERE A.INVDATE BETWEEN @sDate_F AND @sDate_T
		AND B.ITEM BETWEEN @sItem_F AND @sItem_T

	UNION ALL

	--Credit/Debit
	SELECT CASE WHEN B.LINETYPE = 1 THEN B.ITEM ELSE B.MISCCHARGE END ITEM, ISNULL(ORD.ORDAMT, 0) AS ORDAMT, (B.EXTCRDMISC * CASE WHEN A.ADJTYPE = 1 THEN -1 ELSE 1 END) EXTCRDMISC, 'Yes' AS AR, ISNULL(OPT.VDESC, '') AS ARTYPE
	FROM OECRDH A
	LEFT OUTER JOIN OECRDD B ON A.CRDUNIQ = B.CRDUNIQ
	LEFT OUTER JOIN OECRDHO ARTYPE ON A.CRDUNIQ = ARTYPE.CRDUNIQ AND ARTYPE.OPTFIELD = 'SALESTYPE'
	LEFT OUTER JOIN CSOPTFD OPT ON ARTYPE.OPTFIELD = OPT.OPTFIELD AND ARTYPE.[VALUE] = OPT.[VALUE]
	LEFT OUTER JOIN (
		SELECT CASE WHEN B.LINETYPE = 1 THEN B.ITEM ELSE B.MISCCHARGE END ITEM, SUM(CASE WHEN B.LINETYPE = 1 THEN (ISNULL(B.QTYBACKORD, 0) + ISNULL(B.QTYSHPTODT, 0)) * ISNULL(B.UNITPRICE, 0) ELSE ISNULL(B.EXTINVMISC, 0) END) AS ORDAMT
		FROM OEORDH A
		LEFT OUTER JOIN OEORDD B ON A.ORDUNIQ = B.ORDUNIQ
		WHERE B.ORDUNIQ IS NOT NULL
		GROUP BY CASE WHEN B.LINETYPE = 1 THEN B.ITEM ELSE B.MISCCHARGE END
	) ORD ON CASE WHEN B.LINETYPE = 1 THEN B.ITEM ELSE B.MISCCHARGE END = ORD.ITEM
	WHERE A.CRDDATE BETWEEN @sDate_F AND @sDate_T
		AND B.ITEM BETWEEN @sItem_F AND @sItem_T

	UNION ALL

	--ORDER
	SELECT A.ITEM, SUM(A.ORDAMT) AS ORDAMT, 0 AS INVSUBTOT, 'No' AS AR, A.ARTYPE
	FROM (

		SELECT CASE WHEN B.LINETYPE = 1 THEN B.ITEM ELSE B.MISCCHARGE END ITEM, B.EXTINVMISC AS ORDAMT, ISNULL(OPT.VDESC, '') AS ARTYPE
		FROM OEORDH A
		LEFT OUTER JOIN OEORDD B ON A.ORDUNIQ = B.ORDUNIQ
		LEFT OUTER JOIN OEORDHO ARTYPE ON A.ORDUNIQ = ARTYPE.ORDUNIQ AND ARTYPE.OPTFIELD = 'SALESTYPE'
		LEFT OUTER JOIN CSOPTFD OPT ON ARTYPE.OPTFIELD = OPT.OPTFIELD AND ARTYPE.[VALUE] = OPT.[VALUE]
		WHERE A.INVSUBTOT <> 0

		UNION ALL

		SELECT CASE WHEN B.LINETYPE = 1 THEN B.ITEM ELSE B.MISCCHARGE END ITEM, B.EXTSHIMISC AS ORDAMT, ISNULL(OPT.VDESC, '') AS ARTYPE
		FROM OESHIH	A
		LEFT OUTER JOIN OESHID B ON A.SHIUNIQ = B.SHIUNIQ
		LEFT OUTER JOIN OESHIHO ARTYPE ON A.SHIUNIQ = ARTYPE.SHIUNIQ AND ARTYPE.OPTFIELD = 'SALESTYPE'
		LEFT OUTER JOIN CSOPTFD OPT ON ARTYPE.OPTFIELD = OPT.OPTFIELD AND ARTYPE.[VALUE] = OPT.[VALUE]
		WHERE NUMINVOICE = 0

	) A
	WHERE A.ITEM BETWEEN @sItem_F AND @sItem_T
	GROUP BY A.ITEM, A.ARTYPE

) A
LEFT OUTER JOIN ICITEM ITEM ON A.ITEM = ITEM.FMTITEMNO
LEFT OUTER JOIN OEMISC MISC ON A.ITEM = MISC.MISCCHARGE
GROUP BY A.ITEM, RTRIM(ISNULL(ITEM.[DESC], MISC.[DESC])), A.AR, A.ARTYPE
ORDER BY A.AR DESC, A.ITEM
GO
PRINT N'[dbo].[SP_PZ3120_Vend]을(를) 만드는 중...';


GO
CREATE PROC [dbo].[SP_PZ3120_Vend]
	@sDate_F  CHAR(8),		-- 매입일자_FROM
	@sDate_T  CHAR(8),		-- 매입일자_TO
	@sVend_F  VARCHAR(24),	-- 구매처_FROM
	@sVend_T  VARCHAR(24)	-- 구매처_TO
AS


SELECT A.VDCODE, A.VENDNAME, A.PONUMBER, A.PODATE,
	A.POAMT, --A.POETAXTOT, A.PONETWTX,
	A.DOCTYPE, A.INVNUMBER, A.INVDATE, A.INVSUBTOT, --A.INVETAXTOT, A.INVNETWTX,
	A.AP
FROM (
	--Invoice
	SELECT A.VDCODE, B.VENDNAME, A.PONUMBER, ISNULL(PO.PODATE, 0) AS PODATE,
		ISNULL(PO.POAMT, 0) AS POAMT, 0 AS POETAXTOT, 0 AS PONETWTX, 1 AS DOCTYPE, A.INVNUMBER, A.[DATE] AS INVDATE, A.EXTENDED AS INVSUBTOT, A.TAXAMOUNT AS INVETAXTOT, A.DOCTOTAL AS INVNETWTX, 'Yes' AS AP
	FROM POINVH1 A
	LEFT OUTER JOIN APVEN B ON A.VDCODE = B.VENDORID
	LEFT OUTER JOIN (
		SELECT A.PONUMBER, A.[DATE] AS PODATE, SUM(A.EXTENDED + A.EXTRECEIVE) AS POAMT
		FROM POPORH1 A
		LEFT OUTER JOIN POPORL B ON A.PORHSEQ = B.PORHSEQ
		GROUP BY A.PONUMBER, A.[DATE]
	) PO ON A.PONUMBER = PO.PONUMBER
	WHERE A.[DATE] BETWEEN @sDate_F AND @sDate_T
		AND A.VDCODE BETWEEN @sVend_F AND @sVend_T

	UNION ALL

	--Credit/Debit
	SELECT A.VDCODE, B.VENDNAME, A.PONUMBER, ISNULL(PO.PODATE, 0) AS PODATE, ISNULL(PO.POAMT, 0) AS POAMT, 0 AS POETAXTOT, 0 AS PONETWTX, CASE WHEN A.TRANSTYPE = 6 THEN 3 ELSE 2 END AS DOCTYPE, A.CRNNUMBER, A.[DATE] AS INVDATE,
		(A.EXTENDED * CASE WHEN A.TRANSTYPE = 6 THEN -1 ELSE 1 END) AS CRDSUBTOT, (A.TAXAMOUNT * CASE WHEN A.TRANSTYPE = 6 THEN -1 ELSE 1 END) AS INVETAXTOT, (A.DOCTOTAL * CASE WHEN A.TRANSTYPE = 6 THEN -1 ELSE 1 END) AS INVNETWTX, 'Yes' AS AP
	FROM POCRNH1 A
	LEFT OUTER JOIN APVEN B ON A.VDCODE = B.VENDORID
	LEFT OUTER JOIN (
		SELECT A.PONUMBER, A.[DATE] AS PODATE, SUM(A.EXTENDED + A.EXTRECEIVE) AS POAMT
		FROM POPORH1 A
		LEFT OUTER JOIN POPORL B ON A.PORHSEQ = B.PORHSEQ
		GROUP BY A.PONUMBER, A.[DATE]
	) PO ON A.PONUMBER = PO.PONUMBER
	WHERE A.[DATE] BETWEEN @sDate_F AND @sDate_T
		AND A.VDCODE BETWEEN @sVend_F AND @sVend_T

	UNION ALL

	--PURCHASE ORDER

	SELECT A.VDCODE, A.VENDNAME, A.PONUMBER, A.PODATE,
		SUM(A.POAMT) AS POAMT, 0 AS POETAXTOT, 0 AS PONETWTX, 9 AS DOCTYPE, '' AS INVNUMBER, 0 AS INVDATE, 0 AS INVSUBTOT, 0 AS INVETAXTOT, 0 AS INVNETWTX, 'No' AS AP
	FROM (

		SELECT A.VDCODE, B.VENDNAME, A.PONUMBER, A.[DATE] AS PODATE, EXTENDED AS POAMT, 0 AS POETAXTOT, 0 AS PONETWTX
		FROM POPORH1 A
		LEFT OUTER JOIN APVEN B ON A.VDCODE = B.VENDORID
		WHERE A.EXTENDED <> 0
			AND A.VDCODE BETWEEN @sVend_F AND @sVend_T

		UNION ALL

		SELECT A.VDCODE, B.VENDNAME, A.PONUMBER, A.[DATE] AS PODATE, EXTENDED AS POAMT, 0 AS POETAXTOT, 0 AS PONETWTX
		FROM PORCPH1 A
		LEFT OUTER JOIN APVEN B ON A.VDCODE = B.VENDORID
		WHERE A.ISINVOICED = 0
			AND A.VDCODE BETWEEN @sVend_F AND @sVend_T
	) A
	GROUP BY A.VDCODE, A.VENDNAME, A.PONUMBER, A.PODATE

) A 
ORDER BY A.VDCODE, A.PODATE, A.INVDATE
GO
PRINT N'[dbo].[SP_PZ3120_Vend_Items]을(를) 만드는 중...';


GO
CREATE PROC [dbo].[SP_PZ3120_Vend_Items]
	@sDate_F  CHAR(8),		-- 매입일자_FROM
	@sDate_T  CHAR(8),		-- 매입일자_TO
	@sVend_F  VARCHAR(24),	-- 구매처_FROM
	@sVend_T  VARCHAR(24)	-- 구매처_TO
AS


SELECT A.VDCODE, A.VENDNAME, A.PONUMBER, A.PODATE,
	A.POAMT, --A.POETAXTOT, A.PONETWTX,
	A.DOCTYPE, A.INVNUMBER, A.INVDATE, A.INVSUBTOT, --A.INVETAXTOT, A.INVNETWTX,
	A.AP
FROM (
	--Invoice
	SELECT A.VDCODE, B.VENDNAME, A.PONUMBER, ISNULL(PO.PODATE, 0) AS PODATE,
		ISNULL(PO.POAMT, 0) AS POAMT, 0 AS POETAXTOT, 0 AS PONETWTX, 1 AS DOCTYPE, A.INVNUMBER, A.[DATE] AS INVDATE, A.EXTENDED AS INVSUBTOT, A.TAXAMOUNT AS INVETAXTOT, A.DOCTOTAL AS INVNETWTX, 'Yes' AS AP
	FROM POINVH1 A
	LEFT OUTER JOIN APVEN B ON A.VDCODE = B.VENDORID
	LEFT OUTER JOIN (
		SELECT A.PONUMBER, A.[DATE] AS PODATE, SUM(A.EXTENDED + A.EXTRECEIVE) AS POAMT
		FROM POPORH1 A
		LEFT OUTER JOIN POPORL B ON A.PORHSEQ = B.PORHSEQ
		GROUP BY A.PONUMBER, A.[DATE]
	) PO ON A.PONUMBER = PO.PONUMBER
	WHERE A.[DATE] BETWEEN @sDate_F AND @sDate_T
		AND A.VDCODE BETWEEN @sVend_F AND @sVend_T

	UNION ALL

	--Credit/Debit
	SELECT A.VDCODE, B.VENDNAME, A.PONUMBER, ISNULL(PO.PODATE, 0) AS PODATE, ISNULL(PO.POAMT, 0) AS POAMT, 0 AS POETAXTOT, 0 AS PONETWTX, CASE WHEN A.TRANSTYPE = 6 THEN 3 ELSE 2 END AS DOCTYPE, A.CRNNUMBER, A.[DATE] AS INVDATE,
		(A.EXTENDED * CASE WHEN A.TRANSTYPE = 6 THEN -1 ELSE 1 END) AS CRDSUBTOT, (A.TAXAMOUNT * CASE WHEN A.TRANSTYPE = 6 THEN -1 ELSE 1 END) AS INVETAXTOT, (A.DOCTOTAL * CASE WHEN A.TRANSTYPE = 6 THEN -1 ELSE 1 END) AS INVNETWTX, 'Yes' AS AP
	FROM POCRNH1 A
	LEFT OUTER JOIN APVEN B ON A.VDCODE = B.VENDORID
	LEFT OUTER JOIN (
		SELECT A.PONUMBER, A.[DATE] AS PODATE, SUM(A.EXTENDED + A.EXTRECEIVE) AS POAMT
		FROM POPORH1 A
		LEFT OUTER JOIN POPORL B ON A.PORHSEQ = B.PORHSEQ
		GROUP BY A.PONUMBER, A.[DATE]
	) PO ON A.PONUMBER = PO.PONUMBER
	WHERE A.[DATE] BETWEEN @sDate_F AND @sDate_T
		AND A.VDCODE BETWEEN @sVend_F AND @sVend_T

	UNION ALL

	--PURCHASE ORDER

	SELECT A.VDCODE, A.VENDNAME, A.PONUMBER, A.PODATE,
		SUM(A.POAMT) AS POAMT, 0 AS POETAXTOT, 0 AS PONETWTX, 9 AS DOCTYPE, '' AS INVNUMBER, 0 AS INVDATE, 0 AS INVSUBTOT, 0 AS INVETAXTOT, 0 AS INVNETWTX, 'No' AS AP
	FROM (

		SELECT A.VDCODE, B.VENDNAME, A.PONUMBER, A.[DATE] AS PODATE, EXTENDED AS POAMT, 0 AS POETAXTOT, 0 AS PONETWTX
		FROM POPORH1 A
		LEFT OUTER JOIN APVEN B ON A.VDCODE = B.VENDORID
		WHERE A.EXTENDED <> 0
			AND A.VDCODE BETWEEN @sVend_F AND @sVend_T

		UNION ALL

		SELECT A.VDCODE, B.VENDNAME, A.PONUMBER, A.[DATE] AS PODATE, EXTENDED AS POAMT, 0 AS POETAXTOT, 0 AS PONETWTX
		FROM PORCPH1 A
		LEFT OUTER JOIN APVEN B ON A.VDCODE = B.VENDORID
		WHERE A.ISINVOICED = 0
			AND A.VDCODE BETWEEN @sVend_F AND @sVend_T
	) A
	GROUP BY A.VDCODE, A.VENDNAME, A.PONUMBER, A.PODATE

) A 
ORDER BY A.VDCODE, A.PODATE, A.INVDATE
GO
PRINT N'[dbo].[Sp_VendorFind]을(를) 만드는 중...';


GO
create Proc Sp_VendorFind
@Searchtype Varchar(20) ='', 
@Searchtxt	Varchar(100) ='', 
@pageNum int =1				,
@amount	int =10
As
Select * from
(
SELECT 
ROW_NUMBER() OVER(ORDER BY (RTRIM(VENDORID))) AS rownum,
RTRIM(VENDORID) AS VENDORID, 
RTRIM(VENDNAME) AS VENDNAME, 
RTRIM(IDTAXREGI1) AS TAXREGNO, 
RTRIM(TEXTSTRE1) AS ADDR1, 
RTRIM(TEXTSTRE2) AS ADDR2, 
RTRIM(CODEPSTL) AS CODEPSTL, 
TRIM(NAMECTAC) AS NAMECTAC, 
RTRIM(TEXTPHON1) AS PHONE,
RTRIM(EMAIL1) AS EMAIL
,(select count(1) from 
APVEN
Where 
Case when TRIM(@Searchtype)='VENDORID' then RTRIM(RTRIM(VENDORID)) 
	when TRIM(@Searchtype)='VENDNAME' then RTRIM(VENDNAME)
	when TRIM(@Searchtype)='TAXREGNO' then RTRIM(IDTAXREGI1)
	when TRIM(@Searchtype)='ADDR1' then RTRIM(TEXTSTRE1)
	when TRIM(@Searchtype)='ADDR2' then RTRIM(TEXTSTRE2)
	when TRIM(@Searchtype)='CODEPSTL' then RTRIM(CODEPSTL)
	when TRIM(@Searchtype)='CODEPSTL' then RTRIM(CODEPSTL)
	when TRIM(@Searchtype)='NAMECTAC' then RTRIM(NAMECTAC)
	when TRIM(@Searchtype)='PHONE' then RTRIM(TEXTPHON1)
	when TRIM(@Searchtype)='EMAIL' then RTRIM(EMAIL1)
end like '%'+ @Searchtxt + '%'
) as cnt
FROM APVEN
Where 
Case when TRIM(@Searchtype)='VENDORID' then RTRIM(RTRIM(VENDORID)) 
	when TRIM(@Searchtype)='VENDNAME' then RTRIM(VENDNAME)
	when TRIM(@Searchtype)='TAXREGNO' then RTRIM(IDTAXREGI1)
	when TRIM(@Searchtype)='ADDR1' then RTRIM(TEXTSTRE1)
	when TRIM(@Searchtype)='ADDR2' then RTRIM(TEXTSTRE2)
	when TRIM(@Searchtype)='CODEPSTL' then RTRIM(CODEPSTL)
	when TRIM(@Searchtype)='CODEPSTL' then RTRIM(CODEPSTL)
	when TRIM(@Searchtype)='NAMECTAC' then RTRIM(NAMECTAC)
	when TRIM(@Searchtype)='PHONE' then RTRIM(TEXTPHON1)
	when TRIM(@Searchtype)='EMAIL' then RTRIM(EMAIL1)
end like '%'+ @Searchtxt + '%'
) tab 
Where rownum <= @pageNum * @amount
and rownum >(@pageNum-1) * @amount 
ORDER BY VENDORID
GO
PRINT N'[dbo].[sp_Work_GroupSel] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_Work_GroupSel]';


GO
PRINT N'[dbo].[sp_User_Del] 새로 고침...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[sp_User_Del]';


GO
PRINT N'업데이트가 완료되었습니다.';


GO
