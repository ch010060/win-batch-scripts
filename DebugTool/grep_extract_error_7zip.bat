chcp 65001
@echo off
setlocal enabledelayedexpansion
SET FILENAME=error
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
SET REGEX="(ERROR|Open).*"
::Init environment
call %SCRIPT_PATH%Init_environment.bat

start /wait Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%remove_special_character.ps1 %FILENAME%.txt

::Set iterator
set /a line_num=0
set /a line_num_now=1

::Count line number
for /f "delims=" %%f in (%FILENAME%_fixed.txt) do (
	set /a line_num=line_num+1
)


::Grep the error from error log file
for /f "delims=" %%f in (%FILENAME%_fixed.txt) do (
	echo "process : line !line_num_now!/%line_num%"
	set /a line_num_now=line_num_now+1
	echo "%%f" | findstr "ERROR:" >> %FILENAME%_grep.txt
)