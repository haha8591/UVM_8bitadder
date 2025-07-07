`ifndef MY_MONITOR__SV
`define MY_MONITOR__SV

`include "uvm_macros.svh" 
import uvm_pkg::*; 

class my_monitor extends uvm_monitor;

   virtual my_if vif;
   uvm_analysis_port #(my_transaction)  ap;
   bit monitor_input;
   
   `uvm_component_utils(my_monitor)
   function new(string name = "my_monitor", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
         `uvm_fatal("my_monitor", "virtual interface must be set for vif!!!")
      ap = new("ap", this);
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task collect_one_pkt(my_transaction tr);
endclass

task my_monitor::main_phase(uvm_phase phase);
   my_transaction tr;
   while(1) begin
      tr = new("tr");
      collect_one_pkt(tr);
      ap.write(tr);
   end
endtask

//把資料還原成transaction
task my_monitor::collect_one_pkt(my_transaction tr);

   logic [7:0] data_a;
   logic [7:0] data_b;
   logic [8:0] data_sum;
   logic valid = 0;
   
   while(1) begin
      @(posedge vif.clk);
      if(vif.valid) break;
   end
   
   `uvm_info("my_monitor", "begin to collect one pkt", UVM_LOW);
   if(monitor_input) begin  // in_agent
      tr.data_a = vif.data_a;
      tr.data_b = vif.data_b;
   end
   else begin  // out_agent
      tr.data_sum = vif.data_sum;
   end

   `uvm_info("my_monitor", "end collect one pkt", UVM_LOW);
endtask


`endif
