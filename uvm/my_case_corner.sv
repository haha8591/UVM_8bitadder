`ifndef MY_CASE_CORNER__SV
`define MY_CASE_CORNER__SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class corner_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;

   function new(string name = "corner_sequence");
      super.new(name);
   endfunction

   `uvm_object_utils(corner_sequence)

   virtual task body();
      int i;
      bit [7:0] test_vectors_a[5];
      bit [7:0] test_vectors_b[5];

      if (starting_phase != null)
         starting_phase.raise_objection(this);

      // 初始化測資
      test_vectors_a[0] = 8'h00; test_vectors_b[0] = 8'h00; // both zero
      test_vectors_a[1] = 8'hFF; test_vectors_b[1] = 8'h01; // overflow
      test_vectors_a[2] = 8'h7F; test_vectors_b[2] = 8'h01; // signed positive overflow
      test_vectors_a[3] = 8'hFF; test_vectors_b[3] = 8'hFF; // full max
      test_vectors_a[4] = 8'h80; test_vectors_b[4] = 8'h80; // signed negative edge


      for (i = 0; i < 5; i++) begin
         m_trans = my_transaction::type_id::create("m_trans");
         m_trans.data_a = test_vectors_a[i];
         m_trans.data_b = test_vectors_b[i];
         `uvm_info("corner_sequence", $sformatf("Corner Test: a=0x%0h, b=0x%0h", m_trans.data_a, m_trans.data_b), UVM_MEDIUM)
         start_item(m_trans);
         finish_item(m_trans);
      end

      #100;
      if (starting_phase != null)
         starting_phase.drop_objection(this);
   endtask
endclass

class my_case_corner extends base_test;

   function new(string name = "my_case_corner", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   `uvm_component_utils(my_case_corner)

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      uvm_config_db#(uvm_object_wrapper)::set(
         this, "env.i_agt.sqr.main_phase", "default_sequence", corner_sequence::type_id::get());
   endfunction

endclass

`endif
