@echo off
rem make script for ReactOS Modern theme
rem ------------------------------------------------------

setlocal EnableDelayedExpansion
set _dir=%cd%
set _prefix=bin

if not [%~1] == [] (
	set _prefix=%~1
)

call :main
endlocal
exit /B 0


:main (
	call :rmbin
	call :mkbin
	call :mklang
	call :mkwallpaper
	call :mkbitmaps
	exit /B 0
)


:mkbin (
	echo [+] creating directory tree..
    mkdir "%_prefix%"
    mkdir "%_prefix%\media"
    mkdir "%_prefix%\media\themes"
    mkdir "%_prefix%\media\themes\modern.msstyles"
	mkdir "%_prefix%\media\themes\modern.msstyles\lang"
	mkdir "%_prefix%\media\themes\modern.msstyles\bitmaps"
    mkdir "%_prefix%\modules"
    mkdir "%_prefix%\modules\wallpapers"
    mkdir "%_prefix%\modules\wallpapers\Silhouette"
    exit /B 0
)

:mklang (
	echo [+] copying theme language files..
	xcopy "%_dir%\src\modern.msstyles\lang\*" ^
	"%_prefix%\media\themes\modern.msstyles\lang\"
	exit /B 0
)

:mkwallpaper (

	echo [x] building theme wallpapers...
	call "%_dir%\scripts\convertpng.cmd" "%_dir%\src\wallpapers\Silhouette\"

	echo [+] moving theme wallpapers....
	for /r "%_dir%\src\wallpapers\Silhouette\" %%f in (*.png) do (
		move "%%f" "%_prefix%\modules\wallpapers\Silhouette\"
	)

	echo [+] copying LICENSE for theme wallpapers....
	copy "%_dir%\src\wallpapers\LICENSE" ^
	"%_prefix%\modules\wallpapers\Silhouette\"

	echo [+] updating wallpapers CMake....
	copy "%_dir%\src\wallpapers\Silhouette\CMakeLists.txt" ^
	"%_prefix%\modules\wallpapers\Silhouette\CMakeLists.txt"
	type "%_dir%\src\wallpapers\CMakeLists.txt" ^
	>> "%_prefix%\modules\wallpapers\CMakeLists.txt"
	exit /B 0
)

:mkbitmaps (
	echo [+] building theme bitmaps....
	REM call "%_dir%\scripts\convertbmp.cmd" ^
	REM "%_dir%\src\modern.msstyles\bitmaps\"

	echo [+] moving theme bitmaps....
	for /R "%_dir%\src\modern.msstyles\bitmaps\" %%f in (*.bmp) do (
	 	move "%%f" "%_prefix%\media\themes\modern.msstyles\bitmaps\"
	)
	exit /B 0
)