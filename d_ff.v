//d_ff design code 
module d_ff(q, d, clk);
  input d, clk;
  output reg [1:0] q;

  always @(posedge clk) begin
    q[0] <= d;
    q[1] <= ~d;
  end
endmodule

//Testbench
module d_ff_tst();
  reg d, clk;
  wire [1:0] q;

  d_ff u1(.d(d), .clk(clk), .q(q));

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    d = 0;   
    $monitor($time, " clk=%b d=%b q=%b qbar=%b", clk, d, q[0], q[1]);

    #5  d = 1'b0;
    #10 d = 1'b1;
    #10 d = 1'b0;
    #10 d = 1'b1;
    #10 $finish;
  end
endmodule
