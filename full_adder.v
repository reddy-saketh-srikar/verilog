
//design code of fulladder

//prmitive level
module fa(a, b, cin, sum, ca);
  input a, b, cin;
  output sum, ca;
  wire w1, w2, w3;
  xor x1(w1, a, b);
  xor x2(sum, w1, cin);
  and a1(w2, a, b);
  and a2(w3, b, cin);
  and a3(w4, a, cin);
  or  o1(ca, w2, w3, w4);
endmodule

//dataflow
module fa(a,b,cin,sum,ca);
  input a,b,cin;
  output sum,ca;
  assign sum = a ^ b ^ cin;
  assign ca = a & b & cin;
endmodule 

//procedural
module fa(a,b,cin,sum,ca);
  input a,b,cin;
  output reg sum,ca;
  always@(*)
    begin
      sum = a ^ b ^ cin;
      ca  = (a & b) | (b & cin) | (a & cin);
    end
endmodule


// testbench 

`timescale 1ns/1ps

module fa_tst;
  reg a, b, cin;       // Inputs to the FA
  wire sum, ca;        // Outputs from the FA

  // Instantiate the Full Adder module
  fa uut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .ca(ca)
  );

  initial begin
    $monitor("T=%0t | a=%b b=%b cin=%b | sum=%b ca=%b", $time, a, b, cin, sum, ca);
  end

  initial begin
    
    a=0; b=0; cin=0; #5;
    a=0; b=0; cin=1; #5;
    a=0; b=1; cin=0; #5;
    a=0; b=1; cin=1; #5;
    a=1; b=0; cin=0; #5;
    a=1; b=0; cin=1; #5;
    a=1; b=1; cin=0; #5;
    a=1; b=1; cin=1; #5;

    $stop;  
  end
endmodule
