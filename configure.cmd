@ECHO OFF
rem make script for ReactOS Modern theme
rem ------------------------------------------------------

if not [%~1] == [] (
	set _dir=%~1
	call :main
	exit /B 0
)

echo USAGE:
echo .\configure.cmd "\path\to\reactos"
exit /B 0


:main (
	call :rmbin
	call :mkbin
	call :mklang
	call :mkwallpaper
	exit /B 0
)

:rmbin (
	echo [-] cleaning build directory..
    del /s /q "%_dir%\bin\"
	rmdir /s /q "%_dir%\bin\"
	exit /B 0
)


:mkbin (
	echo [+] creating directory tree..
    mkdir "\%_dir%\bin\"
    mkdir "\%_dir%\bin\media"
    mkdir "\%_dir%\bin\media\themes"
    mkdir "\%_dir%\bin\media\themes\modern.msstyles"
    mkdir "\%_dir%\bin\modules"
    mkdir "\%_dir%\bin\modules\wallpapers"
    mkdir "\%_dir%\bin\modules\wallpapers\Silhouette"
    exit /B 0
)

:mklang (
	echo [+] copying theme language files..
	xcopy "%_dir%\src\modern.msstyles\lang"^
	"%_dir%\bin\media\themes\modern.msstyles\lang\"
	exit /B 0
)

:mkwallpaper (
	echo [+] copying theme wallpapers....
	xcopy "%_dir%\src\wallpapers\Silhouette\*"^
	"%_dir%\bin\modules\wallpapers\Silhouette\*"
	type "%_dir%\src\wallpapers\CMakeLists.txt" ^
	>> "%_dir%\bin\modules\wallpapers\CMakeLists.txt"
	exit /B 0
)