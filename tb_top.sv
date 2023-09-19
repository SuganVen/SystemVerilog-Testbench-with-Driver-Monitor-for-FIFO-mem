`include "fifo_tb_pkg.sv"
import fifo_tb_pkg::*;


module tb_top;
    import fifo_tb_pkg::*;
    bit clk, rst;
    environment env;
  
    fifo_if intf (
        clk,
        rst
    );
    fifo dut (
        .clk(clk),
        .rst(rst),
        .data_in(intf.data_in),
        .wr(intf.wr),
        .rd(intf.rd),
        .data_out(intf.data_out),
        .full(intf.full),
        .empty(intf.empty)
    );
  
    always #5 clk = ~clk;
  
    initial begin
      rst = 1;
      #10;
      rst = 0;
      env = new("my_env", null, intf);
      env.run();
    end
  
    initial begin
      $dumpvars;
      $dumpfile("dump.vcd");
    end
  
  endmodule
  
  
  
  