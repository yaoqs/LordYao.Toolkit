@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在定制
pause
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet004\Services\Netlogon\Parameters] >>temp.reg
echo "MaximumPasswordAge"=dword:0000001D >>temp.reg
echo "RefusePasswordChage"=dword:00000001 >>temp.reg
echo "DisablePasswordChage"=dword:00000001 >>temp.reg
echo "SealSecureChannel"=dword:00000001 >>temp.reg
echo "RequireSignOrSeal"=dword:00000001 >>temp.reg
echo "SignSecureChannel"=dword:00000001 >>temp.reg
echo "RequireStrongKey"=dword:00000001 >>temp.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet004\Control\Lsa] >>temp.reg
echo "SubmitControl"=dword:00000000 >>temp.reg
echo 成功
pause
regedit /s temp.reg
del /q /f temp.reg >nul 