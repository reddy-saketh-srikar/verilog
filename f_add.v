//Design of full adder using two 4:1 muxes 

module f_o_mux(y, s, i);
  input  [1:0] s;
  input  [3:0] i;
  output       y;

  assign y = ((~s[1]) & (~s[0]) & i[0]) | 
             ((~s[1]) &  s[0]   & i[1]) | 
             ( s[1]   & (~s[0]) & i[2]) | 
             ( s[1]   &  s[0]   & i[3]);
endmodule

module f_ad(sum, ca, a, b, cin);
  input  a, b, cin;
  output sum, ca;
  wire   w1;
  not (w1, a);
  f_o_mux u1 (
    .i({a, w1, w1, a}),  
    .s({cin, b}),        
    .y(sum)
  );

  f_o_mux u2 (
    .i({1'b1, a, a, 1'b0}), 
    .s({cin, b}),           
    .y(ca)
  );
endmodule

//Testbench
module f_ad_tst();
  reg a,b,cin;
  wire sum,ca;
  f_ad e1(.a(a),.b(b),.cin(cin),.sum(sum),.ca(ca));
  initial
    begin
      $monitor($time," sum=%b ca=%b",sum,ca);
      #5 a=1'b0; b=1'b0; cin=1'b0;
      #5 a=1'b0; b=1'b0; cin=1'b1;
      #5 a=1'b0; b=1'b1; cin=1'b0;
      #5 a=1'b0; b=1'b1; cin=1'b1;
      #5 a=1'b1; b=1'b0; cin=1'b0;
      #5 a=1'b1; b=1'b0; cin=1'b1;
      #5 a=1'b1; b=1'b1; cin=1'b0;
      #5 a=1'b1; b=1'b1; cin=1'b1;
      $stop;
    end
endmodule 