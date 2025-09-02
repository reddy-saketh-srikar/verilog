//Design of 2-bit multiplier using HAlf adders

//primitive or gate level
module ha(a,b,s,c);
  input a,b;
  output s,c;
  xor(s,a,b);
  and(c,a,b);
endmodule 

module two_mul(A,B,P);
  input [1:0]A,B;
  output [3:0]P;
  wire w1,w2,w3,w4;
  and(w1,A[1],B[1]);
  and(w2,A[0],B[1]);
  and(w3,A[1],B[0]);
  and(P[0],A[0],B[0]);
  ha HA1(.s(P[1]),.c(w4),.a(w2),.b(w3));
  ha HA2(.s(P[2]),.c(P[3]),.a(w1),.b(w4));
endmodule


//Dataflow 
module two_mul(A,B,P);
  input [1:0]A,B;
  output [3:0]P;
  assign P=A*B;
endmodule


//procedural or behavioural
module two_mul(A,B,P);
  input [1:0]A,B;
  output reg [3:0]P;
  always@(*)
    begin
      P = A * B;
    end
endmodule

//Testbench
module two_mul_tst();
  reg [1:0] A, B;
  wire [3:0] P;

  
  two_mul uut (.A(A), .B(B), .P(P));

  initial begin
    $monitor($time, " A=%b  B=%b  | P=%b", A, B, P);

    A=2'b00; B=2'b00; #5;
    A=2'b00; B=2'b01; #5;
    A=2'b00; B=2'b10; #5;
    A=2'b00; B=2'b11; #5;

    A=2'b01; B=2'b00; #5;
    A=2'b01; B=2'b01; #5;
    A=2'b01; B=2'b10; #5;
    A=2'b01; B=2'b11; #5;

    A=2'b10; B=2'b00; #5;
    A=2'b10; B=2'b01; #5;
    A=2'b10; B=2'b10; #5;
    A=2'b10; B=2'b11; #5;

    A=2'b11; B=2'b00; #5;
    A=2'b11; B=2'b01; #5;
    A=2'b11; B=2'b10; #5;
    A=2'b11; B=2'b11; #5;

    $stop;
  end
endmodule
