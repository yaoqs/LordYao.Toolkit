@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在定制服务质量策略
pause
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched] >>temp.reg
echo "NonBestEffortLimit"=dword:0000000A>>temp.reg
echo "MaxOutstandingSends"=dword:0000FFFF >>temp.reg
echo "TimerResolution"=dword:00000008 >>temp.reg
echo 成功
pause
regedit /s temp.reg
del /q /f temp.reg >nul 