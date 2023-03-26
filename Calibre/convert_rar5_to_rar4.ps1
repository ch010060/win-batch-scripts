$folder_SRC = "<SRC_PATH>"
$folder_PROCESS = "<PROCESS_PATH>"
$folder_COMPLETED = "<COMPLETED_PATH>"
	
$files = (Get-ChildItem -Path "${folder_SRC}\" -Filter "*.rar" -Recurse -File| Select-Object FullName)
foreach ($file in $files){
            $file_src=$file.FullName
			$file_PROCESS = $file_src.replace("]","``]").replace("[","``[")
            $file_BASENAME=(Get-Item $file_PROCESS ).Basename
            $file_EXTENSION=(Get-Item $file_PROCESS ).Extension
            $file_DIR=(Get-Item $file_PROCESS ).DirectoryName
            $filename="${file_BASENAME}${file_EXTENSION}"

            # Check is rar5 ?
            $list=(Rar.exe l "$file_src")
            $match=(echo $list | Select-String "...D...")
            if($match){ # shortcut to skip this folder
                    echo "Process: $file_src"
                    Rar.exe x "$file_src" "$folder_PROCESS"
                    Rar.exe a -rr3 -ma4 -r -ep1 "$folder_COMPLETED\$filename" "$folder_PROCESS\*"
                    Remove-Item -path "$folder_PROCESS" -Force -Recurse
                    mkdir "$folder_PROCESS"
            }
}