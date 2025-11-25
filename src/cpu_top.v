module cpu_top (
  input clk, 
  input reset
);

  wire [3:0] pc_addr;
  wire [7:0] instruction;
  wire [3:0] op_code;
  wire [1:0] reg_sel;
  wire [1:0] data;

  wire ir_load_en,alu_en,jump_en,reg_write_en,halt;
  wire [3:0] alu_opcode;

  wire [3:0] R0, R1;
  wire [3:0] read_data1, read_data2;
  wire [3:0] alu_result;
  wire zero_flag, negative_flag, carry_flag, overflow_flag;

  reg [3:0] status_reg;
  reg [3:0] alu_out_reg;
  wire [3:0] write_back_data;

  assign write_back_data = (op_code == 4'b0101) ? {2'b00, data} : alu_out_reg;


  always @(posedge clk) begin
    if (alu_en) begin
         alu_out_reg <= alu_result;
         status_reg <= {zero_flag, negative_flag, carry_flag, overflow_flag};
    end
  end


counter pc1(
    .clk(clk),
    .reset(reset),
    .jump_en(jump_en),
    .jump_addr(instruction[3:0]),
    .halt(halt),
    .ir_load_en(ir_load_en),
    .pc_out(pc_addr)
);

instruction_memory im(
    .clk(clk),
    .pc_addr(pc_addr),
    .instruction_out(instruction)
);

instruction_reg ir(
    .clk(clk),
    .reset(reset),
    .ir_load_en(ir_load_en),
    .instruction_in(instruction),
    .op_code(op_code),
    .reg_sel(reg_sel),
    .data(data)
);

control_unit cu(
    .clk(clk),
    .reset(reset),
    .opcode(op_code),
    .status_reg(status_reg),
    .ir_load_en(ir_load_en),
    .reg_write_en(reg_write_en),
    .alu_en(alu_en),
    .jump_en(jump_en),
    .halt(halt),
    .alu_opcode(alu_opcode)
);

reg_file rf(
    .clk(clk),
    .reset(reset),
    .data_in(write_back_data),
    .write_en(reg_write_en),
    .select_line(reg_sel[0]),
    .R0(R0),
    .R1(R1),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

alu a(
    .A(read_data1),
    .B(read_data2),
    .opcode(alu_opcode),
    .alu_en(alu_en),
    .result(alu_result),
    .zero_flag(zero_flag),
    .negative_flag(negative_flag),
    .carry_flag(carry_flag),
    .overflow_flag(overflow_flag)
);

endmodule
