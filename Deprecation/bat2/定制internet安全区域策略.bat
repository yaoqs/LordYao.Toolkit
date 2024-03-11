@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在定制
pause
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings] >>temp.reg
echo "Security_HKLM_only"=dword:00000001 >>temp.reg
echo "Security_options_edit"=dword:00000001 >>temp.reg
echo "Security_zones_map_edit"=dword:00000001 >>temp.reg
echo 成功
pause
regedit /s temp.reg
del /q /f temp.reg >nul 