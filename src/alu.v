module alu (
    input  [3:0] A, 
    input  [3:0] B,
    input  [3:0] opcode,
    input        alu_en,
    output reg [3:0] result,
    output reg zero_flag,
    output reg negative_flag,
    output reg carry_flag,
    output reg overflow_flag
);

    reg [4:0] temp;

    always @(*) begin
        if (alu_en) begin
            case (opcode)
                4'b1000: begin // ADD
                    temp = A + B;
                    overflow_flag = ((A[3] == B[3]) && (temp[3] != A[3]));
                end
                
                4'b1001: begin // SUB
                    temp = A - B;
                    overflow_flag = ((A[3] != B[3]) && (temp[3] == B[3]));
                end

                4'b1010: temp = A & B;      // AND
                4'b1011: temp = A | B;      // OR
                4'b1100: temp = A ^ B;      // XOR
                4'b1101: temp = ~A;         // NOT
                4'b1110: temp = A << 1;     // SHL
                4'b1111: temp = A >> 1;     // SHR

                default: temp = 5'b00000;
            endcase

            result = temp[3:0];
            zero_flag = (result == 4'b0000);
            negative_flag = result[3];
            carry_flag = temp[4];
        end 
        else begin
            result = 4'b0000;
            zero_flag = 1'b0;
            negative_flag = 1'b0;
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
    end
endmodule
