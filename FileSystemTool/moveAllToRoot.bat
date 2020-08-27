chcp 65001
@echo off
setlocal EnableDelayedExpansion
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
::Init environment
call %SCRIPT_PATH%Init_environment.bat

::Fixed file and folder name
start /wait Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%replaceSpaceWithUnderscoreRecursive.ps1

for /f "delims=" %%d in ('dir /a:d /b') do (
	cd %%d
	for /f "delims=" %%f in ('dir /a-d /s /b') do (
		echo %%f >> filelist.txt
	)
	for /f "tokens=*" %%a in (filelist.txt) do (
		move %%a .
	)
        del filelist.txt
	cd ..
)

::Remove empty folder
rclone rmdirs .

PAUSE