@echo off
haxe different-versions.hxml
if ERRORLEVEL 1 goto :pause
goto :done
:pause
pause
:done
