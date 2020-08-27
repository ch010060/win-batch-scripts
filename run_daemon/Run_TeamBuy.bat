TITLE "Run_TeamBuy"
chcp 65001
@echo on
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
SET PASSWORD=""
::Init environment
call %SCRIPT_PATH%Init_environment.bat

::Start pre process

cd %cd%
::Fixed file and folder name
start /wait Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%replaceSpaceWithUnderscoreRecursive.ps1
call %SCRIPT_PATH%renameFileTypeFromExeToRar.bat

call %SCRIPT_PATH%get_filelist_under_dir.bat

call %SCRIPT_PATH%move_by_fileNumList.bat

::Move non-selected files to delete
mkdir delete
move *.7z* delete >NUL
move *.z* delete  >NUL
move *.rar delete  >NUL
move *.gz delete  >NUL
move *.tar delete  >NUL
move *.0* delete  >NUL

::Start post process

::Level 1 unzip(7z)
cd process

::Batch extract files
::call %SCRIPT_PATH%batch_7z_unzip.bat %PASSWORD% | findstr "ERROR:" | findstr /v "CRC" > error.txt 2>&1
call %SCRIPT_PATH%batch_7z_unzip_With_PW_Text.bat %PASSWORD% 2>&1

::Delte empty file
for /r %%F in (*) do if %%~zF==0 del "%%F"

::Move error.txt if error occurs
if exist error.txt (
        mkdir ..\error
	move error.txt ..\error\error.txt
)

::Fixed file and folder name
start /wait Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%replaceSpaceWithUnderscoreRecursive.ps1
call %SCRIPT_PATH%renameFileTypeFromExeToRar.bat

::Level 2 unzip
call %SCRIPT_PATH%recursively_unzip_FileInRootToFolder-Or-FileInFolderToHere_WithoutCheckError.bat %PASSWORD%

::Extract pdf images
::call %SCRIPT_PATH%extract_pdf_images_ImageMagic.bat %PASSWORD%

::Remove folder prefix tag before right parentheses or underscore
call %SCRIPT_PATH%removePrefixBefore1stUnderscore.bat

::UPLOAD STAGE
cd ..
::Move cover folder to uplaod folder
rclone move cover process\_cover

::Get current folder name to change upload folder name
SET UPLOAD_FOLDER=""
for %%f in (%cd%) do (
	SET UPLOAD_FOLDER="%%~nxf"
)
ren process %UPLOAD_FOLDER%

::Get timestamp
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%%ldt:~4,2%%ldt:~6,2%%ldt:~8,2%%ldt:~10,2%%ldt:~12,2%

::Sync the file
::rclone move %UPLOAD_FOLDER% %REMOTE_PATH%%UPLOAD_FOLDER% --progress --delete-after --drive-chunk-size 128M --buffer-size 256M --transfers 8 --log-level INFO --log-file C:\Users\%USERNAME%\Downloads\log\Run_ForTeamBuy_%ldt%.log

::Upload_PATH, REMOTE_PATH, LOG_FILENAME
start /wait Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%auto_upload_watch_dog_ps.ps1 -UPLOAD_FOLDER %UPLOAD_FOLDER% -REMOTE_PATH %REMOTE_PATH%%UPLOAD_FOLDER% -LOG_FILENAME "C:\Users\%USERNAME%\Downloads\log\rclone_%UPLOAD_FOLDER%_%ldt%.log"

::Remove empty folder
::rclone rmdirs %UPLOAD_FOLDER%

::PAUSE