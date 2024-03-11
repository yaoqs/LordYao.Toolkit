@echo off
echo.
echo 从当前盘符切换到xx目录下
pushd c:\inetpub
echo c:\inetpub目录中包含以下文件夹：
dir /ad /b
echo.
echo 返回到批处理运行时所在盘符及路径
popd