REM Of couse, you can use Sam HaXe insteard of assets-generator and swfmill
@echo off
%~d0
cd "%~dp0"
cd ..
cd ..
cd ..
cd ..
neko assets-generator/bin/assets-generator.n ^
-inputPath "examples/button-skinning-example/src/assets/images" ^
-outputPath "examples/button-skinning-example/src/assets/generated" ^
-packageName "assets.generated" ^
-sfwmillPath "C:\Program Files\FlashDevelop\Tools\swfmill\swfmill.exe" ^
-outputSwfPath "examples/button-skinning-example/src/assets/assets.swf" ^
-swfmillXmlPath "examples/button-skinning-example/src/assets/swfmill-build.xml" ^
-assetsPath "examples/button-skinning-example/src/assets/images"

pause
