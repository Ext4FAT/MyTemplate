@ echo off
set ARTICLE=IDLER_thesis
TASKKILL /F /IM FoxitReader.exe
latex %ARTICLE%.tex
bibtex %ARTICLE%
latex %ARTICLE%.tex
gbk2uni %ARTICLE%
latex %ARTICLE%.tex
dvipdfmx %ARTICLE%.dvi

start %ARTICLE%.pdf
