@echo off
rem 锁定计算机后，用户只有输入正确的密码才能重新登录
echo 正在锁定计算机
rundll32.exe user32.dll,LockWorkStation