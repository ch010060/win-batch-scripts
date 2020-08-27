@echo off
SET PWD=%cd%
SET SourceDir=%PWD%
SET CopyDir=%PWD%\process
Set "MyFile=%SourceDir%\fileNumList.txt"
Set "MoveFile=%SourceDir%\fileNameList.txt"

for /f "delims=" %%a in ('Type "%MyFile%"') Do (

cd %SourceDir%
dir /b | findstr "%%a" >> fileNameList.txt
)

@echo on
for /f "delims=" %%a in ('Type "%MoveFile%"') Do (
MOVE %%a %CopyDir%
)


