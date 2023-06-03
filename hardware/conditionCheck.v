module conditionCheck
(
	input[1:0] flagW,
	input[3:0] condition,
	input[3:0] ALUFlags,
	input clk,
	input reset,
	output reg condEx
);
	
    wire[3:0] flags;
	wire[1:0] flagWrite;
	wire PCSrc;
	assign 	flagWrite[0] = flagW[0] & condEx ,
			flagWrite[1] = flagW[1] & condEx ;

	
	writeENregister#(2) NZ(
		.reset(reset),
		.wr_en(flagWrite[1]),
		.data(ALUFlags[3:2]),
		.clk(clk),
		.out(flags[3:2])
		);
	writeENregister#(2) CV(
		.reset(reset),
		.wr_en(flagWrite[0]),
		.data(ALUFlags[1:0]),
		.clk(clk),
		.out(flags[1:0])
		);


	always@(*) begin
		case(condition)
			4'b0000: begin //EQ
				if( flags[2] == 1 )
					condEx = 1;
				else begin
					condEx = 0;
				end
			end
			4'b0001: begin //NE
				if( flags[2] == 0 )
					condEx = 1;
				else begin
					condEx = 0;
				end
			end
			4'b1110: begin //AL
				condEx = 1;
			end
			default: begin
				condEx = 1;
			end
		endcase
	end

endmodule
