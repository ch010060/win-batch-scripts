chcp 65001
@ECHO OFF

:: 執行的指令 ( 請注意若要使用 pipe 符號必須在之前加上一個 ^ 符號 )
SET ExecuteCommand=%1 %2 %3 %4 %5

:: 單位: 秒
SET ExecutePeriod=3


SETLOCAL EnableDelayedExpansion

:loop

  cls

  echo.

  %ExecuteCommand%
  
  timeout /t %ExecutePeriod% > nul

goto loop