// design code of full subtractor 

//primitive or gate level
module fs(x,y,z,d,b);
  input x,y,z;
  output d,b;
  wire w1,w2,w3,w4,w5;
  xor(w1,x,y);
  xor(d,w1,z);
  not(w2,w1);
  and(w3,w2,z);
  not(w4,x);
  and(w5,w4,y);
  or(b,w3,w5);
endmodule
  
//data fow level
module fs(x,y,z,d,b);
  input x,y,z;
  output d,b;
  assign d= x ^ y ^ z;
  assign b = (~x & y) | ((~(x ^ y)) & z);
endmodule


//procedural
module fs(x,y,z,d,b);
  input x,y,z;
  output reg d,b;
  always@(*)
    begin
      d = x ^ y ^ z;
      b = (~x & y) | ((~(x ^ y)) & z);
    end
endmodule

//testbench

  `timescale 1ns/1ps

module fs_tst();
  reg x, y, z;
  wire d, b;

  fs u(.x(x), .y(y),.z(z),.d(d), .b(b));

  initial begin
    $monitor("Time=%0t | x=%b y=%b z=%b | d=%b b=%b", $time, x, y, z, d, b);
    x=1'b0; y=1'b0; z=1'b0; #5;
    x=1'b0; y=1'b0; z=1'b1; #5;
    x=1'b0; y=1'b1; z=1'b0; #5;
    x=1'b0; y=1'b1; z=1'b1; #5;
    x=1'b1; y=1'b0; z=1'b0; #5;
    x=1'b1; y=1'b0; z=1'b1; #5;
    x=1'b1; y=1'b1; z=1'b0; #5;
    x=1'b1; y=1'b1; z=1'b1; #5;
  end
endmodule


