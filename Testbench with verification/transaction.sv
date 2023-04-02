class transaction;
  
  rand bit enable_ex;     				//control signal      
  rand bit [`N-1:0] src1, src2;			//data signals  
  rand bit [`N-1:0] imm;
  rand bit [`C-1:0] control_in;
  rand bit [`N-1:0] memory_data_read_in;
  
  bit [`N-1:0]aluin1,aluin2;
  bit [`O-1:0]operation_out,opselect_out;
  bit [`S-1:0]shift_number;
  bit enable_arith,enable_shift;
  
  bit [`N-1:0]mem_data_write_out;
  bit mem_write_en;
  bit [`N-1:0]aluout;
  bit carry; 
  
  function void display(string name);
    $display("-------------------------");
    $display("- %s ",name);
    $display("-------------------------");
    $display("- src1 = %0d, src2 = %0d, imm = %0d, control_in = %0d, memory_data_read_in = %0d",src1,src2,imm,control_in,memory_data_read_in);
    
    $display("- mem_data_write_out = %0d, mem_write_en = %0d, aluout = %0d, carry = %0d",mem_data_write_out,mem_write_en,aluout,carry);
    $display("-------------------------");
  endfunction

endclass
