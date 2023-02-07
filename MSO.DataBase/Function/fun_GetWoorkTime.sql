Create FUNCTION dbo.fun_GetWoorkTime (
@UserId varchar(20)=''	,
@sday	Varchar(10)=''
)
RETURNS int
AS
BEGIN

 DECLARE @cnt int;
 SET @cnt = 0;

 BEGIN
  SET @cnt = (
Select SUM(CONVERT(INT,ISNULL(WoorkTime,0)))  
from tb_Work Where UserId=@UserId
and AttenDay between @sday and 
DATEADD(DAY,-1, DATEADD(MONTH,1,@sday)));  
 END
RETURN @cnt;
END
GO
