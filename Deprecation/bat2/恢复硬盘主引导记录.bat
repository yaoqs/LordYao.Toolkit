@echo off
if not exist mbr.bin(
echo.
echo sorry,i cannt find it!
goto end
)
echo the master boot record is being restored,waiting....
echo n mbr.bin >restorembr.code
rem 表示要操作的文件在当前目录下
echo 1200 >>restorembr.code
rem 将文件装到偏移地址为“1200”处
echo a 100 >>restorembr.code
echo mov ax,0301 >>restorembr.code
rem 将中断服务号及写入的扇区数存ax，ah放中断号，al放待写扇区数
echo mov bx,200 >>restorembr.code
echo mov cx,0001 >>restorembr.code
echo mov dx,0080 >>restorembr.code
echo int 13 >>restorembr.code
echo int 20 >>restorembr.code
echo.>>restorembr.code
echo g    >>restorembr.code
echo q >>restorembr.code
debug<restorembr.code
echo the master boot record hasbeen restored
echo.
del /q >restorembr.code
:end