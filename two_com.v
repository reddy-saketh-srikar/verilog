
// Design of 2 bit comaprator 

//primitive or gate level
module two_com(a,b,p,q,r);
  input [1:0] a,b;   
  output p,q,r;     
  wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14;
  not (w1, a[1]);   
  not (w2, a[0]);   
  not (w3, b[1]);   
  not (w4, b[0]);   
  and (w5, a[1], w3);       
  and (w6, a[0], w4);       
  xnor(w7, a[1], b[1]);      
  and (w8, w7, w6);          
  or  (p, w5, w8);           
  and (w9, w1, b[1]);       
  and (w11, w7, w10);        
  or  (q, w9, w11);         
  xnor(w12, a[0], b[0]);     
  and (r, w7, w12);          
endmodule

//data flow
module two_com(a,b,p,q,r);
  input [1:0] a,b;   
  output p,q,r;
  assign p = a > b;
  assign q = a < b;
  assign r = a == b;
endmodule

//procedural or behavioural
module two_com(a,b,p,q,r);
  input [1:0] a,b;
  output reg p,q,r;
  always@(*)
    begin
      p = a < b;
      q= a > b;
      r = a == b;
    end
endmodule


//testbench

module two_com_tst();
  reg [1:0] a, b;
  wire p, q, r;
  two_com u(.a(a), .b(b), .p(p), .q(q), .r(r));
  initial begin
    $monitor($time, " a=%b b=%b | p(A>B)=%b q(A<B)=%b r(A==B)=%b", a, b, p, q, r);
    a = 2'b00; b = 2'b00; #5;
    a = 2'b00; b = 2'b01; #5;
    a = 2'b00; b = 2'b10; #5;
    a = 2'b00; b = 2'b11; #5;
    a = 2'b01; b = 2'b00; #5;
    a = 2'b01; b = 2'b01; #5;
    a = 2'b01; b = 2'b10; #5;
    a = 2'b01; b = 2'b11; #5;
    a = 2'b10; b = 2'b00; #5;
    a = 2'b10; b = 2'b01; #5;
    a = 2'b10; b = 2'b10; #5;
    a = 2'b10; b = 2'b11; #5;
    a = 2'b11; b = 2'b00; #5;
    a = 2'b11; b = 2'b01; #5;
    a = 2'b11; b = 2'b10; #5;
    a = 2'b11; b = 2'b11; #5;
    $stop;
  end
endmodule
