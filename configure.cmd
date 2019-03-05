@ECHO OFF
rem make script for ReactOS Modern theme
rem ------------------------------------------------------

set _dir=%cd%

:mkbin
    del /s /q "bin\"
	rmdir /s /q "bin\"
    mkdir "bin\"
    mkdir "bin\media"
    mkdir "bin\media\themes"
    mkdir "bin\media\themes\modern.msstyles"
    mkdir "bin\modules"
    mkdir "bin\modules\wallpapers"
    mkdir "bin\modules\wallpapers\Silhouette"
    exit /B 0

call :mkbin

main
