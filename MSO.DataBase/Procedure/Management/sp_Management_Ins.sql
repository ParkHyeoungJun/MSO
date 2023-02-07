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
			set @LastVer=(select max(servion) from tb_ManagementSub ms 
			left join tb_ManagementMaster mm on ms.idx= mm.Idx
			Where mm.YYYY=@YYYY			
			); --where  @LastYear=@YYYY
			set @LastVer = isnull(@LastVer,0);
			if(@LastVer <>0)
				Begin

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
Go
