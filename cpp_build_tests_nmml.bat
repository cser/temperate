@echo off
haxelib run nme test cpp_build_tests.nmml windows
if ERRORLEVEL 1 goto :pause
goto :done
:pause
pause
:done
