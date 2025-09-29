//Design code of jk flipflop

module jk_ff(
    output reg [1:0] q,
    input j,
    input k,
    input clk
);

always @(posedge clk) 
  begin
    if (j == 0 && k == 0) 
      begin
        q[0] <= q[0];       
    end
    else if (j == 0 && k == 1) 
      begin
        q[0] <= 0;          
    end
    else if (j == 1 && k == 0) 
      begin
        q[0] <= 1;         
    end
    else 
      begin
        q[0] <= ~q[0];      
    end

    q[1] <= ~q[0];         
end

endmodule

//Testbench
module jk_ff_tst();
  reg j, k, clk;
  wire [1:0] q;


  jk_ff u1(.j(j), .k(k), .clk(clk), .q(q));

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
   
    j = 0; k = 0;

    $monitor($time, " j=%b k=%b q=%b qbar=%b", j, k, q[0], q[1]);

    #5 j=0; k=0;  
    #10 j=0; k=1;
    #10 j=1; k=0; 
    #10 j=1; k=1; 
    #10 $finish;  
  end
endmodule
