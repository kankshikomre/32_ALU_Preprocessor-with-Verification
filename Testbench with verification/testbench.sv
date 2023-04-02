// Code your testbench here
// or browse Examples

`include "interface.sv"
`include "testing.sv"

module top_testbench;
  
  //clock and reset signal declaration
  bit clock;
  bit reset;
  
  //clock generation
  always #5 clock = ~clock;
  
  //reset Generation
  initial begin
    reset = 1;
    #5 reset = 0;
  end
  
  
  //creatinng instance of interface, inorder to connect DUT and testcase
  ALU_intf i_intf(clock,reset);
  
  //Testcase instance, interface handle is passed to test as an argument
  test t1(i_intf);
  
  //DUT instance, interface signals are connected to the DUT ports
  Processor DUT (
    .clock(i_intf.clock),
    .reset(i_intf.reset),
    .enable_ex(i_intf.enable_ex),
    .src1(i_intf.src1),
    .src2(i_intf.src2),
    .imm(i_intf.imm),
    .control_in(i_intf.control_in),
    .memory_data_read_in(i_intf.memory_data_read_in),
    .mem_data_write_out(i_intf.mem_data_write_out),
    .mem_write_en(i_intf.mem_write_en),
    .aluout(i_intf.aluout),
    .carry(i_intf.carry)
  );
  
  //enabling the wave dump
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
endmodule

