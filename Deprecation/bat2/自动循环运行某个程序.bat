@echo off
echo 正在测试是否可以ping通主机
:again
ping 127.1>nul
if not %errorlevel% equ 0 goto again
start "可正常与主机通讯" echo 现在可以正常ping通主机 