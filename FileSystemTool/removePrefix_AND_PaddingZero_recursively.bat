REM img1 => img001
REM img11 => img011
REM img999 => img999

chcp 65001
@echo on
TITLE "remove_quote_recursively"
setlocal enabledelayedexpansion
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
SET PWD="%cd%"

::Create all file list
dir /b /s /a:d > allFolderList.txt 

::Remove quote by filelist
for /f "tokens=*" %%a in (allFolderList.txt) do (
  cd "%%a"
  start /wait /B Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%removePrefix_AND_PaddingZero.ps1
  cd "%PWD%"
)

DEL allFolderList.txt