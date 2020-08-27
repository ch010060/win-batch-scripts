chcp 65001
@echo off
setlocal EnableDelayedExpansion
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\

start /wait Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%add_prefix_[String].ps1

start /wait Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%replaceSpaceWithUnderscoreRecursive.ps1

for /F %%I IN ('dir /b *.zip *.z01 *.rar *.7z *.gz *.tar *.001') DO (
    for /f %%G in ('7z x -p"%1" %%I -o* -y') do  ( echo "%%G" | findstr "Can't error password" && mkdir .\error 2> NUL | move %%~nxI .\error 2> NUL )
)

mkdir .\completed

for /F %%I IN ('dir /b *.zip *.z01 *.rar *.7z *.gz *.tar *.001') DO (
    move %%I .\completed
)
