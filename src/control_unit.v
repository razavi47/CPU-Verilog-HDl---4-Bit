module control_unit (
  input clk,
  input reset,
  input [3:0] opcode,
  input [3:0] status_reg,
  output reg ir_load_en,
  output reg reg_write_en,
  output reg alu_en,
  output reg jump_en,
  output reg halt,
  output reg [3:0] alu_opcode
);

  parameter FETCH      = 3'b000,
            DECODE     = 3'b001,
            EXECUTE    = 3'b010,
            WRITE_BACK = 3'b011,
            HALT_STATE = 3'b100;

  parameter Z_FLAG_BIT = 3;

  reg [2:0] state, next_state;

  always @(posedge clk or negedge reset) begin
    if (!reset)
      state <= FETCH;
    else
      state <= next_state;
  end

  always @(*) begin
    // Default outputs
    ir_load_en   = 0;
    reg_write_en = 0;
    alu_en       = 0;
    jump_en      = 0;
    halt         = 0;
    alu_opcode   = 4'b0000;
    next_state   = state;

    case (state)

      FETCH: begin
        ir_load_en = 1;
        next_state = DECODE;
      end

      DECODE: begin
        case (opcode)
          4'b1111: next_state = HALT_STATE; // HALT
          default: next_state = EXECUTE;
        endcase
      end

      EXECUTE: begin
        case (opcode)
          4'b1000, 4'b1001, 4'b1010, 4'b1011,
          4'b1100, 4'b1101, 4'b1110: begin
            alu_en     = 1;
            alu_opcode = opcode;
          end

          4'b0101: begin // MOV
            alu_en = 0;
          end

          default: begin
            alu_en = 0;
          end
        endcase

        next_state = WRITE_BACK;
      end

      WRITE_BACK: begin
        case (opcode)
          4'b0101, 4'b1000, 4'b1001, 4'b1010,
          4'b1011, 4'b1100, 4'b1101, 4'b1110:
              reg_write_en = 1;
        endcase
        next_state = FETCH;
      end

      HALT_STATE: begin
        halt = 1;
        next_state = HALT_STATE;
      end

      default: next_state = FETCH;

    endcase
  end

endmodule

              
    
