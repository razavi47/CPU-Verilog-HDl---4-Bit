`timescale 1ns/1ps

module register_tb;

    reg clk;
    reg reset;
    reg write_en;
    reg select_line;
    reg [3:0] data_in;
    wire [3:0] R0, R1;
    wire [3:0] read_data1, read_data2;

    register dut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .write_en(write_en),
        .select_line(select_line),
        .R0(R0),
        .R1(R1),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    initial clk = 0; // 10ns period
    always #5 clk = ~clk;

    initial begin
        $display("=== REGISTER TESTBENCH START ===");
        $monitor("Time=%0t | reset=%b | write_en=%b | select=%b | data_in=%b | R0=%b | R1=%b | read1=%b | read2=%b", 
                 $time, reset, write_en, select_line, data_in, R0, R1, read_data1, read_data2);

        reset = 0;
        write_en = 0;
        select_line = 0;
        data_in = 4'b0000;
        #10;

        reset = 1;
        #10;

        write_en = 1;
        select_line = 0;
        data_in = 4'b1010;
        #10;

        select_line = 1;
        data_in = 4'b1100;
        #10;

        select_line = 0;
        data_in = 4'b1111;
        #10;

        write_en = 0;
        data_in = 4'b0001;
        select_line = 1;
        #10;

        reset = 0;
        #10;
        reset = 1;
        #10;

        $display("=== REGISTER TESTBENCH END ===");
        $finish;
    end

endmodule
