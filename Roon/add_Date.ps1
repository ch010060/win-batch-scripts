$BaseDir = "<SRC_PATH>"
$DateToFind = ".*\[\d{6}.*"

# Find DIR names match filter
$folders = (Get-ChildItem -Path $BaseDir -Recurse -Directory | Where-Object{$_ -match $DateToFind}).Fullname
$totalNum = $folders.Count
$counter = 1
foreach ($folder in $folders){
	echo "($counter/$totalNum) $folder"
    $folder_CHECK = $folder.replace("]","``]").replace("[","``[")

    #$folder_fixed = $folder.replace("\(.*\)","")
    #echo $folder_fixed
    $found = $folder -match '\[\d{6}'
    $my_date = ""
    if($found){
        $date_orig = $matches[0].replace("[","")
        $YEAR = ${date_orig}.Substring(0,2)
        $MON = ${date_orig}.Substring(2,2)
        $DAY = ${date_orig}.Substring(4,2)
        if (${date_orig}.Substring(0,1) -eq 9){ #19xx
            $my_date = "19"+$YEAR+"-"+$MON+"-"+$DAY
        }
        else { #2xxx
            $my_date = "20"+$YEAR+"-"+$MON+"-"+$DAY
        }
    }

    $isDate = $false
    try {
        $parsedDate = ([DateTime]::ParseExact($my_date, "yyyy-MM-dd", [System.Globalization.CultureInfo]::InvariantCulture))
        $isDate = $true
    }
    catch {
        $isDate = $false
    }

    if($isDate){
        echo $my_date
		
        $FOLDER_INNER_COUNTER = 1
	    $files = (Get-ChildItem -Path "${folder_CHECK}\" -Filter "*.flac" -Recurse -File| Select-Object FullName)
        foreach ($file in $files){
                $file_src=$file.FullName
                #echo "Process: $file_src"

                # exameple: python3 flac_add_genre.py "test.flac" "2023-01-01"
                python3 flac_add_date.py "$file_src" "$my_date"
            
                $FOLDER_INNER_COUNTER = $FOLDER_INNER_COUNTER + 1
        }
    }
	
	$counter = $counter + 1
}