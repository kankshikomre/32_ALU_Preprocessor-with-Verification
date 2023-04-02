`define DRIV_IF vif.DRIVER.driver_cb
class driver;
  
  //used to count the number of transactions
  int no_transactions;
  
  //creating virtual interface handle
  virtual ALU_intf vif;
  
  //creating mailbox handle
  mailbox gen2driv;
  
  //constructor
  function new(virtual ALU_intf vif,mailbox gen2driv);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from  environment 
    this.gen2driv = gen2driv;
  endfunction
  
  //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(vif.reset);
    $display("[ DRIVER ] ----- Reset Started -----");
    vif.aluin1 <= 0;
    vif.aluin2 <= 0;
    vif.operation_out <= 0;
    vif.opselect_out <= 0;
    vif.shift_number <= 0;
    vif.enable_arith <= 0;
    vif.enable_shift <= 0;
    wait(!vif.reset);
    $display("[ DRIVER ] ----- Reset Ended   -----");
  endtask
  
  //drivers the transaction items to interface signals
  task main;
    forever begin
      transaction trans;
      gen2driv.get(trans);
      @(posedge vif.clock);
      vif.enable_ex <= 1;
      vif.src1 <= trans.src1;
      vif.src2 <= trans.src2;
      vif.imm <= trans.imm;
      vif.control_in <= trans.control_in;
      vif.memory_data_read_in <= trans.memory_data_read_in;
      
      @(posedge vif.clock);
      vif.enable_ex <= 0;
      trans.mem_data_write_out = vif.mem_data_write_out;
      trans.mem_write_en = vif.mem_write_en;
      trans.aluout = vif.aluout;
      trans.carry = vif.carry;
      
      @(posedge vif.clock);
      trans.display("[ Driver ]");
      no_transactions++;
    end
  endtask
  
endclass
