class component;

    string name;
    component parent;
    component children_queue[$];
  
    function new(string name, component parent);
      this.name   = name;
      this.parent = parent;
      if (parent != null) begin
        // adding children to the parent
        parent.children_queue.push_back(this);
      end
    endfunction
  
    function string get_name();
      return name;
    endfunction
  
    function component get_parent();
      return parent;
    endfunction
  
    // run task can be overridden by extended class. To make it mandatory,use pure virtual
    virtual task run();
    endtask
  
  endclass
    