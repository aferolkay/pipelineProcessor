module constantValueGenerator #(parameter W=4 , VAL = 10)
(
	output	[W-1:0]	out
);
	assign out = VAL ;
endmodule