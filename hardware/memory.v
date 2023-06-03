
module memory#(BYTE_SIZE=4, ADDR_WIDTH=32)(
input clk,WE,
input [ADDR_WIDTH-1:0] ADDR,
input [(BYTE_SIZE*8)-1:0] WD,
output [(BYTE_SIZE*8)-1:0] RD 
);

reg [7:0] mem [515:0];

initial begin
	$readmemh("myProgram.hex",mem);
end
genvar i;
generate
	for (i = 0; i < BYTE_SIZE; i = i + 1) begin: read_generate
		assign RD[8*i+:8] = mem[ADDR+i];
	end
endgenerate	
integer k;

always @(posedge clk) begin
    if(WE == 1'b1) begin	
        for (k = 0; k < BYTE_SIZE; k = k + 1) begin
            mem[ADDR+k] <= WD[8*k+:8];
        end
    end
end

endmodule


/*
module memory #(parameter W=16)
(
	input[11:0]		address,
	input			wr_en,
	input			clk,
	input[W-1:0]	data,
	output[W-1:0]	out
);
	reg	[W-1:0] memory[4096];
	assign	out = memory[address];
	
	integer i;
	initial begin
		for(i = 0 ; i<4096 ; i=i+1)
			memory[i]<=0;
	end


	always @(posedge clk) begin
		
		if(wr_en)
			memory[address] <= data;
		
	end
endmodule
*/
