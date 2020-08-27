@echo on
setlocal EnableDelayedExpansion
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
SET TYPE_REGEX=".part[2-9].rar .part[1-9][0-9].rar .part[1-9][0-9][0-9]"
SET BACKUP_PATH=..\completed_raw
SET ERROR_PATH=..\error

::Init environment
call %SCRIPT_PATH%Init_environment.bat

::Count file number
set /a file_num=0
for /F %%I IN ('dir /b /s *.zip *.rar *.7z *.gz *.tar *.001 ^| findstr /v /r %TYPE_REGEX%') DO (
    set /a file_num=file_num+1
)

set /a file_num_now=1
for /F %%I IN ('dir /b /s *.zip *.rar *.7z *.gz *.tar *.001 ^| findstr /v /r %TYPE_REGEX%') DO (
    echo "progress : !file_num_now!/%file_num% > %%~nxI"
    set /a file_num_now=file_num_now+1

  for /f "tokens=1 delims=." %%f in ("%%~nxI") do (
    ::Split filename before first dot
    7z x %%I -o"%%~dI%%~pI%%f" -y < ..\pass.txt
    IF !ERRORLEVEL! NEQ 0 (
	mkdir %ERROR_PATH% 2> NUL
	move /Y "%%I" %ERROR_PATH% 2> NUL
    )
  )
)

::Remove empty folder
rclone rmdirs . --leave-root

mkdir %BACKUP_PATH%
for /F %%i in ('dir /b *.z* *.rar* *.7z* *.gz *.tar') do ( move /Y "%%i" %BACKUP_PATH% )