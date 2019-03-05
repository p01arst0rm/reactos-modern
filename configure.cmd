@ECHO OFF
rem make script for ReactOS Modern theme
rem ------------------------------------------------------

if not [%~1] == [] (
	set _dir=%cd%
	set _prefix=%~1
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
    del /s /q "%_prefix%\bin\"
	rmdir /s /q "%_prefix%\bin\"
	exit /B 0
)


:mkbin (
	echo [+] creating directory tree..
    mkdir "%_prefix%\bin\"
    mkdir "%_prefix%\bin\media"
    mkdir "%_prefix%\bin\media\themes"
    mkdir "%_prefix%\bin\media\themes\modern.msstyles"
    mkdir "%_prefix%\bin\modules"
    mkdir "%_prefix%\bin\modules\wallpapers"
    mkdir "%_prefix%\bin\modules\wallpapers\Silhouette"
    exit /B 0
)

:mklang (
	echo [+] copying theme language files..
	xcopy "%_prefix%\src\modern.msstyles\lang"^
	"%_prefix%\bin\media\themes\modern.msstyles\lang\"
	exit /B 0
)

:mkwallpaper (
	echo [x] converting TIF images to png...
	call "scripts\convert.cmd" "src\wallpapers\TIF\"

	echo [+] copying theme wallpapers....
	for /R "%_prefix%\src\wallpapers\TIF\" %%f in (*.png) do (
		move "%%f" "%_prefix%\bin\modules\wallpapers\Silhouette\"
	)

	echo [+] copying LICENSE for theme wallpapers....
	move "%_prefix%\src\wallpapers\LICENSE"^
	"%_prefix%\bin\modules\wallpapers\Silhouette\"

	echo [+] appending wallpapers to CMake....
	type "%_prefix%\src\wallpapers\CMakeLists.txt" ^
	>> "%_prefix%\bin\modules\wallpapers\CMakeLists.txt"
	exit /B 0
)

:mkbitmaps (
	echo [+] building theme bitmaps....

	exit /B 0
)