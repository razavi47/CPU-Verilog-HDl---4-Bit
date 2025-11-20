module register (

  input clk,
  input reset,
  input [3:0] data_in,
  input write_en,
  input select_line,
  output reg [3:0] R0,R1,
  output reg [3:0] read_data1,read_data2,
);

  always @(posedge clk or negedge reset) begin
      if (!reset) begin
        R0 <= 4'b0000;
        R1 <= 4'b0000;
      end
    else if (write_en) begin
      if(select_line == 1'b0)
        R0 <= data_in;
        else
            R1 <= data_in;
  end

  always @(*) begin
    read_data1 = R0;
    read_data2 = R1;
  end
endmodule

    
  
  
