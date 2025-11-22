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

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        jump_en = 0;
        jump_addr = 4'b0000;
        halt = 0;
        ir_load_en = 0;

        // Apply reset
        #10 reset = 1;
        #10 $display("RESET RELEASED\n");

        #50;
        jump_addr = 4'b1010;   
        jump_en   = 1;
        #10;
        jump_en   = 0;
        #20;

        halt = 1;
        #40;
        halt = 0;

        ir_load_en = 1;
        #40;

        $finish;
    end

    initial begin
        $monitor("t=%0t | pc_out=%b | reset=%b jump=%b addr=%b halt=%b ir_load=%b",
                 $time, pc_out, reset, jump_en, jump_addr, halt, ir_load_en);
    end

endmodule
