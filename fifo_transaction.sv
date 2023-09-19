class fifo_transaction extends transaction_base;
  rand bit [7:0] data_in;
  rand bit wr;
  rand bit rd;
  bit [7:0] data_out;
  bit full;
  bit empty;

  function new(component my_gen = null);
    super.new(my_gen);
  endfunction

  function fifo_transaction copy();
    fifo_transaction trans_copy;
    trans_copy = new(my_gen);
    trans_copy.data_in = data_in;
    trans_copy.wr = wr;
    trans_copy.rd = rd;
    trans_copy.data_out = data_out;
    trans_copy.full = full;
    trans_copy.empty = empty;
    return trans_copy;
  endfunction
  
endclass