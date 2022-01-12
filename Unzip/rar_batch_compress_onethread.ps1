$folders = Get-ChildItem -DIR
foreach ($folder in $folders)
{
    $foldername = $folder.fullname
	& "C:\Program Files\WinRAR\Rar.exe" a -ep1 -ma4 -ed -df -rr3 -mt1 -t "${foldername}.rar" "${foldername}"
}
rclone rmdirs .