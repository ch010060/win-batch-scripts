# find depth at first
$depth_ht = @{}
(cmd /c dir /ad /s) -replace '[^\\]','' |
 foreach {$depth_ht[$_]++}

 $max_depth = 
  $depth_ht.keys |
   sort length |
   select -last 1 |
   select -ExpandProperty length

 $root_depth =
  ($PWD -replace '[^\\]','').length

 $dir_depth=($max_depth -$root_depth)
 

 For ($i=0; $i -le $dir_depth; $i++) {
 Get-ChildItem -Exclude *.bat,*.ps1 -Recurse | Rename-Item ¡VNewName { $_.name ¡Vreplace ¡§ ¡§,¡¨_¡¨ }
 }