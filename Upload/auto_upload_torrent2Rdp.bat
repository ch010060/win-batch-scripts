@echo off
::�]�m�Ѽ�
::WinScp�w�˸��|
SET rootPath=C:\Program Files (x86)\WinSCP
::sftp���|
SET sftpPath=sftp://[ACCOUNT]:[PASSWORD]@[DOMAIN:PORT]
::���a���U�����|(windows)
SET localDownloadPath=C:\Users\%USERNAME%\Downloads\
::���ݤ����|(google drive)
SET cloudPath=gd:\torrent\
::���a�����|(windows)
SET localFilePath=C:\Users\%USERNAME%\Downloads\watch\
IF NOT EXIST %localFilePath% MKDIR %localFilePath%
::���a�w�W�Ǥ����|(windows)
SET localuploadedFilePath=C:\Users\%USERNAME%\Downloads\uploaded\
IF NOT EXIST %localuploadedFilePath% MKDIR %localuploadedFilePath%
::�ؼФ����|(linux)
SET targetFilePath=./downloads/watch/rtorrent
::���a��x�лx
SET logPath=/log
::���a��x���W
::SET logFileName=torrent_upload_log_file.txt

::�R�O�ѪR
::winscp.exe /console /command "option batch continue" "option confirm off" "open sftp://user:pwd@ip:port" "option transfer binary" "put D:\�ݭn�W�Ǫ������| /�A�Ⱦ����s��ؿ�" "exit" /log=log_file.txt

::winscp.exe /console /command	---�R�O�W
::"option batch continue"	---�q�{��B�z
::"option confirm off"	---�������ܫH��
::"open ftp://user:pwd@ip:port user"	---�X�ݥΤ�W �Apwd:�Τ�K�X �Aip:ip�a�}�Aport�G�ݤf�� �q�{22
::"option transfer binary" ---�ϥΤG�i��榡�ǰe
::log=log_file.txt ---��x���a�}
::"exit"	---�B�槹�h�X

rclone move %cloudPath% %localDownloadPath%

::cd %localDownloadPath%
::MOVE /Y .\*.torrent %localFilePath%
ROBOCOPY %localDownloadPath% %localDownloadPath%watch *.torrent /MOV
cd %rootPath%
winscp.exe /console /command "option batch continue" "option confirm off" "open %sftpPath%" "option transfer binary" "put %localFilePath% %targetFilePath%" "exit" %logPath%=%logFileName%
::cd %localFilePath%
::MOVE /Y .\* %localuploadedFilePath%
ROBOCOPY %localFilePath% %localuploadedFilePath% *.torrent /MOV