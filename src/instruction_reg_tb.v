`timescale 1ns/1ps

module instruction_reg_tb;
  reg clk;
  reg reset;
  reg ir_load_en;
  reg [7:0] instruction_in;

  wire [3:0] op_code;
  wire [1:0] reg_sel;
  wire [1:0] data;

  instruction_reg DUT (
    .clk(clk),
    .reset(reset),
    .ir_load_en(ir_load_en),
    .instruction_in(instruction_in),
    .op_code(op_code),
    .reg_sel(reg_sel),
    .data(data)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset = 0;
    ir_load_en = 0;
    instruction_in = 8'b00000000;

    #10;
    reset = 1;

    #10;
    ir_load_en = 1;
    instruction_in = 8'b1011_01_10; 

    #10;
    ir_load_en = 0;

    #20;
    ir_load_en = 1;
    instruction_in = 8'b0100_11_01;

    #10;
    ir_load_en = 0;

    #20;
    reset = 0;

    #10;
    reset = 1;

    #20;
    $finish;
  end

  initial begin
    $monitor("Time=%0t | instruction=%b | opcode=%b reg=%b data=%b load=%b reset=%b",
              $time, instruction_in, op_code, reg_sel, data, ir_load_en, reset);
  end

endmodule
