/*
 사원 검색 
*/

--exec sp_EmpFind 'NAMECUST','',2,10

Create Proc [dbo].[sp_EmpFind]
@Searchtype Varchar(20) ='', 
@Searchtxt	Varchar(100) ='', 
@pageNum int =1				,
@amount	int =10
As
 
Select * from 
(
SELECT 
ROW_NUMBER() OVER(ORDER BY (IDCUST)) AS rownum,
RTRIM(IDCUST) AS IDCUST,				-- 거래첱코드
RTRIM(NAMECUST) AS NAMECUST,			-- 거래처명
RTRIM(IDTAXREGI1) AS TAXREGNO,			-- 사업자번호
RTRIM(TEXTSTRE1) AS ADDR1,				-- 주소1
RTRIM(TEXTSTRE2) AS ADDR2,				-- 주서2
RTRIM(CODEPSTL) AS CODEPSTL,			--우편번호
TRIM(NAMECTAC) AS NAMECTAC,				--담당자
RTRIM(TEXTPHON1) AS PHONE, RTRIM(EMAIL1) AS EMAIL -- 이메일
,(select COUNT(1) from ARCUS bb
Where 
Case when TRIM(@Searchtype)='IDCUST' then IDCUST 
	when TRIM(@Searchtype)='NAMECUST' then NAMECUST
	when TRIM(@Searchtype)='IDTAXREGI1' then bb.IDTAXREGI1
	when TRIM(@Searchtype)='TEXTSTRE1' then TEXTSTRE1
	when TRIM(@Searchtype)='TEXTSTRE2' then TEXTSTRE2
	when TRIM(@Searchtype)='CODEPSTL' then CODEPSTL
	when TRIM(@Searchtype)='NAMECTAC' then NAMECTAC
end like '%'+ @Searchtxt + '%'


) as cnt 
FROM ARCUS
) tab
Where 
Case when TRIM(@Searchtype)='IDCUST' then IDCUST 
	when TRIM(@Searchtype)='NAMECUST' then NAMECUST
	when TRIM(@Searchtype)='IDTAXREGI1' then TAXREGNO
	when TRIM(@Searchtype)='TEXTSTRE1' then ADDR1
	when TRIM(@Searchtype)='TEXTSTRE2' then ADDR2
	when TRIM(@Searchtype)='CODEPSTL' then CODEPSTL
	when TRIM(@Searchtype)='NAMECTAC' then NAMECTAC
end like '%'+ @Searchtxt + '%'
and rownum <= @pageNum * @amount
and rownum >(@pageNum-1) * @amount 
Go