// register file
module REGISTER32 
  (  
    input                    clk, rst,  
    // write port  
    input                    write_en,  
    input          [3:0]     rd,  
    input          [32:0]    data_in,  
    //read port 1  
    input          [3:0]     rs,  
    output         [31:0]    rs_data_out,  
    //read port 2  
    input          [3:0]     rt,  
    output         [31:0]    rt_data_out,
	 //output port for r15
	 output 			 [7:0]	  r15
  );  
  
  reg     [31:0]     reg_array [31:0];  
//  always @(posedge clk) begin  
//    if(!rst) begin  
//      reg_array[0] <= 32'd0;  
//      reg_array[1] <= 32'd0;  
//      reg_array[2] <= 32'd0;  
//      reg_array[3] <= 32'd0;  
//      reg_array[4] <= 32'd0;  
//      reg_array[5] <= 32'd0;  
//      reg_array[6] <= 32'd0;  
//      reg_array[7] <= 32'd0;       
//      reg_array[8] <= 32'd0;  
//      reg_array[9] <= 32'd0;  
//      reg_array[10] <= 32'd0;  
//      reg_array[11] <= 32'd0;  
//      reg_array[12] <= 32'd0;  
//      reg_array[13] <= 32'd0;  
//      reg_array[14] <= 32'd0;  
//      reg_array[15] <= 32'd0;   
//		reg_array[16] <= 32'd0;  
//      reg_array[17] <= 32'd0;  
//      reg_array[18] <= 32'd0;  
//      reg_array[19] <= 32'd0;  
//      reg_array[20] <= 32'd0;  
//      reg_array[21] <= 32'd0;  
//      reg_array[22] <= 32'd0;  
//      reg_array[23] <= 32'd0;       
//      reg_array[24] <= 32'd0;  
//      reg_array[25] <= 32'd0;  
//      reg_array[26] <= 32'd0;  
//      reg_array[27] <= 32'd0;  
//      reg_array[28] <= 32'd0;  
//      reg_array[29] <= 32'd0;  
//      reg_array[30] <= 32'd0;  
//      reg_array[31] <= 32'd0;   
//		
//    end  

  always @(posedge clk) begin  
    if(!rst) begin  
      reg_array[0] <= 32'd0;  
      reg_array[1] <= 32'd1;  
      reg_array[2] <= 32'd2;  
      reg_array[3] <= 32'd3;  
      reg_array[4] <= 32'd4;  
      reg_array[5] <= 32'd5;  
      reg_array[6] <= 32'd6;  
      reg_array[7] <= 32'd7;       
      reg_array[8] <= 32'd8;  
      reg_array[9] <= 32'd9;  
      reg_array[10] <= 32'd10;  
      reg_array[11] <= 32'd11;  
      reg_array[12] <= 32'd12;  
      reg_array[13] <= 32'd13;  
      reg_array[14] <= 32'd14;  
      reg_array[15] <= 32'd15;   
		reg_array[16] <= 32'd16;  
      reg_array[17] <= 32'd17;  
      reg_array[18] <= 32'd18;  
      reg_array[19] <= 32'd19;  
      reg_array[20] <= 32'd20;  
      reg_array[21] <= 32'd21;  
      reg_array[22] <= 32'd22;  
      reg_array[23] <= 32'd23;       
      reg_array[24] <= 32'd24;  
      reg_array[25] <= 32'd25;  
      reg_array[26] <= 32'd26;  
      reg_array[27] <= 32'd27;  
      reg_array[28] <= 32'd28;  
      reg_array[29] <= 32'd29;  
      reg_array[30] <= 32'd30;  
      reg_array[31] <= 32'd31;   
    end  
    

    else begin  
      if(write_en) begin  
        if (rd) //skip if rd=0 since it's a special read-only register
          reg_array[rd] <= data_in;  
        else
          reg_array[rd] <= 32'd0;
      end  
    end  
    
  end  
  
  assign rs_data_out = reg_array[rs];  
  assign rt_data_out = reg_array[rt];  
  assign r15 = reg_array[15][7:0];  //creating a port to connect LSB of r15 to LEDs
endmodule   
