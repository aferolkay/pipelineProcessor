module mux4to1	#(parameter W=4)
(
	output 		[W-1:0] out,
	input 		[W-1:0] in0,in1,in2,in3,
	input 		[1:0] sel			
);	
	
	assign out = sel[1] ? (sel[0] ? in3 : in2) : (sel[0] ? in1 : in0 );
								
endmodule