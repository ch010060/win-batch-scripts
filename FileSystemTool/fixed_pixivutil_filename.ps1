### Fixed "%urlFilename%" to "%works_date_fmt{%Y-%m-%d}% %title%" for PixivUtil2
### https://github.com/Nandaka/PixivUtil2

function cut {
  param(
    [Parameter(ValueFromPipeline=$True)] [string]$inputobject,
    [string]$delimiter='\s+',
    [string[]]$field
  )

  process {
    if ($field -eq $null) { $inputobject -split $delimiter } else {
      ($inputobject -split $delimiter)[$field] }
  }
}


# Replace space with underscore in all filenames
replaceSpaceWithUnderscore.ps1

$files = get-childitem -recurse | where {! $_.PSIsContainer}
foreach ($file in $files)
{
    # Get filename
    $filename = $file.Name
    
    # Get last Modified Time
    $lastModifiedTime = (Get-Item $filename).LastWriteTime.ToString("yyyy MM-dd")
    
    # Check unnecessary string
    $checkString = echo $filename | cut -d _ -f 4
    
    if([string]::IsNullOrWhiteSpace($checkString)){
        $newfilename = "_"+$filename
    } else {
        # Get unnecessary string
        $rmString = echo $filename | cut -d _ -f 2
        
        # Remove unnecessary string
        $newfilename = echo $filename | % {$_.replace("$rmString"+"_-_","")}
    }
    
    # Add last Modified Time
    $newfilename = "$($lastModifiedTime) $($newfilename)"
    
    # Rename
    # echo $newfilename
    
    #
    rename-item -path "$filename" -newname "$newfilename"
}