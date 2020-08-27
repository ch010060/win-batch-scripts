@echo on
setlocal enabledelayedexpansion
SET ROOT_PATH="%cd%\"
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
SET BACKUP_PATH=..\completed_backup
SET ERROR_PATH=..\error
::Init environment
call %SCRIPT_PATH%Init_environment.bat
SET TYPE_REGEX=".part[2-9].rar .part[1-9][0-9].rar .part[1-9][0-9][0-9]"

::Set iterator
set /a counter=1

::Start label
:START

::Fixed filename
start /wait Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%replaceSpaceWithUnderscoreRecursive.ps1
call %SCRIPT_PATH%renameFileTypeFromExeToRar.bat

::Create all file list
for /F %%I IN ('dir /b /s *.zip *.rar *.7z *.gz *.tar *.0* *.z*') DO (
    echo %%I>> allFileListLevel%counter%.txt
)

if not exist allFileListLevel%counter%.txt exit /b

for /f %%i in ("allFileListLevel%counter%.txt") do set size=%%~zi
if %size% EQU 0 del allFileListLevel%counter%.txt & exit /b

set /a file_num=0

::Create extract list
for /F %%I IN ('dir /b /s *.zip *.rar *.7z *.gz *.tar *.001') DO (
    echo %%I| findstr /v /r %TYPE_REGEX% >> unzipFileListLevel%counter%.txt
    set /a file_num=file_num+1
)

set /a file_num_now=1

::Extract by filelist
::Extrat here if the file is not under root path, or extract to individual folder
for /f "tokens=*" %%a in (unzipFileListLevel%counter%.txt) do (
  set filename=%%~na
  for /f "tokens=1 delims=." %%f in ("!filename!") do (
    echo "progress : !file_num_now!/%file_num% > %%a"
    set /a file_num_now=file_num_now+1
    ::Split filename before first dot
    if %ROOT_PATH% == "%%~da%%~pa" (
    	Bandizip x -r -y -aoa -p:"%1" -o:"%%~da%%~pa%%f" "%%a"
    ) else (
    	Bandizip x -r -y -aoa -p:"%1" -o:"%%~da%%~pa" "%%a"
    )
  )
)

::Move all compress files after extraction
mkdir %BACKUP_PATH% 2> NUL
for /f "tokens=*" %%a in (allFileListLevel%counter%.txt) do (
  move /Y %%a %BACKUP_PATH%
)

::Remove empty folder
rclone rmdirs . --leave-root

::Increment counter, and loop if there is still any sub-compress-file 
::set /a counter=counter+1
::GOTO:START

::Fixed filename
start /wait Powershell.exe -executionpolicy remotesigned -File %SCRIPT_PATH%replaceSpaceWithUnderscoreRecursive.ps1