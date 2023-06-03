module decoder4to16
(
	input [3:0] select,
	output reg[15:0] out
);

	integer i;

	always @*
	begin
	  out = 16'b0; // initialize output to all zeros

	  for (i = 0; i < 16; i = i + 1)
	  begin
	    if (select == i)
	      out[i] = 1'b1;
	  end
	end

endmodule