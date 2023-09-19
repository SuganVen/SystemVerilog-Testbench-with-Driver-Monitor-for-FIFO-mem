module fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
) (
    // inputs to FIFO
    input logic                  clk,      // Clock signal
    input logic                  rst,      // Reset signal
    input logic [DATA_WIDTH-1:0] data_in,  // Data to write
    input logic                  wr,       // Enable signal for write
    input logic                  rd,       // Enable signal for read

    // outputs from FIFO
    output logic [DATA_WIDTH-1:0] data_out,  // Data to read
    output logic                  full,      // FIFO full indicator
    output logic                  empty      // FIFO empty indicator    
);

  parameter FIFO_DEPTH = 1 << ADDR_WIDTH;  // Depth of the FIFO (number of elements)

  // FIFO data storage
  reg [DATA_WIDTH:0] fifo[FIFO_DEPTH-1:0];

  reg [ADDR_WIDTH-1:0] wr_ptr, rd_ptr;
  reg [ADDR_WIDTH:0] fifo_count;


  // Flags to indicate FIFO status
  assign empty = (fifo_count == 0);
  assign full  = (fifo_count == FIFO_DEPTH);

  // Clocked process for write
  always @(posedge clk or posedge rst) begin : write
    if (rst) begin
      wr_ptr <= 0;
    end else if ((wr && !full) || (wr && rd)) begin
      fifo[wr_ptr] <= data_in;
      wr_ptr <= wr_ptr + 1;
    end
  end

  // Clocked process for read
  always @(posedge clk or posedge rst) begin : read
    if (rst) begin
      rd_ptr <= 0;
    end else if ((rd && !empty) || (rd && wr)) begin
      data_out <= fifo[rd_ptr];
      rd_ptr   <= rd_ptr + 1;
    end
  end

  always @(posedge clk or posedge rst) begin : fifo_counter
    if (rst) begin
      fifo_count <= 0;
    end else begin
      case ({
        wr, rd
      })
        2'b00:   fifo_count <= fifo_count;
        2'b10:   fifo_count <= (fifo_count == FIFO_DEPTH) ? FIFO_DEPTH : fifo_count + 1;
        2'b01:   fifo_count <= (fifo_count == 0) ? 0 : fifo_count - 1;
        2'b11:   fifo_count <= fifo_count;
        default: fifo_count <= fifo_count;
      endcase
    end
  end
endmodule


