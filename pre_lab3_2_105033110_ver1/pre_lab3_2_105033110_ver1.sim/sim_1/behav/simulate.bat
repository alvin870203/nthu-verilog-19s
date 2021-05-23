@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim test_shifter_behav -key {Behavioral:sim_1:Functional:test_shifter} -tclbatch test_shifter.tcl -view C:/Users/Alvin/Documents/LogicDesignLabMonday/pre_lab3_2_105033110_ver1/test_shifter_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
