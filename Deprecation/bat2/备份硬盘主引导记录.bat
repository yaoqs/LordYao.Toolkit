@echo off
echo the master boot record is being backuped,waiting....
echo a 100 >mbr.code
rem 从偏移地址“100”处汇编一段小程序
echo mov ax,0201 >>mbr.code
rem 将要读取的扇区数存于寄存器中
echo mov bx,200 >>mbr.code
rem 将缓存区地址存于寄存器中
echo mov cx,0001 >>mbr.code
rem 柱面号及扇区号存寄存器中，ch与cl的高两位构成柱面号，cl低六位表示扇区号
echo mov dx,0080 >>mbr.code
rem 将磁头及磁盘类型信息存入dx，dh放磁头号，dl放硬盘类型，0、1软盘。80、81硬盘
echo int 13 >>mbr.code
rem 调用磁盘bios服务中断
echo int 20 >>mbr.code
rem 表示程序结束
echo.>>mbr.code
rem 空一行用于debug程序退出汇编程序状态回到debug提示符下
echo g    >>mbr.code
rem 表示执行了有debug了命令a所输入的汇编程序
echo m 1000 11FF 100 >>mbr.code
rem 将硬盘主引导记录移到偏移地址“100”处
echo rcx >>mbr.code
rem 修改cx寄存器
echo 200 >>mbr.code
rem 将cx值设为200
echo.>>mbr.code
rem 同上
echo n mbr.bin >>mbr.code
rem 将读取的记录存放到当前目录
echo w >>mbr.code
rem 将数据写入mbr.bin
echo q >>mbr.code
rem 返回dos下
debug<mbr.code
echo the master boot record hasbeen backuped,& was stored in mbr.bin in current dir
echo.
del /q mbr.code