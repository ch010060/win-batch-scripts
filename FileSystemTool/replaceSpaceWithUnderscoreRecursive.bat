forfiles /s /m *.* /C "cmd /e:on /v:on /c set \"Phile=@file\" & if @ISDIR==FALSE ren @file !Phile: =_!"
forfiles /s /C "cmd /e:on /v:on /c set \"Phile=@file\" & if @ISDIR==TRUE ren @file !Phile: =_!"