@echo off
echo Windows Registry Editor Version 5.00 >temp.reg
echo 正在禁用系统的默认共享
pause
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters]>>temp.reg
echo "AutoShareServer"=dword:00000000 >>temp.reg
echo "AutoShareWks"=dword:00000000 >>temp.reg
echo 正在限制IPC$共享方式
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]>>temp.reg
echo "restrictanonymous"=dword:00000001 >>temp.reg
echo 成功完成禁用系统默认共享
pause
regedit /s temp.reg
del /q /f temp.reg >nul 