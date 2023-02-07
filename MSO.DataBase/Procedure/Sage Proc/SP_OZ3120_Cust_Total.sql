﻿CREATE PROC [dbo].[SP_OZ3120_Cust_Total]
	@sDate_F	CHAR(8),		-- 매출일자_FROM
	@sDate_T	CHAR(8),		-- 매출일자_TO
	@sCust_F	VARCHAR(24),	-- 판매처_FROM
	@sCust_T	VARCHAR(24)	-- 판매처_TO

AS
Begin

	SELECT
	SUM(CASE WHEN A.AR = 'Yes' THEN A.COGS ELSE 0 END) AS COGS,
	SUM(CASE WHEN A.AR = 'Yes' THEN A.INVSUBTOT ELSE 0 END) AS INVSUBTOT,
	SUM(CASE WHEN A.AR = 'No' THEN A.ORDAMT ELSE 0 END) AS ORDAMT,
	SUM(CASE WHEN A.AR = 'Yes' THEN A.INVSUBTOT ELSE ORDAMT END) AS TOTALAMT
	FROM (
		--Invoice
		SELECT A.CUSTOMER, B.NAMECUST, A.PONUMBER, A.ORDNUMBER, A.ORDDATE,
			ISNULL(ORD.ORDAMT, 0) AS ORDAMT, 0 AS ORDETAXTOT, 0 AS ORDNETWTX, 1 AS DOCTYPE, A.INVNUMBER, A.INVDATE, AA.COGS, A.INVSUBTOT, 0 AS INVETAXTOT, 0 AS INVNETWTX,
			'Yes' AS AR, ISNULL(OPT.VDESC, '') AS ARTYPE
		FROM OEINVH A
		LEFT OUTER JOIN (
			SELECT INVUNIQ, SUM(EXTICOST) AS COGS
			FROM OEINVD
			GROUP BY INVUNIQ
		) AA ON A.INVUNIQ = AA.INVUNIQ
		LEFT OUTER JOIN ARCUS B ON A.CUSTOMER = B.IDCUST
		LEFT OUTER JOIN OEINVHO ARTYPE ON A.INVUNIQ = ARTYPE.INVUNIQ AND ARTYPE.OPTFIELD = 'SALESTYPE'
		LEFT OUTER JOIN CSOPTFD OPT ON ARTYPE.OPTFIELD = OPT.OPTFIELD AND ARTYPE.[VALUE] = OPT.[VALUE]
		LEFT OUTER JOIN (
			SELECT A.ORDNUMBER, SUM(CASE WHEN B.LINETYPE = 1 THEN (ISNULL(B.QTYBACKORD, 0) + ISNULL(B.QTYSHPTODT, 0)) * ISNULL(B.UNITPRICE, 0) ELSE ISNULL(B.EXTINVMISC, 0) END) AS ORDAMT
			FROM OEORDH A
			LEFT OUTER JOIN OEORDD B ON A.ORDUNIQ = B.ORDUNIQ
			GROUP BY A.ORDNUMBER
		) ORD ON A.ORDNUMBER = ORD.ORDNUMBER
		WHERE A.INVDATE BETWEEN @sDate_F AND @sDate_T
			AND A.CUSTOMER BETWEEN @sCust_F AND @sCust_T

		UNION ALL

		--Credit/Debit
		SELECT A.CUSTOMER, B.NAMECUST, A.PONUMBER, A.ORDNUMBER, A.ORDDATE,
			ISNULL(ORD.ORDAMT, 0) AS ORDAMT, 0 AS ORDETAXTOT, 0 AS ORDNETWTX, CASE WHEN A.ADJTYPE = 1 THEN 3 ELSE 2 END AS DOCTYPE, A.CRDNUMBER, A.CRDDATE, (AA.COGS * CASE WHEN A.ADJTYPE = 1 THEN -1 ELSE 1 END) COGS, (A.CRDSUBTOT * CASE WHEN A.ADJTYPE = 1 THEN -1 ELSE 1 END) CRDSUBTOT, (A.CRDETAXTOT * CASE WHEN A.ADJTYPE = 1 THEN -1 ELSE 1 END) CRDETAXTOT, (A.CRDNETWTX * CASE WHEN A.ADJTYPE = 1 THEN -1 ELSE 1 END) CRDNETWTX,
			'Yes' AS AR, ISNULL(OPT.VDESC, '') AS ARTYPE
		FROM OECRDH A
		LEFT OUTER JOIN (
			SELECT CRDUNIQ, SUM(EXTCCOST) AS COGS
			FROM OECRDD
			GROUP BY CRDUNIQ
		) AA ON A.CRDUNIQ = AA.CRDUNIQ
		LEFT OUTER JOIN ARCUS B ON A.CUSTOMER = B.IDCUST
		LEFT OUTER JOIN OECRDHO ARTYPE ON A.CRDUNIQ = ARTYPE.CRDUNIQ AND ARTYPE.OPTFIELD = 'SALESTYPE'
		LEFT OUTER JOIN CSOPTFD OPT ON ARTYPE.OPTFIELD = OPT.OPTFIELD AND ARTYPE.[VALUE] = OPT.[VALUE]
		LEFT OUTER JOIN (
			SELECT A.ORDNUMBER, SUM(CASE WHEN B.LINETYPE = 1 THEN (ISNULL(B.QTYBACKORD, 0) + ISNULL(B.QTYSHPTODT, 0)) * ISNULL(B.UNITPRICE, 0) ELSE ISNULL(B.EXTINVMISC, 0) END) AS ORDAMT
			FROM OEORDH A
			LEFT OUTER JOIN OEORDD B ON A.ORDUNIQ = B.ORDUNIQ
			GROUP BY A.ORDNUMBER
		) ORD ON A.ORDNUMBER = ORD.ORDNUMBER
		WHERE A.CRDDATE BETWEEN @sDate_F AND @sDate_T
			AND A.CUSTOMER BETWEEN @sCust_F AND @sCust_T

		UNION ALL

		--ORDER
		SELECT A.CUSTOMER, A.NAMECUST, A.PONUMBER, A.ORDNUMBER, A.ORDDATE,
			SUM(A.ORDAMT) AS ORDAMT, SUM(A.ORDETAXTOT) AS ORDETAXTOT, SUM(A.ORDNETWTX) AS ORDNETWTX, 9 AS DOCTYPE, '' AS INVNUMBER, 0 AS INVDATE, 0 AS COGS, 0 AS INVSUBTOT, 0 AS INVETAXTOT, 0 AS INVNETWTX,
			'No' AS AR, A.ARTYPE
		FROM (

			SELECT A.CUSTOMER, B.NAMECUST, A.PONUMBER, A.ORDNUMBER, A.ORDDATE, A.INVSUBTOT AS ORDAMT, A.INVETAXTOT AS ORDETAXTOT, A.INVNETWTX AS ORDNETWTX, ISNULL(OPT.VDESC, '') AS ARTYPE
			FROM OEORDH A
			LEFT OUTER JOIN ARCUS B ON A.CUSTOMER = B.IDCUST
			LEFT OUTER JOIN OEORDHO ARTYPE ON A.ORDUNIQ = ARTYPE.ORDUNIQ AND ARTYPE.OPTFIELD = 'SALESTYPE'
			LEFT OUTER JOIN CSOPTFD OPT ON ARTYPE.OPTFIELD = OPT.OPTFIELD AND ARTYPE.[VALUE] = OPT.[VALUE]
			WHERE A.INVSUBTOT <> 0

			UNION ALL

			SELECT A.CUSTOMER, B.NAMECUST, A.PONUMBER, A.ORDNUMBER, A.ORDDATE, A.SHISUBTOT AS ORDAMT, A.SHIETAXTOT AS ORDETAXTOT, A.SHINETWTX AS ORDNETWTX, ISNULL(OPT.VDESC, '') AS ARTYPE
			FROM OESHIH	A
			LEFT OUTER JOIN ARCUS B ON A.CUSTOMER = B.IDCUST
			LEFT OUTER JOIN OESHIHO ARTYPE ON A.SHIUNIQ = ARTYPE.SHIUNIQ AND ARTYPE.OPTFIELD = 'SALESTYPE'
			LEFT OUTER JOIN CSOPTFD OPT ON ARTYPE.OPTFIELD = OPT.OPTFIELD AND ARTYPE.[VALUE] = OPT.[VALUE]
			WHERE NUMINVOICE = 0

		) A
		WHERE A.CUSTOMER BETWEEN @sCust_F AND @sCust_T
		GROUP BY A.CUSTOMER, A.NAMECUST, A.PONUMBER, A.ORDNUMBER, A.ORDDATE, A.ARTYPE

	) A 



End

GO