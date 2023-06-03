module mux16to1 #(parameter W = 8) (
  input [16*W-1:0] in,
  input [3:0] sel,
  output [W-1:0] out
);

  assign out = (sel == 4'b0000) ? in[0*W +: W] :
               (sel == 4'b0001) ? in[1*W +: W] :
               (sel == 4'b0010) ? in[2*W +: W] :
               (sel == 4'b0011) ? in[3*W +: W] :
               (sel == 4'b0100) ? in[4*W +: W] :
               (sel == 4'b0101) ? in[5*W +: W] :
               (sel == 4'b0110) ? in[6*W +: W] :
               (sel == 4'b0111) ? in[7*W +: W] :
               (sel == 4'b1000) ? in[8*W +: W] :
               (sel == 4'b1001) ? in[9*W +: W] :
               (sel == 4'b1010) ? in[10*W +: W] :
               (sel == 4'b1011) ? in[11*W +: W] :
               (sel == 4'b1100) ? in[12*W +: W] :
               (sel == 4'b1101) ? in[13*W +: W] :
               (sel == 4'b1110) ? in[14*W +: W] :
               in[15*W +: W];

endmodule


/*
module mux16to1 #(parameter W = 8) (
  input [W-1:0] in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,
  input [3:0] sel,
  output [W-1:0] out
);

  assign out = (sel == 4'b0000) ? in0 :
               (sel == 4'b0001) ? in1 :
               (sel == 4'b0010) ? in2 :
               (sel == 4'b0011) ? in3 :
               (sel == 4'b0100) ? in4 :
               (sel == 4'b0101) ? in5 :
               (sel == 4'b0110) ? in6 :
               (sel == 4'b0111) ? in7 :
               (sel == 4'b1000) ? in8 :
               (sel == 4'b1001) ? in9 :
               (sel == 4'b1010) ? in10 :
               (sel == 4'b1011) ? in11 :
               (sel == 4'b1100) ? in12 :
               (sel == 4'b1101) ? in13 :
               (sel == 4'b1110) ? in14 :
               in15;

endmodule

car B = car A [6+:2];     // equivalent to car A[7:6]

*/