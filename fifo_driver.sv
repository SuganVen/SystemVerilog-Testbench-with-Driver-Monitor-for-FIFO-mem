typedef virtual fifo_if.driver_mp driver_if;


class fifo_driver extends component;
    driver_if driv_if;
    mailbox   gen_driv_mb;
  
    function new(string name, component parent, driver_if driv_if, mailbox mb);
      super.new(name, parent);
      this.driv_if = driv_if;
      gen_driv_mb  = mb;
    endfunction
  
    task run();
      drive();
    endtask
  
    task drive();
      fifo_transaction trans;
      gen_driv_mb.get(trans);
      do begin
        @(driv_if.driv_cb);
  
        driv_if.driv_cb.wr <= trans.wr;
        driv_if.driv_cb.rd <= trans.rd;
        if (trans.wr == 1) begin
          driv_if.driv_cb.data_in <= trans.data_in;
        end
        if (trans.rd == 1) begin
          trans.data_out = driv_if.driv_cb.data_out;
        end
        trans.full  = driv_if.driv_cb.full;
        trans.empty = driv_if.driv_cb.empty;
        $display("**Driver** Wr: %b, Rd: %b, Data_in: %d, Data_out: %d", trans.wr, trans.rd, trans.data_in, trans.data_out);
        
      end while (gen_driv_mb.try_get(trans));
    endtask
  endclass
  
  