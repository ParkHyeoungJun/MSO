Create Proc sp_ManagementMaster_Del
	@UserId		varchar(20)	='',
	@CusttomerCode Varchar(10) ='',
	@YYYY		Char(4)=''
As
	Delete tb_ManagementMaster Where UserId =@UserId
	and CusttomerCode =@CusttomerCode
	and YYYY =@YYYY
Go
