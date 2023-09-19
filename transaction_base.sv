typedef class component;

class transaction_base;
  static int num_objects;
  int obj_ID;  // identifier for each transaction
  component my_gen;

  // constructor new to instantiate
  function new(component my_gen = null);
    this.my_gen = my_gen;
    num_objects++;
    obj_ID = num_objects;
  endfunction

  //copy can be overridden by extended class. To make it mandatory,use pure virtual
  virtual function transaction_base copy();
  endfunction

endclass