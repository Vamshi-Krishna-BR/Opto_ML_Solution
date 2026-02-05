module optoML_solution #(
    parameter int DATA_WIDTH = 32
) (

    input logic                  clock,
    input logic                  resetn,
    input logic                  in_valid,
    input logic [DATA_WIDTH-1:0] in_data,
    input logic                  out_ready,

    output logic                  out_valid,
    output logic                  in_ready,
    output logic [DATA_WIDTH-1:0] out_data
);

  assign out_valid = valid_reg;
  assign out_data  = data_reg;
  assign in_ready  = !valid_reg || out_ready;

  //Internal register to hold data during backpressure.
  // Data is captured on a valid handshake (in_valid && in_ready)
  // Data is held stable until the downstream is ready to accept the data.  
  logic [DATA_WIDTH-1:0] data_reg;
  logic valid_reg;

  // Using an asynchronous active-low reset 
  always@(posedge clock or negedge resetn) begin
    if (!resetn) begin
      valid_reg <= 1'b0;
      data_reg  <= '0;
    end else begin
      if (in_ready && in_valid) begin
        valid_reg <= 1'b1;
        data_reg  <= in_data;
      end else if (out_ready && valid_reg) begin
        valid_reg <= 1'b0;
      end
    end
  end
endmodule
