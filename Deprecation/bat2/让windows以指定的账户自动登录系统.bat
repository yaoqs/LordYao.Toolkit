@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在设置自动登录当前系统的账户
pause
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\Winlogon]>>temp.reg
echo "Autoadminlogon"="1" >>temp.reg
echo "Defaultusername"="normalaccount" >>temp.reg
echo "Defaultpassword"="noprivilege" >>temp.reg
echo.
pause
echo 成功将"normalaccount"账户设为当前自动登录的账户
regedit /s temp.reg
del /q /f temp.reg >nul 