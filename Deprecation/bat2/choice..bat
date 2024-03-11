@ECHO off 
mode con cols=48 lines=23
:menu1
color 9f
title [老妖*LordYao]
CLS
ECHO.
ECHO.
ECHO           请根据自己需要清理指定
ECHO.       
ECHO.
ECHO.
ECHO.       ┏━━━━━━━━━━━━━━━┓
ECHO        ┃[1] 清理看看缓存(强烈推荐)    ┃ 
ECHO        ┃                              ┃
ECHO        ┃[2] 清理(推荐)                ┃
ECHO        ┃                              ┃ 
ECHO        ┃[3] 清理下载记录(一般推荐)    ┃
ECHO        ┗━━━━━━━━━━━━━━━┛
ECHO.
ECHO.
ECHO.
ECHO             ◆◇老妖◇◆
ECHO.           
ECHO.
ECHO.
:menu1
set choice=
set /p choice=       请输入对应的数字后按[Enter]执行:
if not "%choice%"=="" set choice=%choice%
ECHO.
If /I "%Choice%"=="1" Goto qlkkhc
If /I "%Choice%"=="2" Goto qlxllj
If /I "%Choice%"=="3" Goto scxzjl
If /I "%Choice%"=="" exit
goto menu1

:qlkkhc
CLS
title 清理看看缓存

CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO           清理看看缓存完成!
ECHO.
ECHO          按任意键返回菜单...
pause>nul
goto menu1
:qlxllj
title 清理迅雷垃圾
CLS

CLS
:menu2
color 1a
title 清理迅雷垃圾
CLS
ECHO.
ECHO.
ECHO.
ECHO           清理迅雷垃圾完成!
ECHO.
ECHO          按任意键返回菜单...
pause>nul
goto menu1

:scxzjl
title 删除下载记录
CLS

CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO           迅雷下载记录清理完毕!
ECHO.
ECHO          按任意键返回菜单...
pause>nul
goto menu1


