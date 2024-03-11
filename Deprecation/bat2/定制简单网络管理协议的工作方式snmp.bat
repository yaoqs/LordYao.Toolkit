@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在定制中
pause
echo [+HKEY_LOCAL_MACHINE\SOFTWARE\Policies\SNMP\Parameters\VaildCommunities] >>temp.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\SNMP\Parameters\VaildCommunities] >>temp.reg
echo "1"="widigroup" >>temp.reg
echo [+HKEY_LOCAL_MACHINE\SOFTWARE\Policies\SNMP\Parameters\TrapConfiguration\public] >>temp.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\SNMP\Parameters\TrapConfiguration\public] >>temp.reg
echo "1"="trap1" >>remp.reg
echo [+HKEY_LOCAL_MACHINE\SOFTWARE\Policies\SNMP\Parameters\PermittedManagers] >>temp.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\SNMP\Parameters\PermittedManagers] >>temp.reg
echo "1"="manager1" >>temp.reg
echo 成功
pause
regedit /s temp.reg
del /q /f temp.reg >nul 