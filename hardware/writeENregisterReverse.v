module writeENregisterReverse #(parameter W=4)
(
	input			reset,
	input			wr_en,
	input[W-1:0]	data,
	input			clk,
	output[W-1:0]	out
);
	reg[W-1:0]	REGISTER;

	assign	out=REGISTER;

	initial begin
		REGISTER<=0;
	end

	always @(negedge clk) begin

		if(reset == 1)
			REGISTER <=0;
		else begin
			if(wr_en)
				REGISTER<=data;
		end
	end
endmodule
