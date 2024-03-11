@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在修复关机后未能正常关闭机器电源故障
pause
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]>>temp.reg
echo "PowerdownAfterShutdown"="0" >>temp.reg
echo 正在修复关机后系统自动重启故障
pause
echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\shutdown]>>temp.reg
echo "ShutdownSetting"="1" >>temp.reg
echo 正在设置关机时等待自动结束任务时间
pause
echo [HKEY_CURRENT_USER\Control Panel\Desktop]>>temp.reg
echo "AutoEndTasks"="1" >>temp.reg
echo "WaitTokillAppTimeout"="10000" >>temp.reg
echo 正在设置关机时等待自动结束服务时间
pause
echo [HKEY_LOCAL_MACHINE\SOFTWARE\System\CurrentControlSet\Control]>>temp.reg
echo "WaitToKillServiceTimeout"="10000" >>temp.reg
echo.
pause
regedit /s temp.reg
del /q /f temp.reg >nul 