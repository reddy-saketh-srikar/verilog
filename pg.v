//DEsign of the parity generator 

//primitive or gate level
module pg(a,b);
  input [3:0]a;
  output b;
  wire w1,w2;
  xor(w1,a[0],a[1]);
  xor(w2,w1,a[2]);
  xor(b,w2,a[3]);
endmodule

//Dataflow 
module pg(a,b);
  input [3:0]a;
  output b;
  assign b= ^a;
endmodule

//procedural or behvioural
module pg(a,b);
  input [3:0]a;
  output reg b;
  always@(*)
    begin
      b = ^a;
    end
endmodule

//testbench
module pg_tst();
  reg [3:0]a;
  wire b;
  pg u(.a(a),.b(b));
  initial 
    begin
      $monitor($time,"a= %b b=%b",a,b);
      a = 4'b0000; #5;
      a = 4'b0001; #5;
      a = 4'b0011; #5;
      a = 4'b0101; #5;
      a = 4'b1111; #5;
      a = 4'b1010; #5;
      a = 4'b1101; #5;
      $stop;
    end
    endmodule