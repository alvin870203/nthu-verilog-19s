@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim test_bincnt_behav -key {Behavioral:sim_1:Functional:test_bincnt} -tclbatch test_bincnt.tcl -view C:/Users/Alvin/Documents/LogicDesignLabMonday/pre_lab3_1_105033110_ver1/test_bincnt_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
