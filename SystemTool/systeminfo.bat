    : FULL SYSTEM INFO    
    : START CMD    

    : Set the dialog title    
    title FULL SYSTEM INFO    

    @echo off    

    : Display nothing but add whitespace    
     echo.

    : Displaying text    
    echo Exporting System Info...

    : Using the SYSTEMINFO command and export it directly into a text file    
    SYSTEMINFO>INFO.txt

    : Display nothing but add whitespace    
    echo.

    : Displaying text    
    echo INFO.txt Exported!

    : Open the newly exported file in notepad    
    notepad.exe INFO.txt    

    : Wait on user    
    pause    

    : STOP CMD