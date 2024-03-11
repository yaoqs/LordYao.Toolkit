@echo off
echo.
setlocal enabledelayedexpansion
cd.>file_new.txt
echo 正在替换文件中的字符串
echo.
for /f %%a in (file.txt) do(
set str=%%a
set str=!str:其他=其他!
echo !str!>>file_new.txt
)
ren file.txt file_old.txt
ren file_new.txt file.txt
echo 成功替换文件中指定的字符串，file_old.txt为未修改的源文件
setstr=