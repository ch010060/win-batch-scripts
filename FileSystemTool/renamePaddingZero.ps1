<#
01 => 001
011 => 011
999 => 999
#>

$ToNatural = { [regex]::Replace($_, '\d+', { $args[0].Value.PadLeft(20,"0") }) }
$filenamelist = Get-ChildItem .\* -Include *.jpg | sort $ToNatural

foreach ($filename in $filenamelist)
{
$number = $filename.BaseName
$Newfilename = ([string]$number).PadLeft(3,'0')
$NewExtension = $filename.Extension
ren $filename.Name $Newfilename$NewExtension
}