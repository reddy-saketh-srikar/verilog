//Design code of the t latch

//primitive or gate level 
module t_la(q, t, clk);
  input  t, clk;
  output [1:0] q;   
  wire d, dbar, s, r;
  xor (d, t, q[0]);
  not (dbar, d);
  nand (s, d,    clk);
  nand (r, dbar, clk);
  nand (q[0], s, q[1]);
  nand (q[1], r, q[0]);
endmodule

//dataflow code 
module t_la (
  input  t, clk,
  output q, qbar
);
  wire q_next;

  assign q_next = (~clk & q) | (clk & (t ^ q));
  assign qbar   = ~q_next;
endmodule 

//procedural or behvioural
module t_la(q, t, clk);
  input t, clk;
  output reg [1:0] q;

  initial q = 2'b01;  

  always @(posedge clk or negedge clk) 
    begin
    if (clk) 
      begin
      if (t)
        q[0] <= ~q[0];
     
    end
    q[1] <= ~q[0];     
  end
endmodule


//Testbench
module t_la_tst();
  reg t, clk;
  wire q, qbar;

  t_la u1(.t(t), .clk(clk), .q(q), .qbar(qbar));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    t = 0;
    #12 t = 1;   
    #20 t = 0;   
    #20 t = 1;   
    #20 $stop;
  end

  initial begin
    $monitor($time, " clk=%b t=%b q=%b qbar=%b", clk, t, q, qbar);
  end
endmodule
