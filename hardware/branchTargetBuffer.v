module branchTargetBuffer(
	input reset, clk,
	input[31:0] PCIn,
	input[31:0] branchTargetIn,

	output[31:0] branchTargetOut,
	output hitFlag
);

reg [31:0] PC [2:0];
reg [31:0] BTA [2:0];
wire [2:0] match;

initial begin
	PC[2] <= 0;
	PC[1] <= 0;
	PC[0] <= 0;

	BTA[2] <= 0;
	BTA[1] <= 0;
	BTA[0] <= 0;
end

assign match[0] = (PC[0] == PCIn),
	   match[1] = (PC[1] == PCIn),
	   match[2] = (PC[2] == PCIn); 

assign branchTargetOut = match[0] ? BTA[0] :
						 (match[1] ? BTA[1] :
						 (match[2] ? BTA[2] : 0));

assign hitFlag = match[0] | match[1] | match[2] ; 

always@(posedge clk) begin
	if(reset) begin
		PC[2] <= 0;
		PC[1] <= 0;
		PC[0] <= 0;

		BTA[2] <= 0;
		BTA[1] <= 0;
		BTA[0] <= 0;
	end
	else if(match[1]) begin
			PC[1] <= PC[0] ;
			PC[0] <= PCIn ;

			BTA[1] <= BTA[0] ;
			BTA[0] <= branchTargetIn ;	
	end 
	else if(match[0]) begin
			PC[0] <= PCIn ;
			BTA[0] <= branchTargetIn ;	
	end else begin
			PC[1] <= PC[0] ;
			PC[2] <= PC[1] ;
			PC[0] <= PCIn ;

			BTA[1] <= BTA[0] ;
			BTA[2] <= BTA[1] ;
			BTA[0] <= branchTargetIn ;
	end
end
endmodule

