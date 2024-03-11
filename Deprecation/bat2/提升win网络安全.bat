@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在定制
pause
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet004\Control\Lsa] >>temp.reg
echo "LmCompatibilityLevel"=dword:00000000 >>temp.reg
echo "NoLMHash"=dword:00000001 >>temp.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet004\Services\ldap] >>temp.reg
echo "LDAPClientIntegrity"=dword:00000001 >>temp.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet004\Control\Lsa\MSV1_0] >>temp.reg
echo "NTLMMinServerSec"=dword:20080030 >>temp.reg
echo "NTLMMinClientSec"=dword:20080030 >>temp.reg
echo 成功
pause
regedit /s temp.reg
del /q /f temp.reg >nul 