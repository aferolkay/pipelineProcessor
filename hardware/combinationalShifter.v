
module combinationalShifter #(parameter W=8)
(
	input [W-1:0]	in_data,
	input [4:0]		shamt,
	input [1:0]		ctrl,
	output [W-1:0] out
);

	
	wire [W-1:0]	LSL = in_data << shamt,
		 			LSR = in_data >> shamt,
		 			ASR = $signed(in_data) >>> shamt;
		 		  //RR  = {in_data[shamt-1:0],in_data[W-1:shamt]};

	integer i;
	reg [W-1:0] RR;

	assign out = ctrl[1] ? (ctrl[0] ? RR : ASR) : (ctrl[0] ? LSR : LSL );


	always @(*) begin
	    if (shamt == 0) begin
	    	RR <= in_data;
	    end else begin
	      for (i = 0; i < W  ; i = i + 1) begin
	        if (i < W - shamt) begin
	          RR[i] <= in_data[i + shamt];
	        end else begin
	          RR[i] <= in_data[i - W + shamt];
	        end
	      end
	    end
	end



	
endmodule



/*
module combinationalShifter #(parameter W=8)
(
  input [W-1:0] in,
  input [5:0]  shamt,
  output reg [W-1:0] out
);

  integer i;
  
  always @(*) begin
    if (shamt == 0) begin
      out <= in;
    end else begin
      for (i = 0; i < W  ; i = i + 1) begin
        if (i < W - shamt) begin
          out[i] <= in[i + shamt];
        end else begin
          out[i] <= in[i - W + shamt];
        end
      end
    end
  end

endmodule

*/