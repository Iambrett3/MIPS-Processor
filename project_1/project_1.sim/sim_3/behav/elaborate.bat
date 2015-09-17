@echo off
set xv_path=C:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto 27eda63ab78747b7a8381ae2bb6482cf -m64 --debug typical --relax --include "../../../project_1.srcs/sources_1/imports/sources_1/new" -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot vgatimer_10x4_test_behav xil_defaultlib.vgatimer_10x4_test xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
