@echo off

set SOURCE_DIR=D:\phd\course\CV\p1\corpus\vis10catfiles\
set TARGET_DIR=SOURCE_DIR


for /r %SOURCE_DIR% %%i in (*) do if not exist %TARGET_DIR%%%~pi mkdir %TARGET_DIR%%%~pi

for /r %SOURCE_DIR% %%i in (*) do convert %%i %TARGET_DIR%%%~pni.jpeg

pause 

 