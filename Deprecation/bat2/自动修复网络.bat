@echo off
echo 正在清楚arp缓存
arp -d >nul 2>&0
echo 正在清除netbeui缓存
nbtstat -r >nul 2>&0
rem  2>&0:将命令执行出错的信息转到键盘输入流，而不显示在命令行窗口
echo 正在清除dns缓存
dnscmd /clearcache >nul  2>&0
echo 成功修复网络连接