$BaseDir = "<SRC_PATH>"
$NameToFind1 = "*アニメ「*"
$NameToFind2 = "*アニメ『*"
$NameToFind3 = "*映画「*"
$NameToFind4 = "*映画『*"
$NameToFind5 = "*劇場版「*"
$NameToFind6 = "*劇場版『*"
$NameToFind7 = "*OVA「*"
$NameToFind8 = "*OVA『*"
$NameToFind9 = "*ゲーム「*"
$NameToFind10 = "*ゲーム『*"

# Find DIR names match filter
$folders = (Get-ChildItem -Path $BaseDir -Include $NameToFind1,$NameToFind2,$NameToFind3,$NameToFind4,$NameToFind5,$NameToFind6,$NameToFind7,$NameToFind8,$NameToFind9,$NameToFind10 -Recurse -Directory).Fullname
$totalNum = $folders.Count
$counter = 1
foreach ($folder in $folders){
	echo "($counter/$totalNum) $folder"
    $folder_CHECK = $folder.replace("]","``]").replace("[","``[")

    $found = $folder -match '(([ア][ニ][メ])|([映][画])|([劇][場][版])|([O][V][A])|([ゲ][ー][ム]))[「].*[」]'
    $my_tag = ""
    if ($found) {# match filter1
        $str = $matches[0] -split '「',2
        $str2 = $str[1] -split '」',2
        $my_tag = $str2[0]
    }
    else {# match filter2
        $found = $folder -match '(([ア][ニ][メ])|([映][画])|([劇][場][版])|([O][V][A])|([ゲ][ー][ム]))[『].*[』]'
        $my_tag = ""
        if ($found) {
            $str = $matches[0] -split '『',2
            $str2 = $str[1] -split '』',2
            $my_tag = $str2[0]
        }
    }
	
	# Revert windows invalid naming
	$my_tag = $my_tag.replace("／","/").replace("＼","\").replace("：",":").replace("？","?").replace("＞",">").replace("＜","<").replace("＊","*")
	# Revert other full to half character
	$my_tag = $my_tag.replace("！","!").replace("～","~").replace("　"," ").replace("＆","&").replace("－","-")
	# Revert japanese string
	$my_tag = $my_tag.replace("０","0").replace("１","1").replace("２","2").replace("３","3").replace("４","4").replace("５","5").replace("６","6").replace("７","7").replace("８","8").replace("９","9")
	# Revert roon pattern
	$my_tag = $my_tag.replace(";","；")
	echo "Tag: $my_tag"
		
    if($my_tag){# Make sure we got the filter name to be the tag
		Get-ChildItem -Path "${folder_CHECK}\" -Filter "*.flac" -Recurse -File| Select-Object FullName | ForEach-Object {
            $file_src=$_.FullName
            $tag_name="ROONALBUMTAG"
            $tag_value="$my_tag"
            #echo "Process: $file_src" | Tee-Object add_roonalbumtag.log -Append
            #echo "Tag: $my_tag" | Tee-Object add_roonalbumtag.log -Append
            # exameple: python3 flac_add_tag.py "test.flac" "ROONALBUMTAG" "$"
            python3 flac_add_tag.py "$file_src" "$tag_name" "$tag_value"
        }
    }
	
	$counter = $counter + 1
}