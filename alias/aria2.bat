@echo off

::Get timestamp
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%%ldt:~4,2%%ldt:~6,2%%ldt:~8,2%%ldt:~10,2%%ldt:~12,2%

::Run in background
START "aria2_%ldt%" /B CMD /C CALL aria2c -x 16 -s 16 -j 10 "%1" -l C:\Users\%USERNAME%\Downloads\log\aria2_%ldt%.log

::tail -f C:\Users\%USERNAME%\Downloads\log\aria2_%ldt%.log
::aria2c -x 16 -s 16 -j 10 "%1" >> C:\Users\%USERNAME%\Downloads\log\aria2_%ldt%.log
