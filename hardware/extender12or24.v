module extender12or24
(
	input signed [23:0] data,
	input control,
	output reg signed [31:0] out
);
	reg signed shifted[23:0];



	always@(*) begin
		if(control) begin   //control=1, imm24 ASL2
			out <= { {8{data[23]}} ,data[21:0] , 2'b00 };
		end
		else begin          //control=0, imm12
			out <= { 20'b0000_0000_0000_0000_0000 ,data[11:0] };
		end
	end
endmodule
