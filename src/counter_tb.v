`timescale 1ns/1ps

module counter_tb;

    reg clk;
    reg reset;
    reg jump_en;
    reg [3:0] jump_addr;
    reg halt;
    reg ir_load_en;

    wire [3:0] pc_out;

    counter dut (
        .clk(clk),
        .reset(reset),
        .jump_en(jump_en),
        .jump_addr(jump_addr),
        .halt(halt),
        .ir_load_en(ir_load_en),
        .pc_out(pc_out)
    );

    initial clk = 0; // 10 ns clock 
    always #5 clk = ~clk;

    initial begin
        $display("========== COUNTER TESTBENCH ==========");
        $monitor("t=%0t | clk=%b reset=%b jump_en=%b jump_addr=%b halt=%b ir_load_en=%b || pc_out=%b",
                  $time, clk, reset, jump_en, jump_addr, halt, ir_load_en, pc_out);

        reset = 0;
        jump_en = 0;
        jump_addr = 4'b0000;
        halt = 0;
        ir_load_en = 0;
        #15;

        reset = 1;   // release any reset
        #20;

        ir_load_en = 1;
        halt = 0;
        #40;  // should be incrementing 4 times

        halt = 1;    // counter stops
        #30;

        halt = 0;
        #30;

        jump_addr = 4'b1010;
        jump_en = 1;
        #10;
        jump_en = 0;   // jump off

        #30;

        ir_load_en = 0;
        #30;

        $display("========== END OF COUNTER TESTBENCH ==========");
        $finish;
    end

endmodule
