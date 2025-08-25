
// design code of half_subtractor

//primitive or gate level
module hs(x,y,d,b);
  input x,y;
  output d,b;
  wire n;
  xor(d,x,y);
  not(n,x);
  and(b,n,y);
endmodule
  
// dataflow
module hs(x,y,d,b);
  input x,y;
  output d,b;
  assign d = x ^ y;
  assign b= ~x & y;
endmodule 

//procedural
module hs(x,y,d,b);
  input x,y;
  output reg d,b;
  always@(*)
    begin
       d = x ^ y;
       b= ~x & y;
    end
endmodule

//testbench
`timescale 1ns/1ps
​
module hs_tst();
  reg x, y;
  wire d, b;
​
  hs u(.x(x), .y(y), .d(d), .b(b));
​
  initial begin
    $monitor("Time=%0t | x=%b y=%b | d=%b b=%b", $time, x, y, d, b);
    x=1'b0; y=1'b0; #5;
    x=1'b0; y=1'b1; #5;
    x=1'b1; y=1'b0; #5;
    x=1'b1; y=1'b1; #5;
    $finish;  
  end
endmodule