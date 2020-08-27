chcp 65001
@echo on
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
::Init environment
call %SCRIPT_PATH%Init_environment.bat
SET CURRENT_PATH="%cd%"

::Extrat pdf raw images
for /F %%I IN ('dir /b /a:d') DO (
    cd %%I
    for /F %%A IN ('dir /b /a:d') DO (
    	IF "%%~nI" == "%%~nA" echo y|RMDIR "%%A" /S
    )
    cd %CURRENT_PATH%
)


