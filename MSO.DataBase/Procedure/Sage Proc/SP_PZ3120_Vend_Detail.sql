CREATE PROC [dbo].[SP_PZ3120_Vend_Detail]
	@sAP		VARCHAR(3),		-- AP처리여부(Yes / No)
	@sDocNo		VARCHAR(22),	-- 문서번호
	@iDocType	SMALLINT		-- 문서유형
AS

IF @sAP = 'Yes'
BEGIN

	IF @iDocType = 1
	BEGIN

		SELECT B.DETAILNUM AS LINENUM, RTRIM(B.ITEMNO) AS ITEM, RTRIM(B.ITEMDESC) AS ITEMNAME, B.SQRECEIVED AS QTY, B.RCPUNIT AS UNIT, B.UNITCOST, B.EXTENDED AS AMOUNT
		FROM POINVH1 A
		INNER JOIN POINVL B ON A.INVHSEQ = B.INVHSEQ
		WHERE A.INVNUMBER = @sDocNo
		ORDER BY B.DETAILNUM

	END
	ELSE
	BEGIN

		SELECT B.DETAILNUM AS LINENUM, RTRIM(B.ITEMNO) AS ITEM, RTRIM(B.ITEMDESC) AS ITEMNAME, B.SQRETURNED AS QTY, B.RETUNIT AS UNIT, B.UNITCOST, B.EXTENDED AS AMOUNT
		FROM POCRNH1 A
		INNER JOIN POCRNL B ON A.CRNHSEQ = B.CRNHSEQ
		WHERE A.CRNNUMBER = @sDocNo
		ORDER BY B.DETAILNUM

	END
END
ELSE
BEGIN

	SELECT A.LINENUM, A.ITEM, A.ITEMNAME, SUM(A.QTY) AS QTY, A.UNIT, A.UNITCOST, SUM(A.AMOUNT) AS AMOUNT
	FROM (

		SELECT B.DETAILNUM AS LINENUM, RTRIM(B.ITEMNO) AS ITEM, RTRIM(B.ITEMDESC) AS ITEMNAME, B.SQOUTSTAND AS QTY, B.ORDERUNIT AS UNIT, B.UNITCOST, B.EXTENDED AS AMOUNT
		FROM POPORH1 A
		LEFT OUTER JOIN POPORL B ON A.PORHSEQ = B.PORHSEQ
		WHERE A.PONUMBER = @sDocNo

		UNION ALL

		SELECT B.DETAILNUM AS LINENUM, RTRIM(B.ITEMNO) AS ITEM, RTRIM(B.ITEMDESC) AS ITEMNAME, B.SQRECEIVED AS QTY, B.RCPUNIT AS UNIT, B.UNITCOST, B.EXTENDED AS AMOUNT
		FROM PORCPH1	A
		LEFT OUTER JOIN PORCPL B ON A.RCPHSEQ = B.RCPHSEQ
		WHERE B.RCPHSEQ IS NOT NULL AND A.ISINVOICED = 0
			AND A.PONUMBER = @sDocNo			
	) A
	GROUP BY A.LINENUM, A.ITEM, A.ITEMNAME, A.UNIT, A.UNITCOST
	ORDER BY A.LINENUM
END
Go