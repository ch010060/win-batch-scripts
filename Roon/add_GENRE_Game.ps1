$BaseDir = "<SRC_PATH>"
$NameToFind1 = "*ゲーム「*"
$NameToFind2 = "*ゲーム『*"

# Find DIR names match filter
$folders = (Get-ChildItem -Path $BaseDir -Include $NameToFind1,$NameToFind2 -Recurse -Directory).Fullname
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
            $GENRE_GAME="Game"
            echo "Process: $file_src"

            # Check if GENRE has been add ?
            if($FOLDER_INNER_COUNTER -eq 1){
                $metadata=(metaflac.exe --show-tag=GENRE "$file_src")
                $match_soundtrack=(echo $metadata | Select-String "${GENRE_SOUNDTRACK}")
                $match_game=(echo $metadata | Select-String "${GENRE_GAME}")
                if($match_soundtrack -or $match_game){ # shortcut to skip this folder
                    break
                }
            }

            # exameple: python3 flac_add_genre.py "test.flac" "Game"
            python3 flac_add_genre.py "$file_src" "$GENRE_GAME"
            
            $FOLDER_INNER_COUNTER = $FOLDER_INNER_COUNTER + 1
    }
	
	$counter = $counter + 1
}