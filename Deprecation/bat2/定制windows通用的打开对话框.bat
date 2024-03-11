@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在定制windows通用的打开对话框
pause
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Comdlg32] >>temp.reg
echo "NoBackButton"=dword:00000001 >>temp.reg
echo "NoFileMru"=dword:00000001 >>temp.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Comdlg32\Placesbar] >>temp.reg
echo "Place0"="e:\download" >>temp.reg
echo "Place1"="MyMusic" >>temp.reg
echo "Place2"="\\lovesarah\movie" >>temp.reg
echo "Place3"="Desktop" >>temp.reg
echo "Place4"="ProgramFiles" >>temp.reg
echo 成功按要求定制了打开对话框的操作界面
echo.
pause
regedit /s temp.reg
del /q /f temp.reg >nul 