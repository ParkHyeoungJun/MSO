CREATE PROCEDURE [dbo].[sp_ManagementSub_GetVersion]
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

Go