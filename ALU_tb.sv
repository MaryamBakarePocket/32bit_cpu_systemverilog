module ALU_tb;

 reg          [7:0]      aluop;     //function sel through opcode
  reg          [31:0]     operand1;         //src1
  reg          [31:0]     operand2;         //src2
  reg 		 	[15:0]			imm16;    	//4-bit immediate unsigned value
  wire   [31:0]     	out; 	 		//result
  wire zero;	//zero flag=1 when output is zero
  wire neg;   //negative flag=1 when output is negative
  wire ovf;
  
	ALU alu32(
		.aluop(aluop),
		.operand1(operand1),
		.operand2(operand2),
		.imm16(imm16),
		.out(out),
		.zero(zero),
		.neg(neg),
		.ovf(ovf)
		
);
initial begin
aluop = 8'b00010000;		//addition operation
	operand1 = 32'd12;
       operand2 = 32'd32;
		
		aluop = 8'b00010001;		//subtraction operation
	operand1 = 32'd12;
       operand2 = 32'd32;
     
	  //and so on for different cases of aluop
	#300
	
	$stop;
	end
	
	initial begin
	$monitor ("Time = %0t, input_operand1 = %b, input_operand2 = %b, alu_out = %b", $time, operand1, operand2, out);
	end
	
	endmodule
	
