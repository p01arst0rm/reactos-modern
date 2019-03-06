@echo off 
rem --------------------------------------------------------------------
rem 
rem Convert PNG Images to gif using gimp and it's script-fu capabilities
rem --------------------------------------------------------------------
rem Usage: 
rem convert.cmd C:\path\to\tiff\directory
rem --------------------------------------------------------------------

setlocal enabledelayedexpansion
set _gimp="C:\Program Files\GIMP 2\bin\gimp-console-2.10.exe"
set count=1
set max_count=0

if not [%~1] == [] (
        set _dir=%~1
        call :main
    	exit /B 0
)

echo USAGE:
echo .\configure.cmd "\path\to\TIF"
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
    rem replace \ in path for / (compatibility)
    set _target=!_target:\=/!
    set inp_file=%~n1.tif
    set out_file=%~n1.png
    
    echo [ CONVERTING ] (%count%/%max_count%):
    echo %inp_file%
    echo %out_file%

    set gimp_script=(let* ((img (car 
    set gimp_script=%gimp_script% (file-tiff-load 1 \"%_target%%inp_file%\" \"%_target%%inp_file%\")))
    set gimp_script=%gimp_script% (drawable (car (gimp-image-active-drawable img))))
    set gimp_script=%gimp_script% (file-png-save 1 img drawable \"%_target%%out_file%\" \"%_target%%out_file%\" 1 0 0 0 0 0 0))
    set gimp_script=%gimp_script% (gimp-quit 0))
    
    echo ""
    echo %gimp_script%
    echo ""

    %_gimp% -c -i -d -b "%gimp_script%"
    exit /B 0