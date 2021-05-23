# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Alvin/Documents/LogicDesignLabMonday/smux/smux.cache/wt [current_project]
set_property parent.project_path C:/Users/Alvin/Documents/LogicDesignLabMonday/smux/smux.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib C:/Users/Alvin/Documents/LogicDesignLabMonday/smux/smux.srcs/sources_1/new/smux.v
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Alvin/Documents/LogicDesignLabMonday/smux/smux.srcs/constrs_1/new/smux.xdc
set_property used_in_implementation false [get_files C:/Users/Alvin/Documents/LogicDesignLabMonday/smux/smux.srcs/constrs_1/new/smux.xdc]


synth_design -top smux -part xc7a35tcpg236-1


write_checkpoint -force -noxdef smux.dcp

catch { report_utilization -file smux_utilization_synth.rpt -pb smux_utilization_synth.pb }