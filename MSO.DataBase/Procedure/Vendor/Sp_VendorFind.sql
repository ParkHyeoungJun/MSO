create Proc Sp_VendorFind
@Searchtype Varchar(20) ='', 
@Searchtxt	Varchar(100) ='', 
@pageNum int =1				,
@amount	int =10
As
Select * from
(
SELECT 
ROW_NUMBER() OVER(ORDER BY (RTRIM(VENDORID))) AS rownum,
RTRIM(VENDORID) AS VENDORID, 
RTRIM(VENDNAME) AS VENDNAME, 
RTRIM(IDTAXREGI1) AS TAXREGNO, 
RTRIM(TEXTSTRE1) AS ADDR1, 
RTRIM(TEXTSTRE2) AS ADDR2, 
RTRIM(CODEPSTL) AS CODEPSTL, 
TRIM(NAMECTAC) AS NAMECTAC, 
RTRIM(TEXTPHON1) AS PHONE,
RTRIM(EMAIL1) AS EMAIL
,(select count(1) from 
APVEN
Where 
Case when TRIM(@Searchtype)='VENDORID' then RTRIM(RTRIM(VENDORID)) 
	when TRIM(@Searchtype)='VENDNAME' then RTRIM(VENDNAME)
	when TRIM(@Searchtype)='TAXREGNO' then RTRIM(IDTAXREGI1)
	when TRIM(@Searchtype)='ADDR1' then RTRIM(TEXTSTRE1)
	when TRIM(@Searchtype)='ADDR2' then RTRIM(TEXTSTRE2)
	when TRIM(@Searchtype)='CODEPSTL' then RTRIM(CODEPSTL)
	when TRIM(@Searchtype)='CODEPSTL' then RTRIM(CODEPSTL)
	when TRIM(@Searchtype)='NAMECTAC' then RTRIM(NAMECTAC)
	when TRIM(@Searchtype)='PHONE' then RTRIM(TEXTPHON1)
	when TRIM(@Searchtype)='EMAIL' then RTRIM(EMAIL1)
end like '%'+ @Searchtxt + '%'
) as cnt
FROM APVEN
Where 
Case when TRIM(@Searchtype)='VENDORID' then RTRIM(RTRIM(VENDORID)) 
	when TRIM(@Searchtype)='VENDNAME' then RTRIM(VENDNAME)
	when TRIM(@Searchtype)='TAXREGNO' then RTRIM(IDTAXREGI1)
	when TRIM(@Searchtype)='ADDR1' then RTRIM(TEXTSTRE1)
	when TRIM(@Searchtype)='ADDR2' then RTRIM(TEXTSTRE2)
	when TRIM(@Searchtype)='CODEPSTL' then RTRIM(CODEPSTL)
	when TRIM(@Searchtype)='CODEPSTL' then RTRIM(CODEPSTL)
	when TRIM(@Searchtype)='NAMECTAC' then RTRIM(NAMECTAC)
	when TRIM(@Searchtype)='PHONE' then RTRIM(TEXTPHON1)
	when TRIM(@Searchtype)='EMAIL' then RTRIM(EMAIL1)
end like '%'+ @Searchtxt + '%'
) tab 
Where rownum <= @pageNum * @amount
and rownum >(@pageNum-1) * @amount 
ORDER BY VENDORID

Go