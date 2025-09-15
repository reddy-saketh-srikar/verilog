//Design of jk latch

//primitive or gate level
module jk_la(k, q);
  input  [1:0] k;   
  output reg [1:0] q;

  always @(*) begin
    case (k)
      2'b00: q[0] = q[0];       
      2'b01: q[0] = 1'b0;      
      2'b10: q[0] = 1'b1;       
      2'b11: q[0] = ~q[0];      
    endcase
    q[1] = ~q[0];               
  end
endmodule

//Dataflow
module jk_la(k, q);
  input  [1:0] k;    
  output wire [1:0] q;
  wire s, r;

 
  assign s = k[1] & ~q[0];   
  assign r = k[0] &  q[0];  

  
  assign #1 q[0] = ~(r | q[1]);   
  assign #1 q[1] = ~(s | q[0]);   
endmodule

//behvioural or procedural
module jk_la(k, q);
  input [1:0] k;       // k[1]=J, k[0]=K
  output reg [1:0] q;  // q[0]=Q, q[1]=Qbar

  always @(*) begin
    case (k)
      2'b00: q[0] = q[0];      // Hold
      2'b01: q[0] = 1'b0;      // Reset
      2'b10: q[0] = 1'b1;      // Set
      2'b11: q[0] = ~q[0];     // Toggle
    endcase
    q[1] = ~q[0];              // Qbar
  end
endmodule

//testbench
module jk_la_tst();
  reg [1:0] k;      // k[1]=J, k[0]=K
  wire [1:0] q;     // q[0]=Q, q[1]=Qbar


  jk_la u1 (.k(k), .q(q));

  initial begin
    $monitor($time, " k=%b q=%b", k, q);

    #5 k = 2'b00;  
    #5 k = 2'b01; 
    #5 k = 2'b10;    
    #5 k = 2'b11;    
    #5 k = 2'b00;   
    #5 k = 2'b11;  
    #5 k = 2'b01;   
    #5 k = 2'b10;  

    $stop;        
  end
endmodule
