class scoreboard;
   
  //creating mailbox handle
  mailbox mon2scb;
  
  //used to count the number of transactions
  int no_transactions;
  
  //constructor
  function new(mailbox mon2scb);
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
  endfunction
  
  //Compares the Actual result with the expected result
  task main;
    transaction trans;
    forever begin
      mon2scb.get(trans);
      begin
        
        case({trans.enable_arith,trans.opselect_out,trans.operation_out})
                7'b0????: trans.aluout <= trans.aluout;
          {1'b1,`ARITH_LOGIC, `ADD}: if(trans.aluout == trans.aluin1 + trans.aluin2)
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`ARITH_LOGIC, `HADD}: if(trans.aluout == $signed(trans.aluin1[15:0] + trans.aluin2[15:0]))
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`ARITH_LOGIC, `SUB}: if(trans.aluout == trans.aluin1 - trans.aluin2)
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`ARITH_LOGIC, `NOT}: if(trans.aluout[32] == 0 && trans.aluout[31:0] == ~(trans.aluin2[31:0]))
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`ARITH_LOGIC, `AND}: if(trans.aluout == trans.aluin1 & trans.aluin2)
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`ARITH_LOGIC, `OR}: if(trans.aluout == trans.aluin1 | trans.aluin2)
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`ARITH_LOGIC, `XOR}: if(trans.aluout == trans.aluin1 ^ trans.aluin2)
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`ARITH_LOGIC, `LHG}: if(trans.aluout == {1'b0,trans.aluin2[15:0],16'b0})
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`MEM_READ, `LOADBYTE}: if(trans.aluout == {1'b0,{24{trans.aluin2[7]}}, trans.aluin2[7:0]})
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`MEM_READ, `LOADBYTEU}: if(trans.aluout == {1'b0,24'b0, trans.aluin2[7:0]})
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`MEM_READ, `LOADHALF}: if(trans.aluout == {1'b0,{16{trans.aluin2[15]}}, trans.aluin2[15:0]})
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`MEM_READ, `LOADHALFU}: if(trans.aluout == {1'b0,16'b0, trans.aluin2[15:0]})
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`MEM_READ, `LOADWORD}: if(trans.aluout == {1'b0, trans.aluin2[31:0]})
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          {1'b1,`MEM_READ, 3'b???}: if(trans.aluout == {1'b0, trans.aluin2[31:0]})
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
          default: if(trans.aluout == trans.aluout)
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s and %s",trans.opselect_out,trans.operation_out);
       
        endcase
      end
      
      begin
        case({trans.enable_shift,1'b0,trans.operation_out[1:0]})
          4'b0????: if(trans.aluout == trans.aluout)
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s",trans.operation_out);
          {1'b1,`SHLEFTLOG}: if(trans.aluout == {1'b0,trans.aluin1 << trans.shift_number})
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s",trans.operation_out);
          {1'b1,`SHLEFTART}: if(trans.aluout == {trans.aluin1[`N-1],trans.aluin1 << trans.shift_number})
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s",trans.operation_out);
          {1'b1,`SHRGHTLOG}: if(trans.aluout == {1'b0,trans.aluin1 >> trans.shift_number})
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s",trans.operation_out);
          {1'b1,`SHRGHTART}: if(trans.aluout == {1'b0,trans.aluin1 >>> trans.shift_number})
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s",trans.operation_out);
          default: if(trans.aluout == trans.aluout)
            $display("Result is as Expected");
          else
            $error("Wrong Result for operation %s",trans.operation_out);
        endcase
      end
      
      no_transactions++;
      trans.display("[ Scoreboard ]");
    end
  endtask
  
endclass


/////////////////////////////////////
