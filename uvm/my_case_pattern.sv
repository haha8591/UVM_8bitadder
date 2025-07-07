`ifndef MY_CASE_PATTERN__SV
`define MY_CASE_PATTERN__SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class pattern_sequence extends uvm_sequence #(my_transaction);
    my_transaction m_trans;

    function new(string name = "pattern_sequence");
        super.new(name);
    endfunction

    `uvm_object_utils(pattern_sequence)

    virtual task body();
        int i;

        bit [7:0] test_vectors_a[3];
        bit [7:0] test_vectors_b[3];

        if (starting_phase != null)
            starting_phase.raise_objection(this);

        test_vectors_a[0] = 8'hAA; test_vectors_b[0] = 8'h55; // 10101010 + 01010101
        test_vectors_a[1] = 8'hF0; test_vectors_b[1] = 8'h0F; // MSB + LSB
        test_vectors_a[2] = 8'h0F; test_vectors_b[2] = 8'hF0; // LSB + MSB

        for (i = 0; i < 3; i++) begin
            m_trans = my_transaction::type_id::create("m_trans");
            m_trans.data_a = test_vectors_a[i];
            m_trans.data_b = test_vectors_b[i];
            `uvm_info("pattern_sequence",
                $sformatf("Pattern Test: a=0x%0h, b=0x%0h", m_trans.data_a, m_trans.data_b),
                UVM_MEDIUM)
            start_item(m_trans);
            finish_item(m_trans);
        end

        #100;
        if (starting_phase != null)
            starting_phase.drop_objection(this);
    endtask
endclass


class my_case_pattern extends base_test;

   function new(string name = "my_case_pattern", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   `uvm_component_utils(my_case_pattern)

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      uvm_config_db#(uvm_object_wrapper)::set(
        this, "env.i_agt.sqr.main_phase", "default_sequence", pattern_sequence::type_id::get());
   endfunction
endclass

`endif
