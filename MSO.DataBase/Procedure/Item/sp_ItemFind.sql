Create Proc [dbo].[sp_ItemFind]
@Searchtype Varchar(20) ='', 
@Searchtxt	Varchar(100) ='', 
@pageNum int =1				,
@amount	int =10
As


Select * 
from (

	SELECT 	ROW_NUMBER() OVER(ORDER BY (ITEMNO)) AS rownum,
			A.ITEMNO, --품목코드
			A.ITEMNAME, --품목명칭
			A.UNIT, -- 단위
			A.ACCTSET, --계정 집합
			A.ACCTSETDESC,-- 계정 집합 명칭 
			A.LOTITEM,
			(
				SELECT SUM(A.REC_CNT)
				FROM (
					SELECT	COUNT(*) AS REC_CNT
					FROM ICITEM A
					LEFT OUTER JOIN ICACCT B ON A.CNTLACCT = B.CNTLACCT
					Where 
					Case when TRIM(@Searchtype)='ITEMNO' then RTRIM(A.FMTITEMNO) 
						when TRIM(@Searchtype)='ITEMNAME' then RTRIM(A.[DESC])
						when TRIM(@Searchtype)='UNIT' then RTRIM(A.STOCKUNIT)
						when TRIM(@Searchtype)='ACCTSET' then RTRIM(A.CNTLACCT)	
					end like '%'+ @Searchtxt + '%'
					UNION ALL
					SELECT COUNT(*)  AS REC_CNT
					FROM OEMISC A
					Where 
					Case when TRIM(@Searchtype)='ITEMNO' then RTRIM(A.MISCCHARGE) 
						when TRIM(@Searchtype)='ITEMNAME' then RTRIM(A.[DESC])
					end like '%'+ @Searchtxt + '%'
				) A

			) CNT
	FROM (

		SELECT		
			RTRIM(A.FMTITEMNO) AS ITEMNO, --품목코드
			RTRIM(A.[DESC]) AS ITEMNAME, --품목명칭
			RTRIM(A.STOCKUNIT) AS UNIT, -- 단위
			RTRIM(A.CNTLACCT) AS ACCTSET, --계정 집합
			RTRIM(B.[DESC]) AS ACCTSETDESC,-- 계정 집합 명칭 
			CASE WHEN LOTITEM = 0 THEN 'No' ELSE 'Yes' END LOTITEM -- LOT 품목여부
		FROM ICITEM A
		LEFT OUTER JOIN ICACCT B ON A.CNTLACCT = B.CNTLACCT
		Where 
		Case when TRIM(@Searchtype)='ITEMNO' then RTRIM(A.FMTITEMNO) 
			when TRIM(@Searchtype)='ITEMNAME' then RTRIM(A.[DESC])
			when TRIM(@Searchtype)='UNIT' then RTRIM(A.STOCKUNIT)
			when TRIM(@Searchtype)='ACCTSET' then RTRIM(A.CNTLACCT)	
		end like '%'+ @Searchtxt + '%'

		UNION ALL

		SELECT RTRIM(A.MISCCHARGE) AS ITEMNO, RTRIM(A.[DESC]) AS ITEMNAME, '' AS UNIT, '' AS ACCTSET, '' AS ACCTSETDESC, 'No' AS LOTITEM
		FROM OEMISC A
		Where 
		Case when TRIM(@Searchtype)='ITEMNO' then RTRIM(A.MISCCHARGE) 
			when TRIM(@Searchtype)='ITEMNAME' then RTRIM(A.[DESC])
		end like '%'+ @Searchtxt + '%'

	) A

) tab 

Where rownum <= @pageNum * @amount
and rownum >(@pageNum-1) * @amount 
ORDER BY tab.ITEMNO

Go

