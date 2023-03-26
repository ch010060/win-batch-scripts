$BaseDir = "<SRC_PATH>"
$NameToFind1 = "*アニメ「*"
$NameToFind2 = "*アニメ『*"
$NameToFind3 = "*映画「*"
$NameToFind4 = "*映画『*"
$NameToFind5 = "*劇場版「*"
$NameToFind6 = "*劇場版『*"
$NameToFind7 = "*OVA「*"
$NameToFind8 = "*OVA『*"

# Find DIR names match filter
$folders = (Get-ChildItem -Path $BaseDir -Include $NameToFind1,$NameToFind2,$NameToFind3,$NameToFind4,$NameToFind5,$NameToFind6,$NameToFind7,$NameToFind8 -Recurse -Directory).Fullname
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
            $GENRE_ANIME="Anime"
            #echo "Process: $file_src"

            # Check if GENRE has been add ?
            if($FOLDER_INNER_COUNTER -eq 1){
                $metadata=(metaflac.exe --show-tag=GENRE "$file_src")
                $match_soundtrack=(echo $metadata | Select-String "${GENRE_SOUNDTRACK}")
                $match_anime=(echo $metadata | Select-String "${GENRE_ANIME}")
                if($match_soundtrack -or $match_anime){ # shortcut to skip this folder
                    break
                }
            }

            # exameple: python3 flac_add_genre.py "test.flac" "Anime"
            python3 flac_add_genre.py "$file_src" "$GENRE_ANIME"
            
            $FOLDER_INNER_COUNTER = $FOLDER_INNER_COUNTER + 1
    }
	
	$counter = $counter + 1
}