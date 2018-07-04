SELECT CODEMP,NOMEFANTASIA,MES,ANO,VLR_COMPRAS COMPRAS

FROM (

	SELECT SUB1.CODEMP,SUB1.NOMEFANTASIA,SUB1.MES,SUB1.ANO,

	(
		ISNULL((SELECT SUM(I.VLRTOT+I.VLRIPI) FROM TGFITE I WITH (NOLOCK) INNER JOIN TGFCAB C WITH (NOLOCK) ON C.NUNOTA = I.NUNOTA
				WHERE C.STATUSNOTA = 'L' AND C.TIPMOV = 'C' AND C.CODEMP = SUB1.CODEMP
				AND YEAR(C.DTENTSAI) = SUB1.ANO AND MONTH(C.DTENTSAI) = SUB1.MES
				AND C.CODVEND <> 59 AND C.NUNOTA IN (SELECT NUNOTA FROM TGFFIN WITH (NOLOCK) WHERE ORIGEM = 'E' AND CODTIPTIT <> 69)
			),0) - ISNULL((SELECT SUM(I.VLRTOT+I.VLRIPI) FROM TGFITE I WITH (NOLOCK) INNER JOIN TGFCAB C WITH (NOLOCK) ON C.NUNOTA = I.NUNOTA
				WHERE C.STATUSNOTA = 'L' AND C.TIPMOV = 'E' AND C.CODEMP = SUB1.CODEMP
				AND YEAR(C.DTENTSAI) = SUB1.ANO AND MONTH(C.DTENTSAI) = SUB1.MES
				AND C.CODVEND <> 59 AND C.NUNOTA IN (SELECT NUNOTA FROM TGFFIN WITH (NOLOCK) WHERE ORIGEM = 'E' AND CODTIPTIT <> 69)
			),0)
		) VLR_COMPRAS

	FROM (

		SELECT EMP.CODEMP,EMP.NOMEFANTASIA,ITE.CODPROD,MONTH(CAB.DTENTSAI) MES,YEAR(CAB.DTENTSAI) ANO--,

		FROM TSIEMP EMP WITH (NOLOCK)
		INNER JOIN TGFCAB CAB WITH (NOLOCK) ON CAB.CODEMP = EMP.CODEMP
		INNER JOIN TGFITE ITE WITH (NOLOCK) ON ITE.NUNOTA = CAB.NUNOTA
		WHERE EMP.CODEMPMATRIZ = 1 AND EMP.CODEMP <> 5 
		AND YEAR(CAB.DTENTSAI) >= 2017
		GROUP BY EMP.CODEMP,EMP.NOMEFANTASIA,ITE.CODPROD,MONTH(CAB.DTENTSAI),YEAR(CAB.DTENTSAI)

	) SUB1
	GROUP BY CODEMP,NOMEFANTASIA,MES,ANO

) SUB2

GROUP BY CODEMP,NOMEFANTASIA,MES,ANO,VLR_COMPRAS
ORDER BY CODEMP,ANO,MES