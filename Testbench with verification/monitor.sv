`define MON_IF vif.MONITOR.monitor_cb
class monitor;
  
  //creating virtual interemface handle
  virtual ALU_intf vif;
  
  //creating mailbox handle
  mailbox mon2scb;
  
  //constructor
  function new(virtual ALU_intf vif,mailbox mon2scb);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
  endfunction

  //Samples the interface signal and send the sample packet to scoreboard
  task main;
    forever begin
      transaction trans;
      trans = new();
      
      @(posedge vif.clock);
      wait(vif.enable_ex);
      trans.src1 = vif.src1;
      trans.src2 = vif.src2;
      trans.imm = vif.imm;
      trans.control_in = vif.control_in;
      trans.memory_data_read_in = vif.memory_data_read_in;
      
      @(posedge vif.clock);
      trans.mem_data_write_out = vif.mem_data_write_out;
      trans.mem_write_en = vif.mem_write_en;
      trans.aluout = vif.aluout;
      trans.carry = vif.carry;
      
      @(posedge vif.clock);
      mon2scb.put(trans);
      trans.display("[ Monitor ]");
    end
  endtask

  
endclass
