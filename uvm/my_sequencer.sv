`ifndef MY_SEQUENCER__SV
`define MY_SEQUENCER__SV

`include "uvm_macros.svh" 
import uvm_pkg::*;

class my_sequencer extends uvm_sequencer #(my_transaction);
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(my_sequencer)
endclass

`endif
