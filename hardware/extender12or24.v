module extender12or24
(
	input signed [23:0] data,
	input [1:0] control,
	output reg signed [31:0] out
);
	reg signed shifted[23:0];

	always@(*) begin
		case(control)
			0:begin
				out <= { 24'b0000_0000_0000_0000_0000_0000 ,data[7:0] };
			end

			1:begin
				out <= { 20'b0000_0000_0000_0000_0000 ,data[11:0] };
			end

			2:begin
				out <= { {8{data[23]}} ,data[21:0] , 2'b00 };
			end
		endcase
	end
endmodule


