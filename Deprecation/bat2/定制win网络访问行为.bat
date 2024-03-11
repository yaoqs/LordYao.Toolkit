@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在定制
pause
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet004\Control\Lsa] >>temp.reg
echo "ForceGuest"=dword:00000000 >>temp.reg
echo "RestrictAnonymousSAM"=dword:00000001 >>temp.reg
echo "RestrictAnonymous"=dword:00000001 >>temp.reg
echo "DisableDomainCreds"=dword:00000001 >>temp.reg
echo "EveryoneIncludesAnonymous"=dword:00000000 >>temp.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet004\Services\lanmanserver\parameters] >>temp.reg
echo "NullSessionShares"=hex(7):00,00,00,00 >>temp.reg
echo "NullSessionPips"=hex(7):00,00,00,00 >>temp.reg
echo 成功
pause
regedit /s temp.reg
del /q /f temp.reg >nul 