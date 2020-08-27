SET UPLOAD_PATH=C:\Users\%USERNAME%\Downloads\upload

FOR /d %%i IN (*) DO IF NOT "%%i"=="%UPLOAD_PATH%" move "%%i" %UPLOAD_PATH%