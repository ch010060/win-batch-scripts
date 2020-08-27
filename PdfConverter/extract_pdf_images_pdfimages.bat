chcp 65001
@echo on
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
::Init environment
call %SCRIPT_PATH%Init_environment.bat
SET CURRENT_PATH="%cd%"

::Extrat pdf raw images
for /F %%I IN ('dir /s /b /a:-d *.pdf') DO (
    cd %%~dI%%~pI
    pdfimages -raw -upw "%1" %%I %%~nI | findstr "error" >> error.txt 2>&1
    cd %CURRENT_PATH%
)


