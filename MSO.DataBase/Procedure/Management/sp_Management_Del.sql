/*
	경영 계획 삭제 
*/
CREATE PROCEDURE [dbo].[sp_Management_Del]
	@Idx			int		=0
AS
	Delete tb_ManagementMaster Where idx =@Idx	
