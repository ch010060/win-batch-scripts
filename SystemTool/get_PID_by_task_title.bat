@echo off
wmic process where caption="cmd.exe" get commandline,processid | grep %1 | awk "{print $7}" && top | grep %1 | awk "{print $2}"
