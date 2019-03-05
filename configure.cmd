@ECHO OFF
rem make script for ReactOS Modern theme
rem ------------------------------------------------------

set _dir=%cd%

:main
	call :mkbin
	call :mklang
	call :mkwallpaper
	exit /B 0


:mkbin
	echo [-] cleaning build directory..
    del /s /q "bin\"
	rmdir /s /q "bin\"
	echo [+] creating directory tree..
    mkdir "bin\"
    mkdir "bin\media"
    mkdir "bin\media\themes"
    mkdir "bin\media\themes\modern.msstyles"
    mkdir "bin\modules"
    mkdir "bin\modules\wallpapers"
    mkdir "bin\modules\wallpapers\Silhouette"
    exit /B 0

:mklang
	echo [+] copying theme language files..
	xcopy "%_dir%\src\modern.msstyles\lang"^
	"%_dir%\bin\media\themes\modern.msstyles\lang\"
	exit /B 0

:mkwallpaper
	echo [+] copying theme wallpapers....
	xcopy "%_dir%\src\wallpapers\Silhouette"^
	"%_dir%\bin\modules\wallpapers\Silhouette"
	type "%_dir%\src\wallpapers\CMakeLists.txt" ^
	>> "%_dir%\bin\modules\wallpapers\CMakeLists.txt"
	exit /B 0
