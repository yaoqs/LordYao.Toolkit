@echo off
echo 开始更改文件名
set extension=.rar
set /a sum=0
for %%m in (*)do(
if not "%%m"=="批量更改文件名.bat" (
ren %%m %%m%extension%
set /a sum =sum+1
)
)
echo 文件改名完毕，共有%sum%文件被改名
set sum =
set extension=