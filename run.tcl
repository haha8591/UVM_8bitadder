vsim -sv_lib "$env(UVM_HOME)/src/dpi/uvm_dpi" -voptargs="+acc" work.top_tb +UVM_NO_RELNOTES +UVM_TESTNAME=my_case_corner 
add wave -position insertpoint sim:/top_tb/my_dut/* 
run -all 
