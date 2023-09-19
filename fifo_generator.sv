class fifo_generator extends component;
    mailbox gen_driv_mb;
    int trans_cycles = 20;
  
    function new(string name, component parent, mailbox mb);
      super.new(name, parent);
      this.gen_driv_mb = mb;
    endfunction
  
    task run();
      fifo_transaction trans;
      repeat (trans_cycles) begin
        trans = new(this);
  
        assert (trans.randomize())
        else begin
          $error("Randomization failure in %s", get_name());
        end
  
        gen_driv_mb.put(trans);
  
      end
    endtask
  
  endclass
  
  