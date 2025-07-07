`ifndef MY_IF__SV
`define MY_IF__SV

`include "uvm_macros.svh" 
import uvm_pkg::*;

interface my_if(input clk, input rst_n);

   logic [7:0] data_a;
   logic [7:0] data_b;
   logic [8:0] data_sum;
   logic valid;
endinterface

`endif
