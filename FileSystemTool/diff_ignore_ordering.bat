@echo off
setlocal enabledelayedexpansion
SET /P "TARGET=Input Target File Path : "
SET /P "Compare=Input Comare File Path : "

FOR /f %%F in (%TARGET%) DO (
::Set iterator
set /a counter=0
	FOR /f %%I in (%Compare%) DO (
		IF "%%F" == "%%I" set /a counter=counter+1
        )
	IF !counter! EQU 0 ( echo %%F >> diff.txt )
)

PAUSE