@echo off
setlocal enabledelayedexpansion
::Init environment
call %SCRIPT_PATH%Init_environment.bat

SET Cookie=cookies.txt

::Get timestamp
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%%ldt:~4,2%%ldt:~6,2%%ldt:~8,2%%ldt:~10,2%%ldt:~12,2%

::1. Scan download filelist, exclude the cookies file
for /f %%f in ('dir /b /a:-d *.txt ^| findstr /v cookies.txt') do (
	mkdir %%~nf
	echo "process: %%f"
	CMD "aria2_%%f_%ldt%" /C CALL aria2c --load-cookies %Cookie% -x 16 -s 16 -j 10 -i %%f -d %%~nf -l C:\Users\%USERNAME%\Downloads\log\aria2_%%f_%ldt%.log
	move /Y %%f %%~nf
)

::tail -f C:\Users\%USERNAME%\Downloads\log\aria2_%%f_%ldt%.log
PAUSE


