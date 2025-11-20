`timescale 1ns/1ps

module alu_tb;

    reg  [3:0] A, B;
    reg  [3:0] opcode;
    reg alu_en;
    wire [3:0] result;
    wire zero_flag, negative_flag, carry_flag, overflow_flag;

    alu dut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .alu_en(alu_en),
        .result(result),
        .zero_flag(zero_flag),
        .negative_flag(negative_flag),
        .carry_flag(carry_flag),
        .overflow_flag(overflow_flag)
    );

    task run_test;
        input [3:0] tA;
        input [3:0] tB;
        input [3:0] tOP;
        begin
            A = tA;
            B = tB;
            opcode = tOP;
            alu_en = 1;
            #5;

            $display("OP=%b | A=%b (%0d)  B=%b (%0d) | RESULT=%b (%0d) | Z=%b N=%b C=%b OV=%b",
                      tOP, A, A, B, B, result, result, 
                      zero_flag, negative_flag, carry_flag, overflow_flag);
        end
    endtask

    initial begin
        $display("==== ALU TESTBENCH START ====");

        alu_en = 0;
        A = 0;
        B = 0;
        opcode = 0;
        #5;
        run_test(4'b0010, 4'b0011, 4'b1000);  // 2 + 3
        run_test(4'b0111, 4'b0100, 4'b1000);  // 7 + 4 (overflow expected)

        run_test(4'b0100, 4'b0001, 4'b1001);  // 4 - 1
        run_test(4'b1000, 4'b0001, 4'b1001);  // negative result

        run_test(4'b1010, 4'b1100, 4'b1010); // and

        run_test(4'b1010, 4'b0101, 4'b1011); // or

        run_test(4'b1010, 4'b0110, 4'b1100); // xor

        run_test(4'b1010, 4'b0000, 4'b1101); // not/compliment

        run_test(4'b0011, 4'bxxxx, 4'b1110); // shift left

        run_test(4'b1000, 4'bxxxx, 4'b1111); // shift right

        alu_en = 0; // alu disabled 
        A = 4'b1111; B = 4'b1111; opcode = 4'b1000;
        #5;
        $display("ALU disable test | RESULT=%b Z=%b N=%b C=%b OV=%b",
                  result, zero_flag, negative_flag, carry_flag, overflow_flag);

        $display("==== ALU TESTBENCH END ====");
        $finish;
    end

endmodule
