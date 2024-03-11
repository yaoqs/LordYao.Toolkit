:q
@echo off
echo assoc
assoc/?
echo ftype
ftype/?|more
set pathext
echo pathext=.com;%pathext%
pause
echo on
@goto q