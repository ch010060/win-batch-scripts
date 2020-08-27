@echo off
TITLE "rclone_mount"
::Init environment
call %SCRIPT_PATH%Init_environment.bat

rclone mount gd:/ z: --cache-dir c:\gd_temp --vfs-cache-mode writes