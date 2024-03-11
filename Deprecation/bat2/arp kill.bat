@echo off
::读取本机Mac地址
if exist ipconfig.txt del ipconfig.txt
ipconfig /all >ipconfig.txt
if exist phyaddr.txt del phyaddr.txt
find "Physical Address" ipconfig.txt >phyaddr.txt
for /f "skip=2 tokens=12" %%M in (phyaddr.txt) do set Mac=%%M
::读取本机ip地址
if exist IPAddr.txt del IPaddr.txt
find "IP Address" ipconfig.txt >IPAddr.txt
for /f "skip=2 tokens=15" %%I in (IPAddr.txt) do set IP=%%I
::绑定本机IP地址和MAC地址
arp -s %IP% %Mac%
::读取网关地址
if exist GateIP.txt del GateIP.txt
find "Default Gateway" ipconfig.txt >GateIP.txt
for /f "skip=2 tokens=13" %%G in (GateIP.txt) do set GateIP=%%G
::读取网关Mac地址
if exist GateMac.txt del GateMac.txt
arp -a %GateIP% >GateMac.txt
for /f "skip=3 tokens=2" %%H in (GateMac.txt) do set GateMac=%%H
::绑定网关Mac和IP
arp -s %GateIP% %GateMac%
arp -s 网关IP 网关MAC
exit
------------------------------------------------------------------*
@echo off
for /f "delims=: tokens=2" %%a in ('ipconfig /all^|find "Physical Address"') do set local_mac=%%a
for /f "delims=: tokens=2" %%a in ('ipconfig /all^|find "IP Address"') do set local_ip=%%a
for /f "delims=: tokens=2" %%a in ('ipconfig /all^|find "Default Gateway"') do set gate_ip=%%a
fo* /* %%* in ('getmac /nh /s %local_ip%') do set gate_mac=%%a
arp -s %local_ip% %local_mac%
arp -s %gate_ip% %gate_mac% （这个地方有问题，改进中……）


***************************************************************
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
for /f "tokens=2 delims=[]=" %%i in ('nbtstat -a %COMPUTERNAME%') do call set local=!local!%%i
for /f "tokens=3" %%i in ('netstat -r^|find " 0.0.0.0"') do set gm=%%i
for /f "tokens=1,2" %%i in ('arp -a %gm%^|find /i /v "inter"') do set gate=%%i %%j
arp -s %gate%
arp -s %local%
---------------------------------------------------------
@echo off

:::::::::::::清除所有的ARP缓存
arp -d

:::::::::::::读取本地连接配置
ipconfig /all>ipconfig.txt

:::::::::::::读取内网网关的IP
for /f "tokens=13" %%I in ('find "Default Gateway" ipconfig.txt') do set GatewayIP=%%I

:::::::::::::PING三次内网网关
ping %GatewayIP% -n 3

:::::::::::::读取与网关arp缓存
arp -a|find "%GatewayIP%">arp.txt

:::::::::::::读取网关MAC并绑定
for /f "tokens=1,2" %%I in ('find "%GatewayIP%" arp.txt') do if %%I==%GatewayIP% arp -s %%I %%J

:::::::::::::读取本机的 IP+MAC
for /f "tokens=15" %%i in ('find "IP Address" ipconfig.txt') do set ip=%%i
for /f "tokens=12" %%i in ('find "Physical Address" ipconfig.txt') do set mac=%%i

:::::::::::::绑定本机的 IP+MAC
arp -s %ip% %mac%

:::::::::::::删除所有的临时文件
del ipconfig.txt
del arp.txt
exit