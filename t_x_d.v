//Design of 2*4 Decoder module 

//primitive or gate level 
module t_x_d(a,b,e,y);
  input a,b,e;
  output [3:0]y;
  wire w1,w2;
  not(w1,a);
  not(w2,b);
  and(y[0],w1,w2,e);
  and(y[1],w1,b,e);
  and(y[2],w2,a,e);
  and(y[3],a,b,e);
endmodule

//Dataflow 
module t_x_d(a,b,e,y);
  input a,b,e;
  output [3:0]y;
  assign y[0] = ~a & ~b & e;
  assign y[1] = ~a & b & e;
  assign y[2] = a & ~b & e;
  assign y[3] = a & b & e;
endmodule

//Procedural or behavioural
module t_x_d(a,b,e,y);
  input a,b,e;
  output reg [3:0]y;
  always@(*)
    begin
  y[0] = ~a & ~b & e;
  y[1] = ~a & b & e;
  y[2] = a & ~b & e;
  y[3] = a & b & e;
    end
endmodule 

//Testbench
module t_x_d_tst();
  reg a,b,e;
  wire [3:0]y;
  t_x_d u1(.a(a),.b(b),.e(e));
  initial 
    begin
      $monitor($time," a=%b b=%b y=%b e=%b",a,b,y,e);
      #5 a=1'b0; b=1'b0; e = 1'b0;
      #5 a=1'b0; b=1'b0; e = 1'b1;
      #5 a=1'b0; b=1'b1; e = 1'b0;
      #5 a=1'b0; b=1'b1; e = 1'b1;
      #5 a=1'b1; b=1'b0; e = 1'b0;
      #5 a=1'b1; b=1'b0; e = 1'b1;
      #5 a=1'b1; b=1'b1; e = 1'b0;
      #5 a=1'b1; b=1'b1; e = 1'b1;
      $stop;
    end
endmodule 