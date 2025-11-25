`timescale 1ns / 1ps

module cpu_top_tb;
  reg clk;
  reg reset;

  cpu_top DUT (
    .clk(clk),
    .reset(reset)
  );
  always #5 clk = ~clk;

  initial begin
    $display("==== CPU TESTBENCH START ====");

    clk = 0;
    reset = 1;

    #20;
    reset = 0;

    DUT.im.memory[0] = 8'b1011_00_10;  // load I R0 = 2
    DUT.im.memory[1] = 8'b1011_01_01;  // load I R1 = 1
    DUT.im.memory[2] = 8'b0001_01_00;  // add R0 = R1 + R0
    DUT.im.memory[3] = 8'b1111_00_00;  // halt 
    DUT.im.memory[4] = 8'b0000_00_00;
    DUT.im.memory[5] = 8'b0000_00_00;

    #500;
    $display("==== CPU TESTBENCH END ====");
    $finish;
  end

  initial begin
    $monitor("T=%0t | PC=%0d | INST=%b | R0=%d | R1=%d | ALU=%d | Flags={Z=%b N=%b C=%b O=%b}",
        $time,
        DUT.pc_addr,
        DUT.instruction,
        DUT.R0,
        DUT.R1,
        DUT.alu_result,
        DUT.zero_flag,
        DUT.negative_flag,
        DUT.carry_flag,
        DUT.overflow_flag
    );
  end

endmodule
