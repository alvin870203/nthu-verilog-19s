# Motor 
#  output
set_property PACKAGE_PIN K17 [get_ports {motor[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {motor[0]}]
set_property PACKAGE_PIN M18 [get_ports {motor[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {motor[1]}]
set_property PACKAGE_PIN U16 [get_ports {led_direction[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_direction[0]}]
set_property PACKAGE_PIN L1 [get_ports {led_direction[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_direction[1]}]
#  inout
#   PS2
set_property PACKAGE_PIN B17 [get_ports {PS2_DATA}]
set_property IOSTANDARD LVCMOS33 [get_ports {PS2_DATA}]
set_property PACKAGE_PIN C17 [get_ports {PS2_CLK}]
set_property IOSTANDARD LVCMOS33 [get_ports {PS2_CLK}]


# Alarm
#  output
set_property PACKAGE_PIN V19 [get_ports {led_alarm}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_alarm}]
#   Pmod I2S 
set_property PACKAGE_PIN A14 [get_ports {audio_mclk}]
set_property IOSTANDARD LVCMOS33 [get_ports {audio_mclk}]
set_property PACKAGE_PIN A16 [get_ports {audio_lrck}]
set_property IOSTANDARD LVCMOS33 [get_ports {audio_lrck}]
set_property PACKAGE_PIN B15 [get_ports {audio_sck}]
set_property IOSTANDARD LVCMOS33 [get_ports {audio_sck}]
set_property PACKAGE_PIN B16 [get_ports {audio_sdin}]
set_property IOSTANDARD LVCMOS33 [get_ports {audio_sdin}]
#   7-seg display
set_property PACKAGE_PIN W7 [get_ports {segs[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[7]}]
set_property PACKAGE_PIN W6 [get_ports {segs[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[6]}]
set_property PACKAGE_PIN U8 [get_ports {segs[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[5]}]
set_property PACKAGE_PIN V8 [get_ports {segs[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[4]}]
set_property PACKAGE_PIN U5 [get_ports {segs[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[3]}]
set_property PACKAGE_PIN V5 [get_ports {segs[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[2]}]
set_property PACKAGE_PIN U7 [get_ports {segs[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[1]}]
set_property PACKAGE_PIN V7 [get_ports {segs[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[0]}]
set_property PACKAGE_PIN W4 [get_ports {ssd_ctl[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[0]}]
set_property PACKAGE_PIN V4 [get_ports {ssd_ctl[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[1]}]
set_property PACKAGE_PIN U4 [get_ports {ssd_ctl[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[2]}]
set_property PACKAGE_PIN U2 [get_ports {ssd_ctl[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[3]}]
#  input
#   Volumn push button
set_property PACKAGE_PIN T18 [get_ports {volumn_up_pb}]
set_property IOSTANDARD LVCMOS33 [get_ports {volumn_up_pb}]
set_property PACKAGE_PIN U17 [get_ports {volumn_down_pb}]
set_property IOSTANDARD LVCMOS33 [get_ports {volumn_down_pb}]
set_property PACKAGE_PIN R2 [get_ports {dip_alarm}]
set_property IOSTANDARD LVCMOS33 [get_ports {dip_alarm}]

# Light
#  output
#   0: red1, 1: red2, 2:green1, 3: green2
set_property PACKAGE_PIN L2 [get_ports {light_warn[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {light_warn[0]}]
set_property PACKAGE_PIN J1 [get_ports {light_warn[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {light_warn[1]}]
set_property PACKAGE_PIN P17 [get_ports {light_warn[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {light_warn[2]}]
set_property PACKAGE_PIN R18 [get_ports {light_warn[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {light_warn[3]}]
#  input
set_property PACKAGE_PIN U18 [get_ports {btn_led}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn_led}]

# global
#  input
#   Clock
set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
#   active low reset
set_property PACKAGE_PIN V17 [get_ports {rst_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]