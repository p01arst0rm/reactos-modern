@echo off 
rem --------------------------------------------------------------------
rem 
rem Convert PNG Images to gif using gimp and it's script-fu capabilities
rem --------------------------------------------------------------------
rem Usage: 
rem convert.cmd C:\path\to\tiff\directory
rem --------------------------------------------------------------------

setlocal EnableDelayedExpansion
set _gimp="C:\Program Files\GIMP 2\bin\gimp-console-2.10.exe"
set count=1
set max_count=0

if not [%~1] == [] (
    if not [%~2] == [] (
        set _dir=%~1
        set _prefix=%~2

        rem replace \ in path for / (compatibility)
        set _nix_dir=!_dir:\=/!
        set _nix_prefix=!_prefix:\=/!
        
        call :main
    	exit /B 0
    )
)

echo USAGE:
echo .\configure.cmd "\path\to\TIF" "\build\path"
endlocal
exit /B 0


:main (
    for /r "%_dir%\" %%i in (*.tif) DO (
        set /a "max_count+=1"
    )
    for /r "%_dir%\" %%i in (*.tif) DO (
        CALL :convert_file %%i
        set /a "count+=1"    
    )
	exit /B 0
)

:convert_file
    set _target=%~d1%~p1

    set _target=!_target:\=/!
    set inp_file=%~n1.tif
    set out_file=%~n1.bmp
    
    echo [ CONVERTING ] (%count%/%max_count%):
    echo %inp_file%
    echo %out_file%

    set gimp_script=(let* ((img (car 
    set gimp_script=%gimp_script% (file-tiff-load 1 \"%_nix_dir%%inp_file%\" \"%_nix_dir%%inp_file%\")))
    set gimp_script=%gimp_script% (drawable (car (gimp-image-active-drawable img))))
    set gimp_script=%gimp_script% (file-bmp-save 1 img drawable \"%_nix_prefix%%out_file%\" \"%_nix_prefix%%out_file%\"))
    set gimp_script=%gimp_script% (gimp-quit 0))
    
    echo ""
    echo %gimp_script%
    echo ""

    %_gimp% -c -i -d -b "%gimp_script%"
    exit /B 0