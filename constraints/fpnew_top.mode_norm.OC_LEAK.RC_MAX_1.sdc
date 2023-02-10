#SDC constraint file for add_eg block
#Unit is ns

set clock_period 1

create_clock -name clk -period $clock_period -add [get_ports clk_i]

set_clock_uncertainty -setup 0.033 [all_clocks]

#set input_ports [remove_from_collection [all_inputs] [get_ports *clk*] ]
set input_ports [ all_inputs ]
set output_ports [all_outputs]

set_input_delay [ expr (30.0/100.0) * $clock_period] -clock clk $input_ports -add
set_output_delay [ expr (30.0/100.0) * $clock_period] -clock clk $output_ports -add

#Setting input and output driving cells

set loadcell tcbn22ullbwp30p140ssg0p72vm40c_ccs/BUFFD12BWP30P140/I
set drivecell BUFFD12BWP30P140
set drivepin Z

#Define load constraints - Technology dependant
set_load [load_of $loadcell] [all_outputs]
set_driving_cell -lib_cell $drivecell -pin $drivepin $input_ports

#Define DRC constraints
set_max_transition 0.050 [current_design]
set_max_fanout 1 $input_ports
