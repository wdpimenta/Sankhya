UPDATE tgfcab SET CODTIPVENDA = 127, DHTIPVENDA = ( select MAX (DHALTER) FROM TGFtpv WHERE CODTIPVENDA = 127)
WHERE nunota = 226076 and TIPMOV = 'v'