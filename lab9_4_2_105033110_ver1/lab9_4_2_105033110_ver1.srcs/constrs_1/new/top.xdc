set_property PACKAGE_PIN L1 [get_ports {state}]
set_property IOSTANDARD LVCMOS33 [get_ports {state}]


set_property PACKAGE_PIN U14 [get_ports {key_num[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_num[6]}]
set_property PACKAGE_PIN U15 [get_ports {key_num[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_num[5]}]
set_property PACKAGE_PIN W18 [get_ports {key_num[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_num[4]}]
set_property PACKAGE_PIN V19 [get_ports {key_num[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_num[3]}]
set_property PACKAGE_PIN U19 [get_ports {key_num[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_num[2]}]
set_property PACKAGE_PIN E19 [get_ports {key_num[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_num[1]}]
set_property PACKAGE_PIN U16 [get_ports {key_num[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_num[0]}]


# PS2
set_property PACKAGE_PIN B17 [get_ports {PS2_DATA}]
set_property IOSTANDARD LVCMOS33 [get_ports {PS2_DATA}]
set_property PACKAGE_PIN C17 [get_ports {PS2_CLK}]
set_property IOSTANDARD LVCMOS33 [get_ports {PS2_CLK}]

# Clock
set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

# active low reset
set_property PACKAGE_PIN V17 [get_ports {rst_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]