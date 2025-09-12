//Design code of Decimal to BCD 

//Primitive or gate level
module dec_bcd(a,y);
  input [9:0]y;
  output [3:0]a;
  or(a[3],y[8],y[9]);
  or(a[2],y[4],y[5],y[6],y[7]);
  or(a[1],y[2],y[3],y[6],y[7]);
  or(a[0],y[1],y[3],y[5],y[7],y[9]);
endmodule 

//DataFlow
module dec_bcd(a,y);
  input [9:0]y;
  output [3:0]a;
  assign a[3] = y[9] + y[8];
  assign a[2] = y[7] + y[6] + y[5] + y[4];
  assign a[1] = y[7] + y[6] + y[3] + y[2];
  assign a[0] = y[9] + y[7] + y[5] + y[3] + y[1];
endmodule

//behavioural or procedural 
module dec_bcd(a,y);
  input [9:0]y;
  output reg [3:0]a;
  always@(*)
    begin
  a[3] = y[9] + y[8];
  a[2] = y[7] + y[6] + y[5] + y[4];
  a[1] = y[7] + y[6] + y[3] + y[2];
  a[0] = y[9] + y[7] + y[5] + y[3] + y[1];
    end
endmodule

//testbench
module dec_bcd_tst();
  reg [9:0]y;
  wire [3:0]a;
  dec_bcd u(.y(y),.a(a));
  initial 
    begin
      $monitor($time," y=%b a=%b",y,a);
      #5 y=10'b00000000000;
      #5 y=10'b00000000001;
      #5 y=10'b00000000010;
      #5 y=10'b00000000100;
      #5 y=10'b00000001000;
      #5 y=10'b00000010000;
      #5 y=10'b00000100000;
      #5 y=10'b00001000000;
      #5 y=10'b00010000000;
      #5 y=10'b00100000000;
      #5 y=10'b01000000000;
      #5 y=10'b10000000000;
    end
endmodule