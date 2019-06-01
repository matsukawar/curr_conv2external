*&---------------------------------------------------------------------*
*& Report Program of Convert currency to external.
*& RYOSUKE MATSUKAWA / Date : 2019-06-01
*&---------------------------------------------------------------------*
*& Sample execution code for converting internal currency to external.
*&---------------------------------------------------------------------*
REPORT Z_CURRENCY_CONV_TO_EXTERNAL.

DATA :
  LW_CUKY_NEW TYPE WAERS VALUE 'JPY',
  LW_INPUT    LIKE BAPICURR-BAPICURR,
  LW_OUTPUT   LIKE BAPICURR-BAPICURR,
  LW_DEC      TYPE P DECIMALS 2.

" Use japanese numeric separator format.
SET COUNTRY 'JP'.

" Pattern 01 : Using BAPI. Large amount.
LW_INPUT = '12.34'.
CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_EXTERNAL'
  EXPORTING
    CURRENCY        = LW_CUKY_NEW
    AMOUNT_INTERNAL = LW_INPUT
  IMPORTING
    AMOUNT_EXTERNAL = LW_OUTPUT.

" RESULT = 1,234円 (1,234 JPY)
WRITE / |{ LW_OUTPUT NUMBER = ENVIRONMENT DECIMALS = 0 }円|.



" Pattern 02 : Using BAPI. Small amount.
LW_INPUT = '-1.23'.
CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_EXTERNAL'
  EXPORTING
    CURRENCY        = LW_CUKY_NEW
    AMOUNT_INTERNAL = LW_INPUT
  IMPORTING
    AMOUNT_EXTERNAL = LW_OUTPUT.

"RESULT = -123円 (-123 JPY)
WRITE / |{ LW_OUTPUT NUMBER = ENVIRONMENT DECIMALS = 0 }円|.



" Pattern 03 : Using ABAP embedded expressions of string template. Large amount.
LW_INPUT    = '12.34'.
LW_DEC      = LW_INPUT.

" RESULT = 1,234円 (1,234 JPY)
WRITE / |{ LW_DEC CURRENCY = 'JPY' NUMBER = ENVIRONMENT }円|.



" Pattern 04 : Using ABAP embedded expressions of string template. Small amount.
LW_INPUT = '-1.23'.
LW_DEC = LW_INPUT.

" RESULT = -123円 (-123 JPY)
WRITE / |{ LW_DEC CURRENCY = 'JPY' NUMBER = ENVIRONMENT }円|.



" Use American format.
SET COUNTRY 'US'.

" Pattern 05 : CURRENCY = 'USD'
LW_INPUT    = '12.34'.
LW_DEC      = LW_INPUT.

" RESULT = $12.34
WRITE / |${ LW_DEC CURRENCY = 'USD' NUMBER = ENVIRONMENT }|.
