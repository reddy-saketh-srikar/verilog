//Design of naster slave using Jk flip flop

module m_s(q, qbar, j, k, clk, reset);
  input j, k, clk, reset;
  output reg q, qbar;

  always @(posedge clk or negedge reset) begin
    if (!reset)
      q <= 0;                 
    else begin
      case ({j,k})
        2'b00: q <= q;       
        2'b01: q <= 0;       
        2'b10: q <= 1;        
        2'b11: q <= ~q;       
      endcase
    end
  end

  always @(*) qbar = ~q;
endmodule


//Testbench
module m_s_tst();
  reg j, k, clk, reset;
  wire [1:0] q;

  m_s u1(.j(j), .k(k), .clk(clk), .reset(reset), .q(q));
  initial 
    begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $monitor($time, " clk=%b reset=%b j=%b k=%b q=%b qbar=%b", 
             clk, reset, j, k, q[0], q[1]);

    reset = 0; j = 0; k = 0;
    #10 reset = 1; 
    #10 j=0; k=0;   
    #10 j=0; k=1;   
    #10 j=1; k=1;  
    #20 $stop;
  end
endmodule
