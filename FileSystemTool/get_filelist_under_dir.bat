mkdir process
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
SET CUR_DIR=%cd%

cd cover
Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%removeTagFromFileName.ps1

for %%i in (*.*) do @echo %%~ni>> ..\fileNumList.txt

cd %CUR_DIR%