$MY_PATH="<SRC_PATH>"

Get-ChildItem -Path $MY_PATH -Filter *.m4a -Recurse -File| Select-Object FullName | ForEach-Object {
    $FILE_SRC=$_.FullName
    $FILE_FLAC=${FILE_SRC}.replace('.m4a','.flac')
    echo "Convert: $FILE_SRC"
    ffmpeg -hide_banner -loglevel error -y -i "${FILE_SRC}" -f flac -vsync 0 "${FILE_FLAC}"

    $FILE_SRC_FIX = $FILE_SRC.replace("]","``]").replace("[","``[")
    $FLAC_PATH_FIX = $FILE_FLAC.replace("]","``]").replace("[","``[")
    if(Test-Path -Path "$FLAC_PATH_FIX" -PathType Leaf){
        Remove-Item "$FILE_SRC_FIX"
    }
}