//Design of binary to gray code 

//primitrive or gate level
module b_g(g, b);
  input  [2:0] g; 
  output [2:0] b;  
  buf (b[2], g[2]);
  xor (b[1], g[2], g[1]);
  xor (b[0], g[2], g[1], g[0]);
endmodule

//Dataflow
module b_g(g, b);
  input [2:0] g;
  output [2:0] b;
  assign b[2] = g[2];
  assign b[1] = g[2] ^ g[1];
  assign b[0] = g[2] ^ g[1] ^ g[0];
endmodule

//procedural or behvioural
module b_g(g,b);
  input [2:0] g;
  output reg [2:0] b;
  always@(*)
    begin
    b[2] = g[2];
    b[1] = g[2] ^ g[1];
    b[0] = g[2] ^ g[1] ^ g[0];
    end
endmodule 

module b_g_tst();
  reg [2:0] g;    
  wire [2:0] b;   

  b_g u(.g(g), .b(b));

  initial begin
    $monitor($time, " g=%b b=%b", g, b);

    #5 g = 3'b000;
    #5 g = 3'b001;
    #5 g = 3'b010;
    #5 g = 3'b011;
    #5 g = 3'b100;
    #5 g = 3'b101;
    #5 g = 3'b110;
    #5 g = 3'b111;

    $stop;
  end
endmodule

      