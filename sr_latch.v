//Design code of sr sr_latch

//primitive or gate level
module sr_latch(s,r,q);
  input s,r;
  output [1:0] q;
  nand(q[0],s,q[1]);
  nand(q[1],r,q[0]);
endmodule 

//Dataflow 
module sr_latch(s,r,q);
  input s,r;
  output [1:0]q;
  assign q[0] = ~(s & q[1]);
  assign q[1] = ~(r & q[0]);
endmodule

//behvioural or procedural
module sr_latch(s,r,q);
  input s,r;
  output reg [1:0]q;
  always@(*)
    begin
      q[0] = ~(s & q[1]);
      q[1] = ~(r & q[0]);
    end
endmodule

//TestBench
module sr_latch_tst();
  reg s,r;
  wire [1:0]q;
  sr_latch u(.s(s),.r(r),.q(q));
  initial 
    begin
      $monitor($time," s=%b r=%b q=%b",s,r,q);
      #5 s=1'b0; r=1'b0;
      #5 s=1'b0; r=1'b1;
      #5 s=1'b1; r=1'b0;
      #5 s=1'b1; r=1'b1;
    $stop;
    end
endmodule