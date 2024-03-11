@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在关闭xp特殊效果，以便节省系统资源
pause
echo [HKEY_CURRENT_USER\Control Panel\Desktop]>>temp.reg
echo "CursorBlinkRate"="-1" >>temp.reg
echo "MenuShowDelay"="400" >>temp.reg
echo "SmoothScroll"=dword:00000000 >>temp.reg
echo [HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics] >>temp.reg
echo "Shell Icon Size"="32" >>temp.reg
echo "shell Icon BPP"="16" >>temp.reg
echo [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer] >>temp.reg
echo "Max Cached Icons"=dword:00000800 >>temp.reg
echo 成功关闭了windows特殊显示效果
pause
regedit /s temp.reg
del /q /f temp.reg >nul 