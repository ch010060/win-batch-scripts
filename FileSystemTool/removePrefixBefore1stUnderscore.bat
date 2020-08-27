chcp 65001
@echo off

FOR /F %%I IN ('dir /b /a:d') DO (
	FOR /f "tokens=2 delims=^)_" %%G IN ("%%~nI") DO (
   		ren "%%~nI" "%%G"
	)
)

