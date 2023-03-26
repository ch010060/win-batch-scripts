$BaseDir = "<SRC_PATH>"
$NameToFind1 = "*Soundtrack*"
$NameToFind2 = "*Sound track*"
$NameToFind3 = "*SOUNDTRACK*"
$NameToFind4 = "*SOUND TRACK*"
$NameToFind5 = "*soundtrack*"
$NameToFind6 = "*sound track*"
$NameToFind7 = "*サウンドトラック*"
$NameToFind8 = "*サントラ*"
$NameToFind9 = "*サウンドコレクション*"
$NameToFind10 = "*サウンド・コレクション*"
$NameToFind11 = "*Sound Collection*"
$NameToFind12 = "*Sound collection*"
$NameToFind13 = "*SOUND COLLECTION*"
$NameToFind14 = "*音楽集*"
$NameToFind15 = "*[[O][S][T]]*"
$NameToFind16 = "*インスパイアードアルバム*"

# Find DIR names match filter
$folders = (Get-ChildItem -Path $BaseDir -Include $NameToFind1,$NameToFind2,$NameToFind3,$NameToFind4,$NameToFind5,$NameToFind6,$NameToFind7,$NameToFind8,$NameToFind9,$NameToFind10,$NameToFind11,$NameToFind12,$NameToFind13,$NameToFind14,$NameToFind15,$NameToFind16 -Recurse -Directory).Fullname
$totalNum = $folders.Count
$counter = 1
foreach ($folder in $folders){
	echo "($counter/$totalNum) $folder"
    $folder_CHECK = $folder.replace("]","``]").replace("[","``[")
	
    $FOLDER_INNER_COUNTER = 1
	$files = (Get-ChildItem -Path "${folder_CHECK}\" -Filter "*.flac" -Recurse -File| Select-Object FullName)
    foreach ($file in $files){
            $file_src=$file.FullName
            $GENRE_SOUNDTRACK="Soundtrack"
            #echo "Process: $file_src"

            # Check if GENRE has been add ?
            if($FOLDER_INNER_COUNTER -eq 1){
                $match=(metaflac.exe --show-tag=GENRE "$file_src" | Select-String "${GENRE_SOUNDTRACK}")
                if($match){ # shortcut to skip this folder
                    break
                }
            }

            # exameple: python3 flac_add_genre.py "test.flac" "Soundtrack"
            python3 flac_add_genre.py "$file_src" "$GENRE_SOUNDTRACK"
            
            $FOLDER_INNER_COUNTER = $FOLDER_INNER_COUNTER + 1
    }
	
	$counter = $counter + 1
}