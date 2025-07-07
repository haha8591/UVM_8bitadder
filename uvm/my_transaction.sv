`ifndef MY_TRANSACTION__SV
`define MY_TRANSACTION__SV

`include "uvm_macros.svh" 
import uvm_pkg::*;         

class my_transaction extends uvm_sequence_item;

   rand bit[7:0] data_a;
   rand bit[7:0] data_b;
   bit [8:0] data_sum;

   `uvm_object_utils_begin(my_transaction)
      `uvm_field_int(data_a, UVM_ALL_ON)
      `uvm_field_int(data_b, UVM_ALL_ON)
      `uvm_field_int(data_sum, UVM_ALL_ON)
   `uvm_object_utils_end

   function new(string name = "my_transaction");
      super.new();
   endfunction

endclass
`endif
