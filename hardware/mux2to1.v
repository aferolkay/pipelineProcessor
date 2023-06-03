module mux2to1	#(parameter W=4)
(
	output 		[W-1:0] out,
	input 		[W-1:0] in0,in1,
	input 		sel			
);	
	
	assign out = sel ? in1 : in0 ;
								
endmodule