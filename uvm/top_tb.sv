`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "my_if.sv"
`include "my_transaction.sv"
`include "my_sequencer.sv"
`include "my_driver.sv"
`include "my_monitor.sv"
`include "my_agent.sv"
`include "my_model.sv"
`include "my_scoreboard.sv"
`include "my_env.sv"
`include "base_test.sv"
`include "my_case0.sv"
`include "my_case_corner.sv"
`include "my_case_pattern.sv"

module top_tb;

reg clk;
reg rst_n;
reg[7:0] in_a;
reg[7:0] in_b;
reg in_valid;
wire[7:0] out_sum;
wire out_valid;

my_if input_if(clk, rst_n);
my_if output_if(clk, rst_n);

dut my_dut(
            .clk(clk),
            .rst_n(rst_n),
            .in_a(input_if.data_a),
            .in_b(input_if.data_b),
            .in_valid(input_if.valid),
            .out_sum(output_if.data_sum),
            .out_valid(output_if.valid)
);

initial begin
   clk = 0;
   forever begin
      #100 clk = ~clk;
   end
end

initial begin
   rst_n = 1'b0;
   #1000;
   rst_n = 1'b1;
end

initial begin
   run_test();
end

initial begin
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.i_agt.drv", "vif", input_if);
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.i_agt.mon", "vif", input_if);
   uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.o_agt.mon", "vif", output_if);
end

endmodule
