for /F %%I IN ('dir /b /s *.zip *.rar *.7z *.7z.001') DO (
    "C:\Program Files\Bandizip\Bandizip.exe" x -r -target:name -o:"%%~dpI" "%%I"
)
MOVE %cd%\* C:\Users\%USERNAME%\Downloads\upload
PAUSE