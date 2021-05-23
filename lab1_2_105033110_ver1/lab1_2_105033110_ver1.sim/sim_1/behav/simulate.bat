@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim test_lab1_2_105033110_ver1_behav -key {Behavioral:sim_1:Functional:test_lab1_2_105033110_ver1} -tclbatch test_lab1_2_105033110_ver1.tcl -view C:/Users/Alvin/Documents/LogicDesignLabMonday/lab1_2_105033110_ver1/lab1_2_105033110_ver1_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
