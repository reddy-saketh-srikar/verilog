//Design of two_one mux

//primitive or Gate level
module t_o_mux(y,i,s);
  input [1:0]i;
  input s;
  output y;
  wire w1,w2,w3;
  not(w1,s);
  and(w2,i[0],w1);
  and(w3,i[1],s);
  or(y,w2,w3);
endmodule

//dataflow
module t_o_mux(y,i,s);
  input [1:0]i;
  input s;
  output y;
  assign y = (i[0] & (~s)) + (i[1] & s);
endmodule

//procedural or behvioural
module t_o_mux(y,i,s);
  input [1:0]i;
  input s;
  output reg y;
  always@(*)
    begin
  y = (i[0] & (~s)) + (i[1] & s);
    end
endmodule

//testbench
module t_o_mux_tst();
  reg [1:0]i;
  reg s;
  wire y;
  t_o_mux u(.i(i),.s(s),.y(y));
  initial
    begin
      $monitor($time," i=%b s=%b y=%b",i,s,y);
      #5 i=2'b00; s=1'b0;
      #5 i=2'b00; s=1'b1;
      #5 i=2'b01; s=1'b0;
      #5 i=2'b01; s=1'b1;
      #5 i=2'b10; s=1'b0;
      #5 i=2'b10; s=1'b1;
      #5 i=2'b11; s=1'b0;
      #5 i=2'b11; s=2'b1;
      $stop;
    end
endmodule