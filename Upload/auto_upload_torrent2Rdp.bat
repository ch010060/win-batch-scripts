@echo off
::設置參數
::WinScp安裝路徑
SET rootPath=C:\Program Files (x86)\WinSCP
::sftp路徑
SET sftpPath=sftp://[ACCOUNT]:[PASSWORD]@[DOMAIN:PORT]
::本地文件下載路徑(windows)
SET localDownloadPath=C:\Users\%USERNAME%\Downloads\
::雲端文件路徑(google drive)
SET cloudPath=gd:\torrent\
::本地文件路徑(windows)
SET localFilePath=C:\Users\%USERNAME%\Downloads\watch\
IF NOT EXIST %localFilePath% MKDIR %localFilePath%
::本地已上傳文件路徑(windows)
SET localuploadedFilePath=C:\Users\%USERNAME%\Downloads\uploaded\
IF NOT EXIST %localuploadedFilePath% MKDIR %localuploadedFilePath%
::目標文件路徑(linux)
SET targetFilePath=./downloads/watch/rtorrent
::本地日誌標誌
SET logPath=/log
::本地日誌文件名
::SET logFileName=torrent_upload_log_file.txt

::命令解析
::winscp.exe /console /command "option batch continue" "option confirm off" "open sftp://user:pwd@ip:port" "option transfer binary" "put D:\需要上傳的文件路徑 /服務器文件存放目錄" "exit" /log=log_file.txt

::winscp.exe /console /command	---命令名
::"option batch continue"	---默認批處理
::"option confirm off"	---關閉提示信息
::"open ftp://user:pwd@ip:port user"	---訪問用戶名 ，pwd:用戶密碼 ，ip:ip地址，port：端口號 默認22
::"option transfer binary" ---使用二進制格式傳送
::log=log_file.txt ---日誌文件地址
::"exit"	---運行完退出

rclone move %cloudPath% %localDownloadPath%

::cd %localDownloadPath%
::MOVE /Y .\*.torrent %localFilePath%
ROBOCOPY %localDownloadPath% %localDownloadPath%watch *.torrent /MOV
cd %rootPath%
winscp.exe /console /command "option batch continue" "option confirm off" "open %sftpPath%" "option transfer binary" "put %localFilePath% %targetFilePath%" "exit" %logPath%=%logFileName%
::cd %localFilePath%
::MOVE /Y .\* %localuploadedFilePath%
ROBOCOPY %localFilePath% %localuploadedFilePath% *.torrent /MOV