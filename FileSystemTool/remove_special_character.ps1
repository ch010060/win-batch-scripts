$filename=$args[0]
$filenameWithoutExt=$filename.Substring(0, $filename.lastIndexOf('.'))
$filename_fixed=$filenameWithoutExt+"_fixed.txt"

Get-Content $filename | foreach { 
	$_  -replace '>','' `
		-replace '^','' `
		-replace '<',''
	} | Out-File -Encoding UTF8 $filename_fixed