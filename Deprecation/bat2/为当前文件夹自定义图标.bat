@echo off
if not exsit discover.ico(
echo discover.ico不存在，无法建立
goto end
)
echo [.ShellClassInfo]>desktop.ini
echo iconfile=discover.ico>>desktop.ini
echo iconindex=0>>desktop.ini
attrib desktop.ini +h +s +r
attrib discover.ico +h +s +r
echo.
echo 成功将当前文件夹的图标改为discover.ico
:end