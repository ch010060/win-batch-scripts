@echo off
chcp 65001
setlocal EnableDelayedExpansion
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\

::Replace space with under score
start /wait Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%replaceSpaceWithUnderscoreRecursive.ps1

::List files
FOR /F %%I IN ('dir /b /a:-d') DO (
	::Get video height
    FOR /F "tokens=*" %%g IN ('ffprobe.exe -v error -select_streams v:0 -show_entries stream^=height -of default^=nw^=1:nk^=1 %%I') DO (
		SET VAR=%%g
		IF NOT EXIST "!VAR!" MD "!VAR!"
		MOVE "%%I" "!VAR!"
	)
)