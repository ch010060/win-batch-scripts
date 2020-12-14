SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
::Init environment
call %SCRIPT_PATH%Init_environment.bat

SET /p "UPLOAD_PATH=Input Source : "
SET /p "REMOTE_PATH=Input Target : "

::Sync the file
rclone copy %UPLOAD_PATH% %REMOTE_PATH% --progress --checkers 4 --transfers 4 --use-mmap --buffer-size 0M --tpslimit 4 --no-traverse

::Remove empty folder
rclone rmdirs %UPLOAD_PATH% --leave-root
