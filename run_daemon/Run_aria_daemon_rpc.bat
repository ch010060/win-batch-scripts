TITLE "Run_aria_daemon_rpc"

SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
::Init environment
call %SCRIPT_PATH%Init_environment.bat

::Get timestamp
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%%ldt:~4,2%%ldt:~6,2%%ldt:~8,2%%ldt:~10,2%%ldt:~12,2%

::run aria2c rpc daemon
IF NOT EXIST "C:\Users\%USERNAME%\Downloads\log\" MKDIR "C:\Users\%USERNAME%\Downloads\log\"
aria2c --conf-path C:\Users\%USERNAME%\Downloads\script\config\aria2.conf > C:\Users\%USERNAME%\Downloads\log\Run_aria_daemon_rpc_%ldt%.log 2>&1 &
