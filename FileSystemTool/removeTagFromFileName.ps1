cd .\cover
get-childitem *.* | foreach { rename-item $_ $_.Name.Replace("top", "") }