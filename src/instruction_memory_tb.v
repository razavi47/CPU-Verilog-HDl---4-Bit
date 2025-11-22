`timescale 1ns/1ps

module instruction_memory_tb;
    reg clk;
    reg [3:0] pc_addr;
    wire [7:0] instruction_out;

    instruction_memory dut (
        .clk(clk),
        .pc_addr(pc_addr),
        .instruction_out(instruction_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        pc_addr = 0;

        #10 pc_addr = 4'd0;   // expect 0101_0010
        #10 pc_addr = 4'd1;   // expect 0101_0111
        #10 pc_addr = 4'd2;   // expect 1000_0001
        #10 pc_addr = 4'd3;   // expect 1111_0000
        #10 pc_addr = 4'd4;   // expect 0000_0000
        #10 pc_addr = 4'd5;   // expect 0000_0000
        #20 $finish;
    end

    initial begin
        $monitor("t=%0t | PC=%d | instruction=%b",
                  $time, pc_addr, instruction_out);
    end

endmodule
