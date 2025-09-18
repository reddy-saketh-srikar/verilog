
// Design of D latch

//primitive or gate level
module d_la(q,d,e);
  input d,e;
  output [1:0]q;
  wire w1,w2,w3;
  not(w1,d);
  and(w2,w1,e);
  and(w3,d,e);
  nor #1(q[0],w2,q[1]);
  nor #1(q[1],w3,q[0]);
endmodule


//Dataflow
module d_la(q,d,e);
  input d,e;
  output [1:0]q;
  assign q[0] = (e & d) | (~e & q[0]);
  assign q[1] = (e & ~d) | (~e & q[1]);
endmodule 

//procedural or behavioural
module d_la(q,d,e);
  input d,e;
  output reg [1:0]q;
  always@(*)
    begin
      q[0] = (e & d) | (~e & q[0]);
      q[1] = (e & ~d) | (~e & q[1]);
    end
endmodule 

//Testbench
module d_la_tst();
  reg d,e;
  wire [1:0]q;
  d_la u1(.d(d),.e(e),.q(q));
  initial
    begin
      $monitor($time," d=%b e=%b q=%b qbar=%b",d,e,q[0],q[1]);
      #5 d=1'b0; e=1'b0;
      #5 d=1'b0; e=1'b1;
      #5 d=1'b1; e=1'b0;
      #5 d=1'b1; e=1'b1;
      $stop;
    end
endmodule 
      
