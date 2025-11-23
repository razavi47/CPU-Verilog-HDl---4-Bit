module instruction_memory (
  input clk,
  input [3:0] pc_addr,
  output reg [7:0] instruction_out
);

  reg [7:0] rom [15:0];
  
  initial begin
    // 0101 MOV
    // 1000 AND
    // 1111 HALT

    rom[0] = 8'b0101_0010; // MOV R0
    rom[1] = 8'b0101_0111; // MOV R1
    rom[2] = 8'b1000_0001; // ADD R0,R1
    rom[3] = 8'b1111_0000; // HALT
    rom[4] = 8'b0000_0000;
    rom[5] = 8'b0000_0000;
  end

  always @(posedge clk) begin
    instruction_out <= rom(pc_addr);
  end
endmodule
