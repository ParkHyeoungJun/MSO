CREATE PROCEDURE [dbo].[sp_Management_Sel]
AS
	SELECT *
FROM ( 

SELECT ROW_NUMBER() OVER (ORDER BY Idx DESC) AS ROW_NUM, *
FROM tb_ManagementMaster

) T1
Go
