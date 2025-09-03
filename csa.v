//Design of Carry save Adder in gate level

module ha(a,b,s,c);
  input a,b;
  output s,c;
  xor(s,a,b);
  and(c,a,b);
endmodule 

module fa(x,y,z,u,v);
  input x,y,z;
  output u,v;
  wire w1,w2,w3;
  ha o1(.a(x),.b(y),.s(w1),.c(w2));
  ha o2(.a(w1),.b(z),.s(u),.c(w3));
  or(v,w2,w3);
endmodule 


module rp_ca_adder(A,B,Cin,S,Cout);
  input [3:0]A,B;
  input Cin;
  output [3:0]S;
  output Cout;
  wire [3:0]C;

  fa l1(.x(A[0]),.y(B[0]),.z(Cin), .u(S[0]),.v(C[0]));
  fa l2(.x(A[1]),.y(B[1]),.z(C[0]),.u(S[1]),.v(C[1]));
  fa l3(.x(A[2]),.y(B[2]),.z(C[1]),.u(S[2]),.v(C[2]));
  fa l4(.x(A[3]),.y(B[3]),.z(C[2]),.u(S[3]),.v(C[3]));
  assign Cout = C[3];
endmodule

module cla(p,q,r,ad,ca);
  input [3:0]p,q,r;
  output [3:0]ad,ca;

  fa t1(.x(p[0]),.y(q[0]),.z(r[0]),.u(ad[0]),.v(ca[0]));
  fa t2(.x(p[1]),.y(q[1]),.z(r[1]),.u(ad[1]),.v(ca[1]));
  fa t3(.x(p[2]),.y(q[2]),.z(r[2]),.u(ad[2]),.v(ca[2]));
  fa t4(.x(p[3]),.y(q[3]),.z(r[3]),.u(ad[3]),.v(ca[3]));
endmodule

//its Testbench
`timescale 1ns/1ps
module tb_three_input_adder;

  reg  [3:0] p,q,r;
  wire [3:0] ad,ca;
  wire [3:0] Sum;
  wire Cout;

  cla uut_csa(.p(p),.q(q),.r(r),.ad(ad),.ca(ca));
  rp_ca_adder uut_rca(.A(ad),.B(ca),.Cin(0),.S(Sum),.Cout(Cout));

  initial begin
    $monitor("time=%0t p=%b q=%b r=%b | Sum=%b Cout=%b", 
              $time, p,q,r, Sum,Cout);

    p=4'b0000; q=4'b0000; r=4'b0000; #10;
    p=4'b0001; q=4'b0001; r=4'b0001; #10;
    p=4'b0011; q=4'b0101; r=4'b0001; #10;
    p=4'b1111; q=4'b0001; r=4'b0010; #10;
    p=4'b1010; q=4'b1010; r=4'b1010; #10;
    p=4'b1111; q=4'b1111; r=4'b1111; #10;

    $finish;
  end

endmodule


// Dataflow Design

module csa_3input (
  input  [3:0] p, q, r,
  output [3:0] sum,
  output [3:0] carry
);

  // Dataflow: bitwise equations
  assign sum   = p ^ q ^ r;                    
  assign carry = (p & q) | (q & r) | (r & p);  

endmodule

//Testbench

`timescale 1ns/1ps
module tb_three_input_adder;

  reg  [3:0] p,q,r;
  wire [3:0] ad,ca;
  wire [3:0] Sum;
  wire Cout;

  cla uut_csa(.p(p),.q(q),.r(r),.ad(ad),.ca(ca));
  rp_ca_adder uut_rca(.A(ad),.B(ca),.Cin(0),.S(Sum),.Cout(Cout));

  initial begin
    $monitor("time=%0t p=%b q=%b r=%b | Sum=%b Cout=%b", 
              $time, p,q,r, Sum,Cout);

    p=4'b0000; q=4'b0000; r=4'b0000; #10;
    p=4'b0001; q=4'b0001; r=4'b0001; #10;
    p=4'b0011; q=4'b0101; r=4'b0001; #10;
    p=4'b1111; q=4'b0001; r=4'b0010; #10;
    p=4'b1010; q=4'b1010; r=4'b1010; #10;
    p=4'b1111; q=4'b1111; r=4'b1111; #10;

    $finish;
  end

endmodule

//procedural or behvioural

module csa (
  input  [3:0] p, q, r,
  output reg [3:0] sum,
  output reg [3:0] carry
);
  always @(*) begin
    sum   = p ^ q ^ r;
    carry = (p & q) | (q & r) | (r & p);
  end
endmodule

//Testbench as for dataflow 
