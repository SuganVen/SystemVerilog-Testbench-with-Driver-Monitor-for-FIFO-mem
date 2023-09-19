
typedef virtual fifo_if.monitor_mp monitor_if;

class fifo_monitor extends component;
    monitor_if mon_if;
    mailbox mon_scb_mb;
  
    function new(string name, component parent, monitor_if mon_if, mailbox mb);
      super.new(name, parent);
      this.mon_if = mon_if;
      mon_scb_mb  = mb;
    endfunction
  
    task run();
      forever  begin
        fifo_transaction trans;
        trans = new(this);
        @(mon_if.mon_cb);    
        trans.wr = mon_if.mon_cb.wr;
        trans.data_in = mon_if.mon_cb.data_in;      
        trans.rd = mon_if.mon_cb.rd;
        trans.data_out = mon_if.mon_cb.data_out;
        
        trans.full  = mon_if.mon_cb.full;
        trans.empty = mon_if.mon_cb.empty;
        mon_scb_mb.put(trans);
        $display("**Monitor** Wr: %b, Rd: %b, Data_in: %d, Data_out: %d", trans.wr, trans.rd, trans.data_in, trans.data_out);
        end
    endtask
  
  endclass
  