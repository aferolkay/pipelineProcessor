module controlUnit
(
	input [1:0] op,
	input [5:0] funct, //INS[25:20]


	output regDataSrc,
	output PCSrc,
	output branch,
	output regWrite,
	output memWrite,
	output[1:0] resultSrc,
	output[3:0] ALUControl,
	output ALUSrc,
	output[1:0] flagWrite,
	output immSrc,
	output destinationSrc,
	output[1:0] regSrc	
);

assign 	regDataSrc	= (op == 2'b10) & funct[4],
		PCSrc 		= (op == 2'b00) & (funct == 6'b010010),
		branch 		= (op == 2'b10) & (funct[5]==1),
		regWrite 	= ((op == 2'b00)&(funct[5]==0)) |
				      ((op == 2'b01) & funct[0]) |
				   	  ((op == 2'b10) & funct[4]),
		memWrite		= (op == 2'b01) & ~funct[0],
		resultSrc[1]= PCSrc,
		resultSrc[0]= PCSrc | (op == 2'b01),
		ALUControl[3:0]= (op==2'b00) ? funct[4:1] : 4'b0100,
		ALUSrc		= ~(op==2'b00),
		flagWrite[1]= (op==2'b00)&(funct[0]==1'b1),
		flagWrite[0]= (op==2'b00)&(funct[0]==1'b1)&
						  ((funct[4:1]==2)|(funct[4:1]==4)|(funct[4:1]==10)),
		immSrc		= (op == 2'b10),
		destinationSrc=(op == 2'b10),
		regSrc[1]	= (op == 2'b10),
		regSrc[0]	= (op == 2'b01);



endmodule
