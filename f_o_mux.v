// Design of four_one mux

//primitive or gate level
module f_o_mux(y,s,i);
  input [1:0]s;
  input [3:0]i;
  output y;
  wire w1,w2,w3,w4,w5,w6;
  not(w1,s[0]);
  not(w2,s[1]);
  and(w3,i[0],w1,w2);
  and(w4,s[0],w2,i[1]);
  and(w5,w1,s[1],i[2]);
  and(w6,s[0],s[1],i[3]);
  or(y,w3,w4,w5,w6);
endmodule

//Dataflow 
module f_o_mux(y,s,i);
  input [1:0]s;
  input [3:0]i;
  output y;
  assign y = ((~s[1]) & (~s[0]) & i[0]) | 
             ((~s[1]) &  s[0]   & i[1]) | 
             ( s[1]   & (~s[0]) & i[2]) | 
             ( s[1]   &  s[0]   & i[3]);
endmodule

//procedural  or behavioural
module f_o_mux(y,s,i);
  input [1:0]s;
  input [3:0]i;
  output reg y;
  always@(*)
    begin
  y = ((~s[1]) & (~s[0]) & i[0]) | 
             ((~s[1]) &  s[0]   & i[1]) | 
             ( s[1]   & (~s[0]) & i[2]) | 
             ( s[1]   &  s[0]   & i[3]);
    end
endmodule

//Testbench
module f_o_mux_tst();
  reg [1:0]s;
  reg [3:0]i;
  wire y;
  f_o_mux u(.s(s),.i(i),.y(y));
  initial
    begin
      $monitor($time," i=%b y=%b s=%b",i,s,y);
      #5 i=4'b0000; s=2'b00;
      #5 i=4'b0001; s=2'b01;
      #5 i=4'b0010; s=2'b10;
      #5 i=4'b0110; s=2'b11;
      #5 i=4'b0100; s=2'b00;
      #5 i=4'b0101; s=2'b01;
      #5 i=4'b0110; s=2'b10;
      #5 i=4'b0111; s=2'b11;
      #5 i=4'b1000; s=2'b00;
      #5 i=4'b1001; s=2'b01;
      #5 i=4'b1010; s=2'b10;
      #5 i=4'b1011; s=2'b11;
      #5 i=4'b1100; s=2'b00;
      #5 i=4'b1101; s=2'b01;
      #5 i=4'b1110; s=2'b10;
      #5 i=4'b1111; s=2'b11;
      $stop;
    end
endmodule