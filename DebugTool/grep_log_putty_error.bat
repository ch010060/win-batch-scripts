@echo off
TITLE "Grep log helper : putty, Log Level = error"

::SET PATH
SET LOG_PATH=".\"

::SET LOG LEVEL
SET LOG_LEVEL=error

setlocal enabledelayedexpansion

::SET COLOR FUNC LABEL
call :setESC

::SET BREAK LINE
set newline=^& echo.

::SET GREP ARGV
SET BEFORE_LINE=3
SET AFTER_LINE=9

::Set iterator
set /a counter=0
set TARGET_FILE=""

::Get lastest modified file
for /f %%f in ('dir /b /a:-d %LOG_PATH%*.log') DO (
	set TARGET_FILE=%%f
)

::Show info
echo Log File    : %TARGET_FILE%
echo Log Path    : %cd%\
echo Log Level   : %LOG_LEVEL%
echo Grep Policy : Latest Modified%newline%

for /f "tokens=*" %%a in ('type %TARGET_FILE% ^| grep -n "%LOG_LEVEL%:" -B %BEFORE_LINE% -A %AFTER_LINE%') do (
	::Skip grep separate line
	IF NOT "%%a" == "--" (
		::Set line counter
		set /a counter=counter+1
		::Set grep result
		set _CmdResult=%%a
		::Mark match line
		set "modified=!_CmdResult:%LOG_LEVEL%:=%ESC%[101m%LOG_LEVEL%:%ESC%[0m!"
		::Bold match line => green
		echo %ESC%[92m!modified!%ESC%[0m
		::Split each grep result
		SET /a "grep_line_range_count=%BEFORE_LINE%+%AFTER_LINE%+1"
		IF !counter! EQU !grep_line_range_count! ( set /a counter=0 && echo %ESC%[91m====================================================================================================================%ESC%[0m )
	)
)

PAUSE

::SET COLOR FUNC
:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)
