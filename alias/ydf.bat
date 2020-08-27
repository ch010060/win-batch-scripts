@echo off
setlocal enabledelayedexpansion
::Init environment
call %SCRIPT_PATH%Init_environment.bat

::1. Scan download file
for /f %%f in ('dir /b /a:-d *.txt') do (
	echo "Process: %%f"
	for /f "tokens=*" %%a in (%%f) do (
		echo "Download... %%a"
		youtube-dl %1 %2 %3 %4 %%a
	)
	del %%f
)

move *.mp4 %UPLOAD_PATH%
