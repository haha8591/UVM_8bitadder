module dut(
   input clk,
   input rst_n,
   input  [7:0] in_a,
   input  [7:0] in_b,
   input in_valid,
   output reg  [8:0] out_sum,
   output reg  out_valid
);

   always @(posedge clk) begin
      if(!rst_n) begin
         out_sum    <= 9'h0;
         out_valid   <= 1'b0;
      end
      else if(in_valid) begin
         out_sum    <= in_a + in_b;
         out_valid   <= 1'b1;
      end
      else begin
         out_valid   <= 1'b0;
      end
   end

endmodule
