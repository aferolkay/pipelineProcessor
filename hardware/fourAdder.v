module fourAdder #(parameter W=32)
(
	input [W-1:0] data,
	output reg [W-1:0] out
);
	always@(*) begin
		out <= data + 4 ;
	end
endmodule


