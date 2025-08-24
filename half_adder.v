
//design code for half_adder

//primitive 
module ha(a, b, sum, ca);
  input a, b;
  output sum, ca;
  xor (sum, a, b);   
  and (ca, a, b);    
endmodule 

// dataflow 
module ha(a, b, sum, ca);
  input a,b;
  output sum,ca;
  assign sum = a^b;
  assign ca = a & b;
endmodule

//procedural level
module ha(a,b,sum,ca);
  input a,b;
  output reg sum,ca;
  always@(*)
    begin
      sum= a ^ b;
      ca = a & b;
    end
endmodule

//testbench

`timescale 1ns/1ps

module ha_tst();

 
  reg a, b;
  wire sum, ca;

 
  ha uut (
    .a(a),
    .b(b),
    .sum(sum),
    .ca(ca)
  );


  initial begin
    $monitor("T=%0t | a=%b b=%b | sum=%b ca=%b", $time, a, b, sum, ca);
  end


  initial begin
    a = 0; b = 0;  
    #5 a = 0; b = 1;
    #5 a = 1; b = 0;
    #5 a = 1; b = 1;
    #5 $stop;
  end

endmodule