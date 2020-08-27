@echo off
TITLE "batch_7z_unzip_per5min"
setlocal EnableDelayedExpansion
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
::Init environment
call %SCRIPT_PATH%Init_environment.bat

SET TYPE_REGEX=".part[2-9].rar .part[1-9][0-9].rar .part[1-9][0-9][0-9]"
SET ERROR_PATH=..\error
SET UNZIP_PATH=D:\aria2\completed\
SET PROCESS_PATH=D:\aria2\unzip\process\
SET UPLOAD_PATH=gd:/Baidu/completed/aria2/

::Create folder if not exist
rclone mkdir "%UPLOAD_PATH%"
IF NOT EXIST "%PROCESS_PATH%" MD "%PROCESS_PATH%"

:START

::Move to aria2 completed folder
cd "%UNZIP_PATH%"

::Count file number and move compressed files
set /a file_num=0
for /F %%I IN ('dir /b /s *.zip *.rar *.7z *.gz *.tar *.0* *.z0*') DO (
	MOVE "%%I" "%PROCESS_PATH%"
    SET /a file_num=file_num+1
)

:RECURSIVE_UNZIP

::Move to process folder
cd "%PROCESS_PATH%"

set /a file_num_now=1
for /F %%I IN ('dir /b /s *.zip *.rar *.7z *.gz *.tar *.001 ^| findstr /v /r %TYPE_REGEX%') DO (
    echo "progress : !file_num_now!/%file_num% > %%~nxI"
    set /a file_num_now=file_num_now+1

  for /f "tokens=1 delims=." %%f in ("%%~nxI") do (
    ::Split filename before first dot, delete compressed files after unzipping successfully
    7z x -p%1 %%I -o"%%~dI%%~pI" -y
    IF !ERRORLEVEL! NEQ 0 (
		mkdir %ERROR_PATH% 2> NUL
		move /Y "%%I" %ERROR_PATH% 2> NUL
    ) ELSE (
		DEL /F /Q "%%I"
	)
  )
)

::Check is there any sub compressed file ?
dir /b /s *.zip *.rar *.7z *.gz *.tar *.001 | findstr /v /r %TYPE_REGEX% > NUL 2>&1 && GOTO:RECURSIVE_UNZIP

::Upload
rclone move %PROCESS_PATH% %UPLOAD_PATH% --progress --drive-chunk-size 128M --buffer-size 256M --transfers 8

::Remove empty folder
rclone rmdirs %PROCESS_PATH% --leave-root

timeout /t 300

GOTO:START
