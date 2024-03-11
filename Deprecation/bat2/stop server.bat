@echo off
net share ipc$ /delete 
net share admin$ /delete 
net share c$ /delete 
net share d$ /delete
net share e$ /delete
net share f$ /delete
::======================
net stop server /y 