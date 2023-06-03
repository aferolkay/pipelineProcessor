module registerFile #(parameter W=16)
(
	input clk,
	input [3:0] 	source0,
	input [3:0] 	source1,
	input [3:0]		destination,
	input [W-1:0]	data,
	input [W-1:0]	R15,
	input 			wr_en,
	input 			reset,
	output[W-1:0]	output0,
	output[W-1:0]	output1
);

	genvar i;
	wire[15:0]	destinationDecoderOut,wr_enRegister;
	generate
		for(i=0 ; i<16 ; i=i+1) begin  : PREPARE_INDIVIDUAL_WR_EN
			assign wr_enRegister[i] = destinationDecoderOut[i] & wr_en;
		end
	endgenerate
	decoder4to16 destinationDecoder(
		.select(destination),
		.out(destinationDecoderOut)
		);

	//wire[W-1:0]	registerOutputBus[15:0];
	wire[15*W-1:0]	registerOutputBus;



	generate
		for(i=0 ; i<15 ; i=i+1) begin : INITIALIZE_REGISTERS
			writeENregisterReverse#(W)	RF(
				.reset(reset),
				.wr_en(wr_enRegister[i]),
				.data(data),
				.clk(clk),
				.out(registerOutputBus[i*W +: W])
			);			
		end
	endgenerate


	mux16to1#(W) mux0(
		.in({R15,registerOutputBus}),
		.sel(source0),
		.out(output0) 
	);
	
	mux16to1#(W) mux1(
		.in({R15,registerOutputBus}),
		.sel(source1),
		.out(output1) 
	);
	


endmodule









