`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV

`include "uvm_macros.svh" 
import uvm_pkg::*; 

class my_driver extends uvm_driver#(my_transaction);

   virtual my_if vif;

   `uvm_component_utils(my_driver)
   function new(string name = "my_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
         `uvm_fatal("my_driver", "virtual interface must be set for vif!!!")
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task drive_one_pkt(my_transaction tr);
endclass

task my_driver::main_phase(uvm_phase phase);
   vif.data_a <= 8'b0;
   vif.data_b <= 8'b0;
   vif.valid <= 1'b0;
   while(!vif.rst_n)
      @(posedge vif.clk);
   while(1) begin
      seq_item_port.get_next_item(req);
      drive_one_pkt(req);
      seq_item_port.item_done();
   end
endtask

task my_driver::drive_one_pkt(my_transaction tr);
   
   `uvm_info("my_driver", "begin to drive one pkt", UVM_LOW);
   repeat(3) @(posedge vif.clk);

   @(posedge vif.clk);
   vif.valid <= 1'b1;
   vif.data_a <= tr.data_a;
   vif.data_b <= tr.data_b;

   @(posedge vif.clk);
   vif.valid <= 1'b0;

   `uvm_info("my_driver", "end drive one pkt", UVM_LOW);
endtask


`endif
