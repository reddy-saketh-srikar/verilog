// bcd to seven segment code 

//primitve or gate level
module bcd(A,B,C,D, a,b,c,d,e,f,g);
  input A,B,C,D;
  output a,b,c,d,e,f,g;
  wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16,w17,w18,w19,w20,w21,w22;

  not(w1, A);
  not(w2, B);
  not(w3, C);
  not(w4, D);

  and(w5,  w1, w2, w3, D);    
  and(w6,  w1, B,  w3, w4);    
  and(w7,  A,  w2, C,  w4);    
  and(w8,  A,  B,  w3, D);    
  or(a, w5, w6, w7, w8);

  and(w9,  w1, B,  w3, D);     
  and(w10, w1, B,  C,  w4);    
  and(w11, A,  w2, C,  D);     
  and(w12, A,  B,  w3, w4);    
  or(b, w9, w10, w11, w12);

  and(w13, w1, w2, C,  w4);    
  and(w14, A,  w2, w3, w4);    
  and(w15, A,  w2, C,  D);    
  and(w16, A,  B,  w3, w4);    
  or(c, w13, w14, w15, w16);

  and(w17, w1, w2, w3, D);     // ~A~B~C D
  and(w18, w1, B,  w3, w4);    // ~A B~C~D
  and(w19, w1, B,  C,  D);     // ~A B C D
  and(w20, A,  w2, C,  w4);    // A~B C~D
  and(w21, A,  B,  C,  w4);    // A B C~D
  or(d, w17, w18, w19, w20, w21);

  and(w22, w1, w2, w3, D);     
  and(w5,  w1, w2, C,  D);     
  and(w6,  w1, B,  w3, w4);    
  or(e, w22, w5, w6);

  and(w7,  w1, w3, w4);        
  and(w8,  w1, B,  w3);       
  and(w9,  w1, B,  w4);       
  and(w10, A,  w2, w3);        
  or(f, w7, w8, w9, w10);

  and(w11, w1, w2, w3);        
  and(w12, w1, B,  C,  D);    
  and(w13, A,  w2, w3, w4);    
  and(w14, A,  w2, C,  w4);    
  or(g, w11, w12, w13, w14);

endmodule


//dataflow level
module bcd(A,B,C,D,a,b,c,d,e,f,g);
  input A,B,C,D;
  output a,b,c,d,e,f,g;
  assign a= ~(B & D) +C+B & D+A;
  assign b= ~B + ~(C & D)+C & D;
  assign c= ~C + D + B;
  assign d = ~(B & D) + ~B & C + B & ~C & D + C & ~D + A;
  assign e = ~(B & D) + C & ~D;
  assign f = ~(C & D) + B & ~C + B & ~D +A;
  assign g = ~B & C + B & ~C + A + B & D;
endmodule 


// procedural or behavioural
module bcd(A,B,C,D,a,b,c,d,e,f,g);
  input A,B,C,D;
  output reg a,b,c,d,e,f,g;
  always@(*)
    begin
        a= ~(B & D) +C+B & D+A;
        b= ~B + ~(C & D)+C & D;
        c= ~C + D + B;
        d = ~(B & D) + ~B & C + B & ~C & D + C & ~D + A;
        e = ~(B & D) + C & ~D;
        f = ~(C & D) + B & ~C + B & ~D +A;
        g = ~B & C + B & ~C + A + B & D;
    end
endmodule

//Testbench
`timescale 1ns/1ps

module bcd_tst();
  reg A,B,C,D;
  wire a,b,c,d,e,f,g;

 
  bcd u(.A(A), .B(B), .C(C), .D(D),
        .a(a), .b(b), .c(c), .d(d),
        .e(e), .f(f), .g(g));

  initial begin
   
    $display("Time | A B C D | a b c d e f g");
    $display("-------------------------------------");

    
    $monitor("%4t | %b %b %b %b | %b %b %b %b %b %b %b",
             $time, A,B,C,D, a,b,c,d,e,f,g);

    
    #5  A=0; B=0; C=0; D=0;   
    #5  A=0; B=0; C=0; D=1;   
    #5  A=0; B=0; C=1; D=0;   
    #5  A=0; B=0; C=1; D=1;   
    #5  A=0; B=1; C=0; D=0;   
    #5  A=0; B=1; C=0; D=1;  
    #5  A=0; B=1; C=1; D=0;   
    #5  A=0; B=1; C=1; D=1;   
    #5  A=1; B=0; C=0; D=0;   
    #5  A=1; B=0; C=0; D=1;  
    #5  A=1; B=0; C=1; D=0;   
    #5  A=1; B=0; C=1; D=1;   
    #5  A=1; B=1; C=0; D=0;   
    #5  A=1; B=1; C=0; D=1;   
    #5  A=1; B=1; C=1; D=0;   

    $stop;
  end
endmodule
