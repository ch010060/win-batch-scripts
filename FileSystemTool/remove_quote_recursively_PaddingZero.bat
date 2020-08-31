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
  call %SCRIPT_PATH%remove_quote.bat
  start /wait /B Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%renamePaddingZero.ps1
  cd "%PWD%"
)

DEL allFolderList.txt