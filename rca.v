// Design of the ripple carry rp_ca_adder

// primitive or gate level
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

module rp_ca_adder(A,B,Cin,C,S);
  input [3:0]A,B;
  input Cin;
  output [3:0]S,C;
  fa p1(.x(A[0]),.y(B[0]),.z(Cin),.u(S[0]),.v(C[0]));
  fa p2(.x(A[1]),.y(B[1]),.z(C[0]),.u(S[1]),.v(C[1]));
  fa p3(.x(A[2]),.y(B[2]),.z(C[1]),.u(S[2]),.v(C[2]));
  fa p4(.x(A[3]),.y(B[3]),.z(C[2]),.u(S[3]),.v(C[3]));
endmodule

//dataflow 
module rca(A, B, Cin, S, Cout);
  input  [3:0] A, B;
  input        Cin;
  output [3:0] S;
  output       Cout;
  wire C1, C2, C3;

  assign S[0] = A[0] ^ B[0] ^ Cin;
  assign C1   = (A[0] & B[0]) | (A[0] & Cin) | (B[0] & Cin);

  assign S[1] = A[1] ^ B[1] ^ C1;
  assign C2   = (A[1] & B[1]) | (A[1] & C1) | (B[1] & C1);
 
  assign S[2] = A[2] ^ B[2] ^ C2;
  assign C3   = (A[2] & B[2]) | (A[2] & C2) | (B[2] & C2);

  assign S[3] = A[3] ^ B[3] ^ C3;
  assign Cout = (A[3] & B[3]) | (A[3] & C3) | (B[3] & C3);
endmodule

//procedural or behvioural 
module rca(A, B, Cin, S, Cout);
  input  [3:0] A, B;
  input        Cin;
  output reg [3:0] S;
  output reg Cout;

  integer i;
  reg carry;  // internal carry

  always @(*) begin
    carry = Cin;   // start with input carry
    for (i = 0; i < 4; i = i + 1) begin
      S[i]   = A[i] ^ B[i] ^ carry;                 // sum
      carry  = (A[i] & B[i]) | (A[i] & carry) | (B[i] & carry); // next carry
    end
    Cout = carry;   // final carry out
  end

endmodule


//Testbench
module rpl_ca_adder_tst();
  reg [3:0]A,B;
  reg Cin;
  wire [3:0]S,C;
  rpl_ca_adder e1(.A(A),.B(B),.Cin(Cin),.S(S),.C(C));
  initial 
    begin
      $monitor($time,"A=%b B=%b Cin=%b S=%b C=%b",A,B,Cin,S,C);
      #5 A=1'b0; B=1'b0; Cin=1'b0; 
       #5 A=1'b0; B=1'b0; Cin=1'b1; 
       #5 A=1'b0; B=1'b1; Cin=1'b0; 
       #5 A=1'b0; B=1'b1; Cin=1'b1; 
       #5 A=1'b1; B=1'b0; Cin=1'b0; 
       #5 A=1'b1; B=1'b0; Cin=1'b1; 
       #5 A=1'b1; B=1'b1; Cin=1'b0; 
       #5 A=1'b1; B=1'b1; Cin=1'b1; 
      $stop;
    end
endmodule 