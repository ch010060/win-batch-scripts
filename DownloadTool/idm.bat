@echo off
setlocal enabledelayedexpansion
::Init environment
call %SCRIPT_PATH%Init_environment.bat

::1. Scan download file
for /f %%f in ('dir /b /a:-d *.txt') do (
	mkdir %%~nf
	echo "%%f"
	::2. Scan link from file to idm schedule, but not download now
	for /f "tokens=*" %%a in (%%f) do (
		echo "%%a"
		IDMan /n /p %cd%\%%~nf\ /a /d %%a
	)
	move /Y %%f %%~nf
)

::Start download
IDMan /s