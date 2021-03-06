SELECT /* RELARTORIO DE COMPRAS E REVENDAS*/
DISTINCT CAB.CODEMP, CAB.NUMNOTA,CAB.DTENTSAI, CAB.VLRNOTA, PAR.CODPARC,PAR.RAZAOSOCIAL,T.CODTIPOPER, T.DESCROPER
FROM TGFCAB CAB INNER JOIN TGFPAR PAR ON (PAR.CODPARC=CAB.CODPARC)
INNER JOIN TGFTOP T ON (T.CODTIPOPER = CAB.CODTIPOPER)
INNER JOIN TGFITE ITE ON (ITE.NUNOTA =CAB.NUNOTA)
INNER JOIN TGFPRO PRO ON (ITE.CODPROD= PRO.CODPROD)
WHERE --PAR.AD_TIPO_PARCEIRO = 'FORN_REVEN' AND 
CAB.TIPMOV = 'C'
AND PRO.USOPROD = 'R'
AND CAB.CODEMP IN :CODEMP
AND T.CODTIPOPER IN (701,712) --NOT IN  (700,708,791,730,797,793,792,726,718,795,717,713)
AND CAB.DTENTSAI BETWEEN :PERIODO.INI AND :PERIODO.FIN
ORDER BY CAB.CODEMP, CAB.DTENTSAI
