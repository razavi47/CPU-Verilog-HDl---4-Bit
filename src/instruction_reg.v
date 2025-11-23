module instruction_reg (
  input clk,
  input reset,
  input ir_load_en,
  input [7:0] instruction_in,
  output reg [3:0] op_code,
  output reg [1:0] reg_sel,
  output reg [1:0] data
);

always @(posedge clk or negedge reset) begin
  if (!reset) begin
    op_code <= 4'b0000;
    reg_sel <= 2'b00;
    data <= 2'b00;
  end
  else if (ir_load_en) begin
    op_code <= instruction_in[7:4];
    reg_sel <= instruction_in[3:2];
    data <= instruction_in[1:0];
  end
end
endmodule
