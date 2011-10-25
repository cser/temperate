@echo off
%~d0
cd "%~dp0"
cd bin
neko assets-generator.n ^
-sfwmillPath "C:\Program Files\FlashDevelop\Tools\swfmill\swfmill.exe"

pause
