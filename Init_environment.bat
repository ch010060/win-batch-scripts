@echo off

REM Add system environment path
::Add 7zip to PATH
echo %PATH% | findstr "7-Zip" || SET "PATH=%PATH%;%ProgramFiles%\7-Zip\"

::Add Bandizip to PATH
echo %PATH% | findstr "Bandizip" || SET "PATH=%PATH%;%ProgramFiles%\Bandizip\"

::Add WinRAR to PATH
echo %PATH% | findstr "WinRAR" || SET "PATH=%PATH%;%ProgramFiles%\WinRAR\"

::Add ImageMagic to PATH
echo %PATH% | findstr "ImageMagick" || SET "PATH=%PATH%;%ProgramFiles%\ImageMagick-7.0.9-Q16\"

::Add script folder to PATH
echo %PATH% | findstr "script" || SET "PATH=%PATH%;C:\Users\%USERNAME%\Downloads\script\"

::Add rclone to PATH
echo %PATH% | findstr "rclone" || SET "PATH=%PATH%;C:\Users\%USERNAME%\Downloads\rclone\"

::Add idm to PATH
echo %PATH% | findstr "Internet" | findstr "Download" | findstr "Manager" || SET "PATH=%PATH%;%ProgramFiles%\Internet Download Manager\"

::Add Jdownloader to PATH
echo %PATH% | findstr "JDownloader" || SET "PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\JDownloader 2.0\"

REM Add custom alias command
echo %PATH% | findstr "alias" || SET "PATH=%PATH%;C:\Users\%USERNAME%\Downloads\script\alias\"

REM Add deamon command
echo %PATH% | findstr "run_daemon" || SET "PATH=%PATH%;C:\Users\%USERNAME%\Downloads\script\run_daemon\"

REM Add unix-like 3rd binary
echo %PATH% | findstr "UnxUpdates" || SET "PATH=%PATH%;C:\Users\%USERNAME%\Downloads\script\UnxUpdates\"

REM Add custom environment path
SET RDP_DOMAIN=[DOMAIN]
SET RDP_USERNAME=[USERNAME]
SET RDP_PASSWORD=[PASSWORD]
SET SCRIPT_PATH=C:\Users\%USERNAME%\Downloads\script\
SET UPLOAD_PATH=C:\Users\%USERNAME%\Downloads\upload\
SET REMOTE_PATH=[REMOTE_PATH]