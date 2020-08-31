<#
img1 => img001
img11 => img011
img999 => img999
#>

$ToNatural = { [regex]::Replace($_, '\d+', { $args[0].Value.PadLeft(20,"0") }) }
$filenamelist = Get-ChildItem .\* -Include *.jpg | sort $ToNatural
$prefix = "img"

foreach ($filename in $filenamelist)
{
$number = $filename.BaseName.Replace($prefix, "")
$Newfilename = ([string]$number).PadLeft(3,'0')
$NewExtension = $filename.Extension
ren $filename.Name $Newfilename$NewExtension
}