SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
::Init environment
call %SCRIPT_PATH%Init_environment.bat

::Get timestamp
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%%ldt:~4,2%%ldt:~6,2%%ldt:~8,2%%ldt:~10,2%%ldt:~12,2%

::Sync the file
::rclone move %UPLOAD_PATH% %REMOTE_PATH% --progress --delete-after --drive-chunk-size 128M --buffer-size 256M --transfers 8 --log-level INFO --log-file C:\Users\%USERNAME%\Downloads\log\auto_upload_watch_dog_%ldt%.log

::Upload_PATH, REMOTE_PATH, LOG_FILENAME
start /wait Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%auto_upload_watch_dog_ps.ps1 -UPLOAD_FOLDER %UPLOAD_PATH% -REMOTE_PATH %REMOTE_PATH% -LOG_FILENAME "C:\Users\%USERNAME%\Downloads\log\rclone_%ldt%.log"

::Remove empty folder
::rclone rmdirs %UPLOAD_PATH% --leave-root
