/*
	사용자 아이디 
*/
CREATE PROCEDURE [dbo].[sp_ManagementSub_InitUser]
		@YYYY Char(4) =''
AS
Select
a.UserId

from tb_ManagementMaster a left join tb_ManagementSub b
on a.Idx=b.Idx
Where a.YYYY =@YYYY
group by a.UserId
Go
