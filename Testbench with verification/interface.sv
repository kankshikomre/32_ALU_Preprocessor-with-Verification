`define N 32
`define C 7
`define O 3
`define S 5

interface ALU_intf(input logic clock,reset);
  
  //declaring the signals
  logic enable_ex;              		//control signal      
  logic [`N-1:0] src1, src2;			//data signal   
  logic [`N-1:0] imm;
  logic [`C-1:0] control_in;
  logic [`N-1:0] memory_data_read_in;
  
  logic [`N-1:0]aluin1, aluin2;
  logic [`O-1:0]operation_out, opselect_out;
  logic [`S-1:0]shift_number;
  logic enable_arith,enable_shift;
  
  logic [`N-1:0]mem_data_write_out;
  logic mem_write_en;
  logic [`N-1:0]aluout;
  logic carry; 
  
  //driver clocking block
  clocking driver_cb @(posedge clock);
    default input #1 output #1;
    output enable_ex;
    output src1,src2;
    output imm;
    output control_in;
    output memory_data_read_in;
    
    input mem_data_write_out; 
    input mem_write_en;
    input aluout;
    input carry;    
  endclocking
  
  //monitor clocking block
  clocking monitor_cb @(posedge clock);
    default input #1 output #1;
    output enable_ex;
    output src1,src2;
    output imm;
    output control_in;
    output memory_data_read_in;
    
    input mem_data_write_out; 
    input mem_write_en;
    input aluout;
    input carry; 
  endclocking
  
  //driver modport
  modport DRIVER  (clocking driver_cb,input clock,reset);
  
  //monitor modport
  modport MONITOR (clocking monitor_cb,input clock,reset);
    
endinterface
