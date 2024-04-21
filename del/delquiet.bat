@echo off
echo made by 老妖
echo 版权所有，翻版请注明出处
::@pause>nul 2>nul
@if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (Set b=%SystemRoot%\SysWOW64)  else (set b=%systemroot%\system32)
@ping -n 3 127.1 >nul 2>nul
@if exist %1 del /f /s /q %1
@if exist %1 rd /s /q %1
@ping -n 3 127.1 >nul 2>nul
@mshta VBScript:Msgbox("安全、安静删除，不留痕迹",vbSystemModal,"kingson")(close)
if exist "%b%\taskkill.exe" taskkill /f /t /im "mshta.exe">nul 2>nul
exit