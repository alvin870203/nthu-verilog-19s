# Clock
set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

# active low reset
set_property PACKAGE_PIN V17 [get_ports {rst_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]

# push button input
set_property PACKAGE_PIN U18 [get_ports {in}]
set_property IOSTANDARD LVCMOS33 [get_ports {in}]

#8 common segment controls
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

set_property PACKAGE_PIN W4 [get_ports {ssd_ctl[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[3]}]
set_property PACKAGE_PIN V4 [get_ports {ssd_ctl[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[2]}]
set_property PACKAGE_PIN U4 [get_ports {ssd_ctl[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[1]}]
set_property PACKAGE_PIN U2 [get_ports {ssd_ctl[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[0]}]