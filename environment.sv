class environment extends component;

    fifo_generator gen;
    fifo_driver drv;
    fifo_monitor mon;
   
    mailbox gen_driv_mb;
    mailbox mon_scb_mb;
  
    function new(string name, component parent, virtual fifo_if vif);
      super.new(name, parent);
      gen_driv_mb = new();
      mon_scb_mb = new();
      gen = new("my_gen", this, gen_driv_mb);
      drv = new("my_driver", this, vif, gen_driv_mb);
      mon = new("my_mon", this, vif, mon_scb_mb);   
    endfunction
  
    task run();
      fork
        gen.run();
        drv.run();
        mon.run();      
      join_none
  
      #200;
      $finish;
  
    endtask
  
  endclass
  
  