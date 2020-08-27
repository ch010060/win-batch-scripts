chcp 65001
@echo on
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
::Init environment
call %SCRIPT_PATH%Init_environment.bat
SET CURRENT_PATH="%cd%"

::Fixed file and folder name
start /wait Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%replaceSpaceWithUnderscoreRecursive.ps1

::Extrat pdf raw images
for /F %%I IN ('dir /s /b /a:-d *.pdf') DO (
    cd %%~dI%%~pI
    mkdir %%~nI_png && (
    convert -limit time 1800 -density 600 -quiet %%I %%~nI_png\%%~nI.png >> %%~nI_png\error.txt 2>&1
    ::Del error log if empty
    for /f %%f in ("%%~nI_png\error.txt") do ( if %%~zf EQU 0 del %%~nI_png\error.txt )
    )
    for /f %%a in ('dir /a:-d /s /b C:\Users\%USERNAME%\AppData\Local\Temp\magick*') do del "%%a"
    cd %CURRENT_PATH%
)


