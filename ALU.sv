// Verilog code for ALU
module ALU(       
  input          [7:0]      aluop,     //function sel through opcode
  input          [31:0]     operand1,         //src1
  input          [31:0]     operand2,         //src2
  input 		 	[15:0]			imm16,    	//4-bit immediate unsigned value
  output bit   [31:0]     	out, 	 		//result
  output zero,	//zero flag=1 when output is zero
  output neg,   //negative flag=1 when output is negative
  output ovf);  //overflow flag=1 when add/sub output overflows
  
  wire [31:0] imm16_to32;
  assign imm16_to32 = {{16{1'b0}}, imm16}; //sign extend unsigned value
  
  always_comb 
    begin   
      case(aluop)
		//R-type instructions
        8'b00010000: out = operand1 + operand2; // add
        8'b00010001: out = operand1 - operand2; // sub
        8'b00010010: out = operand1 | operand2; // or
        8'b00010011: out = operand1 & operand2; // and
        
        //S-type instructions
        8'b00100001: out = operand1 <<< imm16;	//arithmetic Shl by imm4 bits
        8'b00100010: out = operand1 >>> imm16;	//arithmetic Shr by imm4 bits
        8'b00100011: out = {operand1[30:0], operand1[31]};	//Rol
        8'b00100100: out = {operand1[0], operand1[31:1]};	//Ror  
        8'b00100101: out = ~operand1;			//bitwise not  
        8'b00100110: out = operand1 + imm16_to32;
		  8'b00100111: out = operand1;
        //B-type instructions
        // perform subtraction only. out is ignored. update flags below
        8'b00110001: out = operand1 - operand2;	//beq
		  8'b00110010: out = operand1 - operand2;	//blt
        8'b00110011: out = operand1 - operand2;	//bgt
          
        //L-type instructions
        // Calculate operand1 + imm4, to be used as the destination address 
        // for load and store
        8'b01000001: out = operand1 + imm16_to32;
        8'b01000010: out = operand1 + imm16_to32;
        
		  //J-type instructions
		 // 8'b01010001: out = 
        default: out = operand1 + operand2;  // default to add. out will be ignored
      endcase  
		
    end  
  assign zero = (out == 32'd0) ? 1'b1 : 1'b0; //zero flag
  assign neg = (out[31] == 1'b1) ? 1'b1 : 1'b0; //negative flag
  assign ovf = (aluop == 8'b00000000 && ((operand1[31] && operand2[31] && !out[31]) || (!operand1[31] && !operand2[31] && out[31]))) 
				 || (aluop == 8'b00000001 && ((!operand1[31] && operand2[31] && out[31]) || (operand1[31] && !operand2[31] && !out[31])));
endmodule  
