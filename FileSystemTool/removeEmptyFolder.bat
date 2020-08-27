chcp 65001
for /f "delims=" %%d in ('dir /s /b /ad ^| sort /r') do rd "%%d"