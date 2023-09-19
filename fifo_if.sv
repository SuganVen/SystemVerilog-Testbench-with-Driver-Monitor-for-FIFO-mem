interface fifo_if (
    input clk,
    rst
);
  logic [7:0] data_in;
  logic wr;
  logic rd;
  logic [7:0] data_out;
  logic full;
  logic empty;

  //clocking block for driver
  clocking driv_cb @(posedge clk);
    output #1 data_in, wr, rd;
    input #1step data_out, full, empty;
  endclocking

  // clocking block for monitor
  clocking mon_cb @(posedge clk);
    input #1step data_in, wr, rd, data_out, full, empty;
  endclocking

  //modport dut_mp (input data_in, wr, rd, output data_out, full, empty);
  modport driver_mp(clocking driv_cb);
  modport monitor_mp(clocking mon_cb);

endinterface
