Create Proc [dbo].[sp_User_Sel]
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
