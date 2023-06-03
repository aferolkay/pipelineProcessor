module ALU#(parameter W=8)
(
	input 		clk,
	input		[W-1:0] A,B,
	input		[3:0]	CTRL,
	input		carry,
	output		C, V, N, Z,
	output 	  	[W-1:0]	OUT
);
	wire addition, subtraction,arithmetic,oVrequisite,MSBcheck;
	reg	[W:0]	RESULT;

	assign subtraction	= (CTRL==2)|(CTRL==3)|(CTRL==6)|(CTRL==7),
		   addition		= (CTRL==4)|(CTRL==5),
		   arithmetic 	= subtraction|addition,
		   oVrequisite  = ~(CTRL[1]^A[W-1]^B[W-1]),
		   MSBcheck		= A[W-1]^OUT[W-1],
		   OUT 			= RESULT[W-1:0];

	assign V = arithmetic & oVrequisite & MSBcheck,
		   //C = RESULT[W] & arithmetic,
		   C = (A[W-1]~^B[W-1])&(OUT[W-1]^A[W-1])&arithmetic,
		   N = OUT[W-1] ,
		   Z = (OUT == 0);

	always@(*) begin
		case(CTRL)
			0:begin 	//AND
				RESULT <= A&B;
			end
			1:begin 	//EXOR
				RESULT <= A^B;
			end

			2:begin 	//SUB-AB
				RESULT <= A-B;
			end
			3:begin 	//SUB-BA
				RESULT <= B-A;
			end
			4:begin 	//ADD
				RESULT <= A+B;
			end
			5:begin 	//ADD CARRY
				RESULT <= A+B+carry;
			end
			6:begin 	//SUB-AB CARRY
				RESULT <= A-B+carry-1;
			end
			7:begin 	//SUB-BA CARRY
				RESULT <= B-A+carry-1;
			end
			10:begin 	//CMP-AB
				RESULT <= A-B;
			end
			12:begin 	//ORR
				RESULT <= A|B;
			end

			13:begin 	//MOVE
				RESULT <= B;
			end
			14:begin 	//BIT CLEAR
				RESULT <= A&~B;
			end
			15:begin 	//MOVE NOT
				RESULT <= ~B;			
			end
			
			default:begin //RESET
				RESULT <= 0;
			end
		endcase
	end
endmodule
