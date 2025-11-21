module counter (
  input clk,
  input reset,
  input jump_en,
  input [3:0] jump_addr,
  input halt,
  input ir_load_en,
  output reg [3:0] pc_out
  );

  always @(posedge clk or negedge reset) begin
    if (!reset)
        pc_out <= 4'b0000;
      else if (jump_en)
        pc_out <= jump_addr;
      else if (!halt && ir_load_en)
        pc_out <= pc_out + 1'b1;
      else
        pc_out <= pc_out;
  end
endmodule  
          
      
      
  
