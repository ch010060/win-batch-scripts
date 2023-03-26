$folder_SRC = "<SRC_PATH>"
$folder_DST = "<DST_PATH>"
	
$files = (Get-ChildItem -Path "${folder_SRC}\" -Filter "*.rar" -Recurse -File| Select-Object FullName)
foreach ($file in $files){
            $file_src=$file.FullName
			$file_CHECK = $file_src.replace("]","``]").replace("[","``[")

            # Check is rar5 ?
            $list=(Rar.exe l "$file_src")
            $match=(echo $list | Select-String "RAR 5")
            if($match){ # shortcut to skip this folder
                    echo "Process: $file_src"
                    Copy-Item "$file_CHECK" -Destination "$folder_DST"
            }

}
