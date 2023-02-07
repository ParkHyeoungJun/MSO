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
Go