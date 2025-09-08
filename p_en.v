
// Design code of the prority encoder

//primitive or gate level
module p_en(y,a,v);
  input [3:0]y;
  output [1:0]a;
  output v;
  wire w1,w2;
  not(w1,y[2]);
  and(w2,w1,y[1]);
  or(a[1],y[2],y[3]);
  or(a[0],w2,y[3]);
  or(v,y[0],y[1],y[2],y[3]);
endmodule 

//Dataflow
module p_en(y,a,v);
  input [3:0]y;
  output [1:0]a;
  output v;
  assign a[1] = y[3] | y[2];
  assign a[0] = y[3] | (~y[2] && y[1]);
  assign v = |y;
endmodule

//Behavioural or procedural 
module p_en(y, a, v);
  input [3:0] y;
  output reg [1:0] a; 
  output v;

  always @(*) begin
    a[1] = y[3] | y[2];
    a[0] = y[3] | (~y[2] && y[1]);
  end
endmodule
