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
ECHO        ┃[1] 查看已下载                ┃ 
ECHO        ┃                              ┃
ECHO        ┃[2] 清理(推荐)                ┃
ECHO        ┃                              ┃ 
ECHO        ┃[3] 进入该目录                ┃
ECHO        ┃                              ┃ 
ECHO        ┃[4] exit                      ┃
ECHO        ┗━━━━━━━━━━━━━━━┛
ECHO.
ECHO.
ECHO.
ECHO             ◆◇老妖◇◆
ECHO.           
ECHO.
ECHO.
:menu1
cd \
c:
cd %programfiles%\360\360safe\softmgr\download

set choice=
set /p choice=       请输入对应的数字后按[Enter]执行:
if not "%choice%"=="" set choice=%choice%
ECHO.
If /I "%Choice%"=="1" Goto view
If /I "%Choice%"=="2" Goto ql
If /I "%Choice%"=="3" Goto jinru
If /I "%Choice%"=="" exit
goto menu1

:view
CLS
title 查看目录

CLS
@dir 
ECHO          按任意键返回菜单...
pause>nul
goto menu1
:ql
title 清理
CLS

CLS
:menu2
color 1a
title 清理
CLS
@del /f /s /q *.*

::ECHO          按任意键返回菜单...
pause>nul
goto menu1

:jinru
title 进入该目录
CLS
explorer.exe %programfiles%\360\360safe\softmgr\download
CLS

::ECHO          按任意键返回菜单...
::pause>nul
goto menu1


