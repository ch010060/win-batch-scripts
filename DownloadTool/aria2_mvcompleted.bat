chcp 65001
@echo off
setlocal EnableDelayedExpansion

:: %1 is gid.
:: %2 is the number of files.
:: %3 is the path of the first file.

:: no trailing slash!
SET DOWNLOAD=D:\aria2\downloading\
SET COMPLETE=D:\aria2\completed\
SET LOG=C:\Users\%USERNAME%\Downloads\log\aria2_mvcompleted.log

IF NOT EXIST %DOWNLOAD% MKDIR %DOWNLOAD%
IF NOT EXIST %COMPLETE% MKDIR %COMPLETE%

SET SRC=%3
set "SRC=%SRC:/=\%"
 
if "%2" == "0" (
  echo "INFO  no file to move for" "%1"
  exit 0
)
 
:loop
  SET filename=%SRC%
  for %%F in (%filename%) do ( SET DIR=%%~dpF )
  if %DIR% == %DOWNLOAD% (
    echo INFO %date% %3 moved to "%COMPLETE%" >> "%LOG%"
    MOVE "%SRC%" "%COMPLETE%" >> "%LOG%" 2>&1
    exit %ERRORLEVEL%
  )
  if %DIR% == "\" (
    echo ERROR %date% %3 not under "%DOWNLOAD%" >> "%LOG%"
    exit 1
  )
  if %DIR% == "." (
    echo ERROR %date% %3 not under "%DOWNLOAD%" >> "%LOG%"
    exit 1
  )
  SET SRC=%DIR%
goto loop