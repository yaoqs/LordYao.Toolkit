@echo off
echo made by 老妖
echo 版权所有，翻版请注明出处
::@pause>nul 2>nul
@ping -n 3 127.1 >nul 2>nul
@if exist %1 del /f /s /q %1
@if exist %1 rd /s /q %1
@ping -n 3 127.1 >nul 2>nul
exit