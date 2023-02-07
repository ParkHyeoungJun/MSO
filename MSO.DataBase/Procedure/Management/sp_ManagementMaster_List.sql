Create Proc [dbo].[sp_ManagementMaster_List]
@UserId		Varchar(20) =''	,
@YYYY		Char(4)		=''
As
Select * from tb_ManagementMaster
Where YYYY =@YYYY and UserId =@UserId
and CusttomerName <> 'Sub Total:'
Go