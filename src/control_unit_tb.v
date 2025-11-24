`timescale 1ns/1ps

module control_unit_tb;
    reg clk;
    reg reset;
    reg [3:0] opcode;
    reg [3:0] status_reg;
    wire ir_load_en;
    wire reg_write_en;
    wire alu_en;
    wire jump_en;
    wire halt;
    wire [3:0] alu_opcode;

    control_unit dut (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .status_reg(status_reg),
        .ir_load_en(ir_load_en),
        .reg_write_en(reg_write_en),
        .alu_en(alu_en),
        .jump_en(jump_en),
        .halt(halt),
        .alu_opcode(alu_opcode)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        opcode = 4'b0000;
        status_reg = 4'b0000;
        #12 reset = 1;

        opcode = 4'b0101;
        #50;

        opcode = 4'b1000;
        #50;

        opcode = 4'b1001;
        #50;

        opcode = 4'b1010;
        #50;

        opcode = 4'b1011;
        #50;

        opcode = 4'b0011;
        #50;

        opcode = 4'b1111;
        #50;

        opcode = 4'b1000;
        #50;

        $finish;
    end

    initial begin
        $monitor(
            "t=%0t | opcode=%b | ir_load=%b | reg_write=%b | alu_en=%b | halt=%b | alu_op=%b",
            $time, opcode, ir_load_en, reg_write_en, alu_en, halt, alu_opcode
        );
    end

endmodule
