@echo off中国剑客技术联盟专用“有害端口自动关闭器”会员版：神雕大侠
gpupdate >nul
rem For Client only
ipseccmd  -w REG -p "HFUT_SECU" -o -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -x >nul
rem ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/80" -f *+0:80:TCP -n BLOCK -x >nul
rem ipseccmd  -w REG -p "HFUT_SECU" -r "Block UDP/1434" -f *+0:1434:UDP -n BLOCK -x >nul
rem ipseccmd  -w REG -p "HFUT_SECU" -r "Block UDP/137" -f *+0:137:UDP -n BLOCK -x >nul
rem ipseccmd  -w REG -p "HFUT_SECU" -r "Block UDP/138" -f *+0:138:UDP -n BLOCK -x >nul
rem  echo 禁止网上邻居的文件传输（只要去掉上述两行的 REM 即可生效！）
rem ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/139" -f *+0:139:TCP -n BLOCK -x >nul 
rem echo 禁止NetBIOS/SMB服务和文件和打印机共享和SAMBA（去掉REM生效）
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/135" -f *+0:135:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block UDP/135" -f *+0:135:UDP -n BLOCK -x >nul
echo 禁止Location Service服务和防止 Dos 攻击…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/445" -f *+0:445:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block UDP/445" -f *+0:445:UDP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/1025" -f *+0:1025:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block UDP/139" -f *+0:139:UDP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/1068" -f *+0:1068:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/5554" -f *+0:5554:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/9995" -f *+0:9995:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/9996" -f *+0:9996:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/6129" -f *+0:6129:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block ICMP/255" -f *+0:255:ICMP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/43958" -f *+0:43958:TCP -n BLOCK -x >nul
echo 关闭流行危险端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/20034" -f *+0:20034:TCP -n BLOCK -x >nul
echo 关闭木马NetBus Pro开放的端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/1092" -f *+0:1092:TCP -n BLOCK -x >nul
echo 关闭蠕虫LoveGate开放的端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/3996" -f *+0:3996:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/4060" -f *+0:4060:TCP -n BLOCK -x >nul
echo 关闭木马RemoteAnything开放的端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/4590" -f *+0:4590:TCP -n BLOCK -x >nul
echo 关闭木马ICQTrojan开放的端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/1080" -f *+0:1080:TCP -n BLOCK -x >nul
echo 禁止代理服务器扫描…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/113" -f *+0:113:TCP -n BLOCK -x >nul
echo 禁止Authentication Service服务…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/79" -f *+0:79:TCP -n BLOCK -x >nul
echo 禁止Finger扫描…………OK！
ipseccmd  -w REG -p "HFUT_SECU" -r "Block UDP/53" -f *+0:53:UDP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/53" -f *+0:53:TCP -n BLOCK -x >nul
echo 禁止区域传递（TCP），欺骗DNS（UDP）或隐藏其他的通信…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/707" -f *+0:707:TCP -n BLOCK -x >nul
echo 关闭nachi蠕虫病毒监听端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/808" -f *+0:808:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/23" -f *+0:23:TCP -n BLOCK -x >nul
echo 关闭Telnet 和木马Tiny Telnet Server监听端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/520" -f *+0:520:TCP -n BLOCK -x >nul
echo 关闭Rip 端口…………OK！
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/1999" -f *+0:1999:TCP -n BLOCK -x >nul
echo 关闭木马程序BackDoor的默认服务端口…………OK！
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/2001" -f *+0:2001:TCP -n BLOCK -x >nul
echo 关闭马程序黑洞2001的默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/2023" -f *+0:2023:TCP -n BLOCK -x >nul
echo 关闭木马程序Ripper的默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/2583" -f *+0:2583:TCP -n BLOCK -x >nul
echo 关闭木马程序Wincrash v2的默认服务端口…………OK！
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/3389" -f *+0:3389:TCP -n BLOCK -x >nul
echo 关闭Windows 的远程管理终端（远程桌面）监听端口…………OK！
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/4444" -f *+0:4444:TCP -n BLOCK -x >nul
echo 关闭msblast冲击波蠕虫监听端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/4899" -f *+0:4899:TCP -n BLOCK -x >nul
echo 关闭远程控制软件（remote administrator)服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/5800" -f *+0:5800:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/5900" -f *+0:5900:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/8888" -f *+0:8888:TCP -n BLOCK -x >nul
echo 关闭远程控制软件VNC的两个默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/6129" -f *+0:6129:TCP -n BLOCK -x >nul
echo 关闭Dameware服务端默认监听端口（可变！）…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/6267" -f *+0:6267:TCP -n BLOCK -x >nul
echo 关闭木马广外女生的默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/660" -f *+0:660:TCP -n BLOCK -x >nul
echo 关闭木马DeepThroat v1.0 - 3.1默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/6671" -f *+0:6671:TCP -n BLOCK -x >nul
echo 关闭木马Indoctrination默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/6939" -f *+0:6939:TCP -n BLOCK -x >nul
echo 关闭木马PRIORITY默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/7306" -f *+0:7306:TCP -n BLOCK -x >nul
echo 关闭木马网络精灵默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/7511" -f *+0:7511:TCP -n BLOCK -x >nul
echo 关闭木马聪明基因的默认连接端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/7626" -f *+0:7626:TCP -n BLOCK -x >nul
echo 关闭木马冰河默认端口(注意可变！)…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/8011" -f *+0:8011:TCP -n BLOCK -x >nul
echo 关闭木马WAY2.4默认服务端口…………OK！
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/9989" -f *+0:9989:TCP -n BLOCK -x >nul
echo 关闭木马InIkiller默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/19191" -f *+0:19191:TCP -n BLOCK -x >nul
echo 关闭木马兰色火焰默认开放的telnet端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/1029" -f *+0:1029:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/20168" -f *+0:20168:TCP -n BLOCK -x >nul
echo 关闭lovegate 蠕虫所开放的两个后门端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/23444" -f *+0:23444:TCP -n BLOCK -x >nul
echo 关闭木马网络公牛默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/27374" -f *+0:27374:TCP -n BLOCK -x >nul
echo 关闭木马SUB7默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/30100" -f *+0:30100:TCP -n BLOCK -x >nul
echo 关闭木马NetSphere默认的服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/31337" -f *+0:31337:TCP -n BLOCK -x >nul
echo 关闭木马BO2000默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/45576" -f *+0:45576:TCP -n BLOCK -x >nul
echo 关闭代理软件的控制端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/50766" -f *+0:50766:TCP -n BLOCK -x >nul
echo 关闭木马Schwindler默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/61466" -f *+0:61466:TCP -n BLOCK -x >nul
echo 关闭木马Telecommando默认服务端口…………OK!

ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/31338" -f *+0:31338:TCP -n BLOCK -x >nul
echo 关闭木马Back Orifice默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/8102" -f *+0:8102:TCP -n BLOCK -x >nul
echo 关闭木马网络神偷默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2000" -f *+0:2000:TCP -n BLOCK -x >nul
echo 关闭木马黑洞2000默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/31339" -f *+0:31339:TCP -n BLOCK -x >nul
echo 关闭木马NetSpy DK默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2001" -f *+0:2001:TCP -n BLOCK -x >nul
echo 关闭木马黑洞2001默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/31666" -f *+0:31666:TCP -n BLOCK -x >nul
echo 关闭木马BOWhack默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/34324" -f *+0:34324:TCP -n BLOCK -x >nul
echo 关闭木马BigGluck默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7306" -f *+0:7306:TCP -n BLOCK -x >nul
echo 关闭木马网络精灵3.0，netspy3.0默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/40412" -f *+0:40412:TCP -n BLOCK -x >nul
echo 关闭木马The Spy默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/40421" -f *+0:40421:TCP -n BLOCK -x >nul
echo 关闭木马Masters Paradise默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/8011" -f *+0:8011:TCP -n BLOCK -x >nul
echo 关闭木马wry，赖小子，火凤凰默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/40422" -f *+0:40422:TCP -n BLOCK -x >nul
echo 关闭木马Masters Paradise 1.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/23444" -f *+0:23444:TCP -n BLOCK -x >nul
echo 关闭木马网络公牛，netbull默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/40423" -f *+0:40423:TCP -n BLOCK -x >nul
echo 关闭木马Masters Paradise 2.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/23445" -f *+0:23445:TCP -n BLOCK -x >nul
echo 关闭木马网络公牛，netbull默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/40426" -f *+0:40426:TCP -n BLOCK -x >nul
echo 关闭木马Masters Paradise 3.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/50505" -f *+0:50505:TCP -n BLOCK -x >nul
echo 关闭木马Sockets de Troie默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/27374" -f *+0:27374:TCP -n BLOCK -x >nul
echo 关闭木马Sub Seven 2.0+，77，东方魔眼默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/50766" -f *+0:50766:TCP -n BLOCK -x >nul
echo 关闭木马Fore默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/53001" -f *+0:53001:TCP -n BLOCK -x >nul
echo 关闭木马Remote Windows Shutdown默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/61466" -f *+0:61466:TCP -n BLOCK -x >nul
echo 关闭木马Telecommando默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/121" -f *+0:121:TCP -n BLOCK -x >nul
echo 关闭木马BO jammerkillahV默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/666" -f *+0:666:TCP -n BLOCK -x >nul
echo 关闭木马Satanz Backdoor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/65000" -f *+0:65000:TCP -n BLOCK -x >nul
echo 关闭木马Devil默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1001" -f *+0:1001:TCP -n BLOCK -x >nul
echo 关闭木马Silencer默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6400" -f *+0:6400:TCP -n BLOCK -x >nul
echo 关闭木马The tHing默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1600" -f *+0:1600:TCP -n BLOCK -x >nul
echo 关闭木马Shivka-Burka默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/12346" -f *+0:12346:TCP -n BLOCK -x >nul
echo 关闭木马NetBus 1.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1807" -f *+0:1807:TCP -n BLOCK -x >nul
echo 关闭木马SpySender默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/20034" -f *+0:20034:TCP -n BLOCK -x >nul
echo 关闭木马NetBus Pro默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1981" -f *+0:1981:TCP -n BLOCK -x >nul
echo 关闭木马Shockrave默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1243" -f *+0:1243:TCP -n BLOCK -x >nul
echo 关闭木马SubSeven默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1001" -f *+0:1001:TCP -n BLOCK -x >nul
echo 关闭木马WebEx默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/30100" -f *+0:30100:TCP -n BLOCK -x >nul
echo 关闭木马NetSphere默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1011" -f *+0:1011:TCP -n BLOCK -x >nul
echo 关闭木马Doly Trojan默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1001" -f *+0:1001:TCP -n BLOCK -x >nul
echo 关闭木马Silencer默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1170" -f *+0:1170:TCP -n BLOCK -x >nul
echo 关闭木马Psyber Stream Server默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/20000" -f *+0:20000:TCP -n BLOCK -x >nul
echo 关闭木马Millenium默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1234" -f *+0:1234:TCP -n BLOCK -x >nul
echo 关闭木马Ultors Trojan默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/65000" -f *+0:65000:TCP -n BLOCK -x >nul
echo 关闭木马Devil 1.03默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1245" -f *+0:1245:TCP -n BLOCK -x >nul
echo 关闭木马VooDoo Doll默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7306" -f *+0:7306:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1492" -f *+0:1492:TCP -n BLOCK -x >nul
echo 关闭木马FTP99CMP默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1170" -f *+0:1170:TCP -n BLOCK -x >nul
echo 关闭木马Streaming Audio Trojan默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1999" -f *+0:1999:TCP -n BLOCK -x >nul
echo 关闭木马BackDoor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/30303" -f *+0:30303:TCP -n BLOCK -x >nul
echo 关闭木马Socket23默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2001" -f *+0:2001:TCP -n BLOCK -x >nul
echo 关闭木马Trojan Cow默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6969" -f *+0:6969:TCP -n BLOCK -x >nul
echo 关闭木马Gatecrasher默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2023" -f *+0:2023:TCP -n BLOCK -x >nul
echo 关闭木马Ripper默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/61466" -f *+0:61466:TCP -n BLOCK -x >nul
echo 关闭木马Telecommando默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2115" -f *+0:2115:TCP -n BLOCK -x >nul
echo 关闭木马Bugs默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/12076" -f *+0:12076:TCP -n BLOCK -x >nul
echo 关闭木马Gjamer默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2140" -f *+0:2140:TCP -n BLOCK -x >nul
echo 关闭木马Deep Throat默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/4950" -f *+0:4950:TCP -n BLOCK -x >nul
echo 关闭木马IcqTrojen默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2140" -f *+0:2140:TCP -n BLOCK -x >nul
echo 关闭木马The Invasor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/16969" -f *+0:16969:TCP -n BLOCK -x >nul
echo 关闭木马Priotrity默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2801" -f *+0:2801:TCP -n BLOCK -x >nul
echo 关闭木马Phineas Phucker默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1245" -f *+0:1245:TCP -n BLOCK -x >nul
echo 关闭木马Vodoo默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/30129" -f *+0:30129:TCP -n BLOCK -x >nul
echo 关闭木马Masters Paradise默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5742" -f *+0:5742:TCP -n BLOCK -x >nul
echo 关闭木马Wincrash默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/3700" -f *+0:3700:TCP -n BLOCK -x >nul
echo 关闭木马Portal of Doom默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2583" -f *+0:2583:TCP -n BLOCK -x >nul
echo 关闭木马Wincrash2默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/4092" -f *+0:4092:TCP -n BLOCK -x >nul
echo 关闭木马WinCrash默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1033" -f *+0:1033:TCP -n BLOCK -x >nul
echo 关闭木马Netspy默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/4590" -f *+0:4590:TCP -n BLOCK -x >nul
echo 关闭木马ICQTrojan默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1981" -f *+0:1981:TCP -n BLOCK -x >nul
echo 关闭木马ShockRave默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5000" -f *+0:5000:TCP -n BLOCK -x >nul
echo 关闭木马Sockets de Troie默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/555" -f *+0:555:TCP -n BLOCK -x >nul
echo 关闭木马Stealth Spy默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5001" -f *+0:5001:TCP -n BLOCK -x >nul
echo 关闭木马Sockets de Troie 1.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2023" -f *+0:2023:TCP -n BLOCK -x >nul
echo 关闭木马Pass Ripper默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5321" -f *+0:5321:TCP -n BLOCK -x >nul
echo 关闭木马Firehotcker默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/666" -f *+0:666:TCP -n BLOCK -x >nul
echo 关闭木马Attack FTP默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5400" -f *+0:5400:TCP -n BLOCK -x >nul
echo 关闭木马Blade Runner默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/21554" -f *+0:21554:TCP -n BLOCK -x >nul
echo 关闭木马GirlFriend默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5401" -f *+0:5401:TCP -n BLOCK -x >nul
echo 关闭木马Blade Runner 1.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/50766" -f *+0:50766:TCP -n BLOCK -x >nul
echo 关闭木马Fore Schwindler默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5402" -f *+0:5402:TCP -n BLOCK -x >nul
echo 关闭木马Blade Runner 2.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/34324" -f *+0:34324:TCP -n BLOCK -x >nul
echo 关闭木马Tiny Telnet Server默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5569" -f *+0:5569:TCP -n BLOCK -x >nul
echo 关闭木马Robo-Hack默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/30999" -f *+0:30999:TCP -n BLOCK -x >nul
echo 关闭木马Kuang默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6670" -f *+0:6670:TCP -n BLOCK -x >nul
echo 关闭木马DeepThroat默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/11000" -f *+0:11000:TCP -n BLOCK -x >nul
echo 关闭木马Senna Spy Trojans默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6771" -f *+0:6771:TCP -n BLOCK -x >nul
echo 关闭木马DeepThroat默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/23456" -f *+0:23456:TCP -n BLOCK -x >nul
echo 关闭木马WhackJob默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6969" -f *+0:6969:TCP -n BLOCK -x >nul
echo 关闭木马GateCrasher默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/555" -f *+0:555:TCP -n BLOCK -x >nul
echo 关闭木马Phase0默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6969" -f *+0:6969:TCP -n BLOCK -x >nul
echo 关闭木马Priority默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5400" -f *+0:5400:TCP -n BLOCK -x >nul
echo 关闭木马Blade Runner默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7000" -f *+0:7000:TCP -n BLOCK -x >nul
echo 关闭木马Remote Grab默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/4950" -f *+0:4950:TCP -n BLOCK -x >nul
echo 关闭木马IcqTrojan默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7300" -f *+0:7300:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/9989" -f *+0:9989:TCP -n BLOCK -x >nul
echo 关闭木马InIkiller默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7301" -f *+0:7301:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor 1.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/9872" -f *+0:9872:TCP -n BLOCK -x >nul
echo 关闭木马Portal Of Doom默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7306" -f *+0:7306:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor 2.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/11223" -f *+0:11223:TCP -n BLOCK -x >nul
echo 关闭木马Progenic Trojan默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7307" -f *+0:7307:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor 3.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/22222" -f *+0:22222:TCP -n BLOCK -x >nul
echo 关闭木马Prosiak 0.47默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7308" -f *+0:7308:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor 4.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/53001" -f *+0:53001:TCP -n BLOCK -x >nul
echo 关闭木马Remote Windows Shutdown默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7789" -f *+0:7789:TCP -n BLOCK -x >nul
echo 关闭木马ICKiller默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5569" -f *+0:5569:TCP -n BLOCK -x >nul
echo 关闭木马RoboHack默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/9872" -f *+0:9872:TCP -n BLOCK -x >nul
echo 关闭木马Portal of Doom默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -x >nul

gpupdate >nul

echo 正在设置 IP 筛选器……
rem if exist %temp%\ipfilter.reg del %temp%\ipfilter.reg
echo Windows Registry Editor Version 5.00>%temp%\ipfilter.reg
echo.>>%temp%\ipfilter.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Tcpip\Parameters]>>%temp%\ipfilter.reg
echo "EnableSecurityFilters"=dword:00000001>>%temp%\ipfilter.reg
echo.>>%temp%\ipfilter.reg>>%temp%\ipfilter.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Tcpip\Parameters\Interfaces\{F3BBAABC-03A5-4584-A7A0-0251FA38B8B1}]>>%temp%\ipfilter.reg
echo "TCPAllowedPorts"=hex(07):32,00,31,00,00,00,38,00,30,00,00,00,34,00,30,00,30,\>>%temp%\ipfilter.reg
echo   00,30,00,00,00,00,00>>%temp%\ipfilter.reg
echo.>>%temp%\ipfilter.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters]>>%temp%\ipfilter.reg
echo "EnableSecurityFilters"=dword:00000001>>%temp%\ipfilter.reg
echo.>>%temp%\ipfilter.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{F3BBAABC-03A5-4584-A7A0-0251FA38B8B1}]>>%temp%\ipfilter.reg
echo "TCPAllowedPorts"=hex(07):32,00,31,00,00,00,38,00,30,00,00,00,34,00,30,00,30,\>>%temp%\ipfilter.reg
echo   00,30,00,00,00,00,00>>%temp%\ipfilter.reg
echo.>>%temp%\ipfilter.reg
regedit /s %temp%\ipfilter.reg
del %temp%\ipfilter.reg
echo IP 筛选器设置成功！
echo.
echo.
echo   “中国剑客技术联盟”提醒您的系统可以免受流行蠕虫病毒及木马后门的侵扰！！！
echo.
echo   ******** 中国剑客技术联盟http://bbs.2dai.com/提醒你：不要关闭窗口，请按任意键进行 Windows 服务器的过滤策略！ ********
echo.
pause>nul

rem For PC Server
ipseccmd -w REG -p "HFUT_SECU" -o -x
ipseccmd -w REG -p "HFUT_SECU" -x
rem ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/80" -f *+0:80:TCP -n BLOCK -x
rem ipseccmd -w REG -p "HFUT_SECU" -r "Block UDP/1434" -f *+0:1434:UDP -n BLOCK -x
rem ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/3389" -f *+0:3389:TCP -n BLOCK -x
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/445" -f *+0:445:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block UDP/445" -f *+0:445:UDP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/1025" -f *+0:1025:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block UDP/139" -f *+0:139:UDP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/1068" -f *+0:1068:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/5554" -f *+0:5554:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/9995" -f *+0:9995:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/9996" -f *+0:9996:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/6129" -f *+0:6129:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block ICMP/255" -f *+0:255:ICMP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/43958" -f *+0:43958:TCP -n BLOCK -x >nul
echo 关闭流行危险端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/20034" -f *+0:20034:TCP -n BLOCK -x >nul
echo 关闭木马NetBus Pro开放的端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/1092" -f *+0:1092:TCP -n BLOCK -x >nul
echo 关闭蠕虫LoveGate开放的端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/3996" -f *+0:3996:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/4060" -f *+0:4060:TCP -n BLOCK -x >nul
echo 关闭木马RemoteAnything开放的端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/4590" -f *+0:4590:TCP -n BLOCK -x >nul
echo 关闭木马ICQTrojan开放的端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/1080" -f *+0:1080:TCP -n BLOCK -x >nul
echo 禁止代理服务器扫描…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/113" -f *+0:113:TCP -n BLOCK -x >nul
echo 禁止Authentication Service服务…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/79" -f *+0:79:TCP -n BLOCK -x >nul
echo 禁止Finger扫描…………OK！
ipseccmd  -w REG -p "HFUT_SECU" -r "Block UDP/53" -f *+0:53:UDP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/53" -f *+0:53:TCP -n BLOCK -x >nul
echo 禁止区域传递（TCP），欺骗DNS（UDP）或隐藏其他的通信…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/707" -f *+0:707:TCP -n BLOCK -x >nul
echo 关闭nachi蠕虫病毒监听端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/808" -f *+0:808:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/23" -f *+0:23:TCP -n BLOCK -x >nul
echo 关闭Telnet 和木马Tiny Telnet Server监听端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/520" -f *+0:520:TCP -n BLOCK -x >nul
echo 关闭Rip 端口…………OK！
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/1999" -f *+0:1999:TCP -n BLOCK -x >nul
echo 关闭木马程序BackDoor的默认服务端口…………OK！
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/2001" -f *+0:2001:TCP -n BLOCK -x >nul
echo 关闭马程序黑洞2001的默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/2023" -f *+0:2023:TCP -n BLOCK -x >nul
echo 关闭木马程序Ripper的默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/2583" -f *+0:2583:TCP -n BLOCK -x >nul
echo 关闭木马程序Wincrash v2的默认服务端口…………OK！
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/3389" -f *+0:3389:TCP -n BLOCK -x >nul
echo 关闭Windows 的远程管理终端（远程桌面）监听端口…………OK！
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/4444" -f *+0:4444:TCP -n BLOCK -x >nul
echo 关闭msblast冲击波蠕虫监听端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/4899" -f *+0:4899:TCP -n BLOCK -x >nul
echo 关闭远程控制软件（remote administrator)服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/5800" -f *+0:5800:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/5900" -f *+0:5900:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/8888" -f *+0:8888:TCP -n BLOCK -x >nul
echo 关闭远程控制软件VNC的两个默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/6129" -f *+0:6129:TCP -n BLOCK -x >nul
echo 关闭Dameware服务端默认监听端口（可变！）…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/6267" -f *+0:6267:TCP -n BLOCK -x >nul
echo 关闭木马广外女生的默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/660" -f *+0:660:TCP -n BLOCK -x >nul
echo 关闭木马DeepThroat v1.0 - 3.1默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/6671" -f *+0:6671:TCP -n BLOCK -x >nul
echo 关闭木马Indoctrination默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/6939" -f *+0:6939:TCP -n BLOCK -x >nul
echo 关闭木马PRIORITY默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/7306" -f *+0:7306:TCP -n BLOCK -x >nul
echo 关闭木马网络精灵默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/7511" -f *+0:7511:TCP -n BLOCK -x >nul
echo 关闭木马聪明基因的默认连接端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/7626" -f *+0:7626:TCP -n BLOCK -x >nul
echo 关闭木马冰河默认端口(注意可变！)…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/8011" -f *+0:8011:TCP -n BLOCK -x >nul
echo 关闭木马WAY2.4默认服务端口…………OK！
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/9989" -f *+0:9989:TCP -n BLOCK -x >nul
echo 关闭木马InIkiller默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/19191" -f *+0:19191:TCP -n BLOCK -x >nul
echo 关闭木马兰色火焰默认开放的telnet端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/1029" -f *+0:1029:TCP -n BLOCK -x >nul
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/20168" -f *+0:20168:TCP -n BLOCK -x >nul
echo 关闭lovegate 蠕虫所开放的两个后门端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/23444" -f *+0:23444:TCP -n BLOCK -x >nul
echo 关闭木马网络公牛默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/27374" -f *+0:27374:TCP -n BLOCK -x >nul
echo 关闭木马SUB7默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/30100" -f *+0:30100:TCP -n BLOCK -x >nul
echo 关闭木马NetSphere默认的服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/31337" -f *+0:31337:TCP -n BLOCK -x >nul
echo 关闭木马BO2000默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/45576" -f *+0:45576:TCP -n BLOCK -x >nul
echo 关闭代理软件的控制端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/50766" -f *+0:50766:TCP -n BLOCK -x >nul
echo 关闭木马Schwindler默认服务端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/61466" -f *+0:61466:TCP -n BLOCK -x >nul
echo 关闭木马Telecommando默认服务端口…………OK!

ipseccmd  -w REG -p "HFUT_SECU" -r "Block TCP/31338" -f *+0:31338:TCP -n BLOCK -x >nul
echo 关闭木马Back Orifice默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/8102" -f *+0:8102:TCP -n BLOCK -x >nul
echo 关闭木马网络神偷默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2000" -f *+0:2000:TCP -n BLOCK -x >nul
echo 关闭木马黑洞2000默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/31339" -f *+0:31339:TCP -n BLOCK -x >nul
echo 关闭木马NetSpy DK默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2001" -f *+0:2001:TCP -n BLOCK -x >nul
echo 关闭木马黑洞2001默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/31666" -f *+0:31666:TCP -n BLOCK -x >nul
echo 关闭木马BOWhack默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/34324" -f *+0:34324:TCP -n BLOCK -x >nul
echo 关闭木马BigGluck默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7306" -f *+0:7306:TCP -n BLOCK -x >nul
echo 关闭木马网络精灵3.0，netspy3.0默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/40412" -f *+0:40412:TCP -n BLOCK -x >nul
echo 关闭木马The Spy默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/40421" -f *+0:40421:TCP -n BLOCK -x >nul
echo 关闭木马Masters Paradise默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/8011" -f *+0:8011:TCP -n BLOCK -x >nul
echo 关闭木马wry，赖小子，火凤凰默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/40422" -f *+0:40422:TCP -n BLOCK -x >nul
echo 关闭木马Masters Paradise 1.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/23444" -f *+0:23444:TCP -n BLOCK -x >nul
echo 关闭木马网络公牛，netbull默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/40423" -f *+0:40423:TCP -n BLOCK -x >nul
echo 关闭木马Masters Paradise 2.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/23445" -f *+0:23445:TCP -n BLOCK -x >nul
echo 关闭木马网络公牛，netbull默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/40426" -f *+0:40426:TCP -n BLOCK -x >nul
echo 关闭木马Masters Paradise 3.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/50505" -f *+0:50505:TCP -n BLOCK -x >nul
echo 关闭木马Sockets de Troie默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/27374" -f *+0:27374:TCP -n BLOCK -x >nul
echo 关闭木马Sub Seven 2.0+，77，东方魔眼默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/50766" -f *+0:50766:TCP -n BLOCK -x >nul
echo 关闭木马Fore默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/53001" -f *+0:53001:TCP -n BLOCK -x >nul
echo 关闭木马Remote Windows Shutdown默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/61466" -f *+0:61466:TCP -n BLOCK -x >nul
echo 关闭木马Telecommando默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/121" -f *+0:121:TCP -n BLOCK -x >nul
echo 关闭木马BO jammerkillahV默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/666" -f *+0:666:TCP -n BLOCK -x >nul
echo 关闭木马Satanz Backdoor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/65000" -f *+0:65000:TCP -n BLOCK -x >nul
echo 关闭木马Devil默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1001" -f *+0:1001:TCP -n BLOCK -x >nul
echo 关闭木马Silencer默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6400" -f *+0:6400:TCP -n BLOCK -x >nul
echo 关闭木马The tHing默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1600" -f *+0:1600:TCP -n BLOCK -x >nul
echo 关闭木马Shivka-Burka默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/12346" -f *+0:12346:TCP -n BLOCK -x >nul
echo 关闭木马NetBus 1.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1807" -f *+0:1807:TCP -n BLOCK -x >nul
echo 关闭木马SpySender默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/20034" -f *+0:20034:TCP -n BLOCK -x >nul
echo 关闭木马NetBus Pro默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1981" -f *+0:1981:TCP -n BLOCK -x >nul
echo 关闭木马Shockrave默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1243" -f *+0:1243:TCP -n BLOCK -x >nul
echo 关闭木马SubSeven默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1001" -f *+0:1001:TCP -n BLOCK -x >nul
echo 关闭木马WebEx默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/30100" -f *+0:30100:TCP -n BLOCK -x >nul
echo 关闭木马NetSphere默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1011" -f *+0:1011:TCP -n BLOCK -x >nul
echo 关闭木马Doly Trojan默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1001" -f *+0:1001:TCP -n BLOCK -x >nul
echo 关闭木马Silencer默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1170" -f *+0:1170:TCP -n BLOCK -x >nul
echo 关闭木马Psyber Stream Server默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/20000" -f *+0:20000:TCP -n BLOCK -x >nul
echo 关闭木马Millenium默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1234" -f *+0:1234:TCP -n BLOCK -x >nul
echo 关闭木马Ultors Trojan默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/65000" -f *+0:65000:TCP -n BLOCK -x >nul
echo 关闭木马Devil 1.03默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1245" -f *+0:1245:TCP -n BLOCK -x >nul
echo 关闭木马VooDoo Doll默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7306" -f *+0:7306:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1492" -f *+0:1492:TCP -n BLOCK -x >nul
echo 关闭木马FTP99CMP默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1170" -f *+0:1170:TCP -n BLOCK -x >nul
echo 关闭木马Streaming Audio Trojan默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1999" -f *+0:1999:TCP -n BLOCK -x >nul
echo 关闭木马BackDoor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/30303" -f *+0:30303:TCP -n BLOCK -x >nul
echo 关闭木马Socket23默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2001" -f *+0:2001:TCP -n BLOCK -x >nul
echo 关闭木马Trojan Cow默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6969" -f *+0:6969:TCP -n BLOCK -x >nul
echo 关闭木马Gatecrasher默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2023" -f *+0:2023:TCP -n BLOCK -x >nul
echo 关闭木马Ripper默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/61466" -f *+0:61466:TCP -n BLOCK -x >nul
echo 关闭木马Telecommando默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2115" -f *+0:2115:TCP -n BLOCK -x >nul
echo 关闭木马Bugs默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/12076" -f *+0:12076:TCP -n BLOCK -x >nul
echo 关闭木马Gjamer默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2140" -f *+0:2140:TCP -n BLOCK -x >nul
echo 关闭木马Deep Throat默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/4950" -f *+0:4950:TCP -n BLOCK -x >nul
echo 关闭木马IcqTrojen默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2140" -f *+0:2140:TCP -n BLOCK -x >nul
echo 关闭木马The Invasor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/16969" -f *+0:16969:TCP -n BLOCK -x >nul
echo 关闭木马Priotrity默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2801" -f *+0:2801:TCP -n BLOCK -x >nul
echo 关闭木马Phineas Phucker默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1245" -f *+0:1245:TCP -n BLOCK -x >nul
echo 关闭木马Vodoo默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/30129" -f *+0:30129:TCP -n BLOCK -x >nul
echo 关闭木马Masters Paradise默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5742" -f *+0:5742:TCP -n BLOCK -x >nul
echo 关闭木马Wincrash默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/3700" -f *+0:3700:TCP -n BLOCK -x >nul
echo 关闭木马Portal of Doom默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2583" -f *+0:2583:TCP -n BLOCK -x >nul
echo 关闭木马Wincrash2默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/4092" -f *+0:4092:TCP -n BLOCK -x >nul
echo 关闭木马WinCrash默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1033" -f *+0:1033:TCP -n BLOCK -x >nul
echo 关闭木马Netspy默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/4590" -f *+0:4590:TCP -n BLOCK -x >nul
echo 关闭木马ICQTrojan默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1981" -f *+0:1981:TCP -n BLOCK -x >nul
echo 关闭木马ShockRave默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5000" -f *+0:5000:TCP -n BLOCK -x >nul
echo 关闭木马Sockets de Troie默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/555" -f *+0:555:TCP -n BLOCK -x >nul
echo 关闭木马Stealth Spy默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5001" -f *+0:5001:TCP -n BLOCK -x >nul
echo 关闭木马Sockets de Troie 1.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2023" -f *+0:2023:TCP -n BLOCK -x >nul
echo 关闭木马Pass Ripper默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5321" -f *+0:5321:TCP -n BLOCK -x >nul
echo 关闭木马Firehotcker默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/666" -f *+0:666:TCP -n BLOCK -x >nul
echo 关闭木马Attack FTP默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5400" -f *+0:5400:TCP -n BLOCK -x >nul
echo 关闭木马Blade Runner默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/21554" -f *+0:21554:TCP -n BLOCK -x >nul
echo 关闭木马GirlFriend默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5401" -f *+0:5401:TCP -n BLOCK -x >nul
echo 关闭木马Blade Runner 1.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/50766" -f *+0:50766:TCP -n BLOCK -x >nul
echo 关闭木马Fore Schwindler默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5402" -f *+0:5402:TCP -n BLOCK -x >nul
echo 关闭木马Blade Runner 2.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/34324" -f *+0:34324:TCP -n BLOCK -x >nul
echo 关闭木马Tiny Telnet Server默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5569" -f *+0:5569:TCP -n BLOCK -x >nul
echo 关闭木马Robo-Hack默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/30999" -f *+0:30999:TCP -n BLOCK -x >nul
echo 关闭木马Kuang默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6670" -f *+0:6670:TCP -n BLOCK -x >nul
echo 关闭木马DeepThroat默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/11000" -f *+0:11000:TCP -n BLOCK -x >nul
echo 关闭木马Senna Spy Trojans默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6771" -f *+0:6771:TCP -n BLOCK -x >nul
echo 关闭木马DeepThroat默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/23456" -f *+0:23456:TCP -n BLOCK -x >nul
echo 关闭木马WhackJob默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6969" -f *+0:6969:TCP -n BLOCK -x >nul
echo 关闭木马GateCrasher默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/555" -f *+0:555:TCP -n BLOCK -x >nul
echo 关闭木马Phase0默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6969" -f *+0:6969:TCP -n BLOCK -x >nul
echo 关闭木马Priority默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5400" -f *+0:5400:TCP -n BLOCK -x >nul
echo 关闭木马Blade Runner默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7000" -f *+0:7000:TCP -n BLOCK -x >nul
echo 关闭木马Remote Grab默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/4950" -f *+0:4950:TCP -n BLOCK -x >nul
echo 关闭木马IcqTrojan默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7300" -f *+0:7300:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/9989" -f *+0:9989:TCP -n BLOCK -x >nul
echo 关闭木马InIkiller默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7301" -f *+0:7301:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor 1.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/9872" -f *+0:9872:TCP -n BLOCK -x >nul
echo 关闭木马Portal Of Doom默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7306" -f *+0:7306:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor 2.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/11223" -f *+0:11223:TCP -n BLOCK -x >nul
echo 关闭木马Progenic Trojan默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7307" -f *+0:7307:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor 3.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1999" -f *+0:1999:TCP -n BLOCK -x >nul
echo 关闭木马BackDoor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5800" -f *+0:5800:TCP -n BLOCK -x >nul
echo 关闭远程控制软件VNC默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5900" -f *+0:5900:TCP -n BLOCK -x >nul
echo 关闭远程控制软件VNC默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/22222" -f *+0:22222:TCP -n BLOCK -x >nul
echo 关闭木马Prosiak 0.47默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7626" -f *+0:7626:TCP -n BLOCK -x >nul
echo 关闭木马冰河默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/4444" -f *+0:4444:TCP -n BLOCK -x >nul
echo 关闭木马msblast默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7308" -f *+0:7308:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor 4.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6129" -f *+0:6129:TCP -n BLOCK -x >nul
echo 关闭远程控制软件（dameware nt utilities)默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2023" -f *+0:2023:TCP -n BLOCK -x >nul
echo 关闭木马Ripper默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1245" -f *+0:1245:TCP -n BLOCK -x >nul
echo 关闭木马VooDoo Doll默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/121" -f *+0:121:TCP -n BLOCK -x >nul
echo 关闭木马BO jammerkillahV默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/456" -f *+0:456:TCP -n BLOCK -x >nul
echo 关闭木马Hackers Paradise默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/555" -f *+0:555:TCP -n BLOCK -x >nul
echo 关闭木马Stealth Spy默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/666" -f *+0:666:TCP -n BLOCK -x >nul
echo 关闭木马Satanz Backdoor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1001" -f *+0:1001:TCP -n BLOCK -x >nul
echo 关闭木马Silencer默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/1033" -f *+0:1033:TCP -n BLOCK -x >nul
echo 关闭木马Netspy默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7000" -f *+0:7000:TCP -n BLOCK -x >nul
echo 关闭木马Remote Grab默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7300 " -f *+0:7300:TCP -n BLOCK -x >nul
echo 关闭木马NetMonitor默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/23456 " -f *+0:23456:TCP -n BLOCK -x >nul
echo 关闭木马Ugly FTP默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/23456 " -f *+0:23456:TCP -n BLOCK -x >nul
echo 关闭木马Ugly FTP默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/30100 " -f *+0:30100:TCP -n BLOCK -x >nul
echo 关闭木马NetSphere默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/9872" -f *+0:9872:TCP -n BLOCK -x >nul
echo 关闭木马Portal of Doom默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/9899" -f *+0:9899:TCP -n BLOCK -x >nul
echo 关闭木马iNi-Killer默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/50505" -f *+0:50505:TCP -n BLOCK -x >nul
echo 关闭木马Sockets de Troie默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/6939" -f *+0:6939:TCP -n BLOCK -x >nul
echo 关闭木马Indoctrination默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/11000" -f *+0:11000:TCP -n BLOCK -x >nul
echo 关闭木马Senna Spy默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/12223" -f *+0:12223:TCP -n BLOCK -x >nul
echo 关闭木马Hack?99 KeyLogger默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/12362" -f *+0:12362:TCP -n BLOCK -x >nul
echo 关闭木马Whack-a-mole 1.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/20000" -f *+0:20000:TCP -n BLOCK -x >nul
echo 关闭木马Millenium默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2583" -f *+0:2583:TCP -n BLOCK -x >nul
echo 关闭木马Wincrash v2默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/53001" -f *+0:53001:TCP -n BLOCK -x >nul
echo 关闭木马Remote Windows Shutdown默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/7789" -f *+0:7789:TCP -n BLOCK -x >nul
echo 关闭木马ICKiller默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/40426" -f *+0:40426:TCP -n BLOCK -x >nul
echo 关闭木马Masters Paradise 3.x默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/5569" -f *+0:5569:TCP -n BLOCK -x >nul
echo 关闭木马RoboHack默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/8000" -f *+0:8000:TCP -n BLOCK -x >nul
echo 关闭木马huigezi默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/9872" -f *+0:9872:TCP -n BLOCK -x >nul
echo 关闭木马Portal of Doom默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2005" -f *+0:2005:TCP -n BLOCK -x >nul
echo 关闭木马黑洞2005默认服务端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/2000" -f *+0:2000:TCP -n BLOCK -x >nul
echo 关闭彩虹桥1.2默认端口…………OK!
ipseccmd -w REG -p "HFUT_SECU" -r "Block TCP/9999" -f *+0:9999:TCP -n BLOCK -x >nul
echo 关闭huigezi映射默认端口…………OK!
ipseccmd  -w REG -p "HFUT_SECU" -x >nul
gpupdate >nul
echo.
echo   安全协议全部设置完成！您的系统可以免受流行蠕虫病毒及典型木马后门的侵扰！
echo   “中国剑客技术联盟”提醒您及时升级操作系统和杀毒软件！
echo   您已经设置完成，请重新启动你的计算机！
echo    
echo                                  
echo. 
echo  请您按任意键退出！中国剑盟专用“有害端口自动关闭器”会员版：神雕大侠
pause>nul