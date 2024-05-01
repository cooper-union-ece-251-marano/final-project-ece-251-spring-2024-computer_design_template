//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski and Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: tb_adder
//     Description: Test bench for simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./adder.sv"

module tb_adder;
  parameter N = 16;
  reg [15:0] a, b;   // adding 2 8bit numbers
  reg enable, cin;
  wire [15:0] S;
  wire Cout;


   //
   // ---------------- INITIALIZE TEST BENCH ----------------
   //
   initial
     begin
        $dumpfile("tb_example_module.vcd"); // for Makefile, make dump file same as module name
        $dumpvars(0, tb_adder);
     end

   //apply input vectors - can count up a, b, change cin, disable, etc
   initial
   begin: apply_stimulus

     reg[15:0] invect; //invect[7] terminates the for loop
     for (int i = 0; i < 256; i++)// just an example - goes up to 65536
      begin
        invect = i;
         a = invect; // a will increase during this test, but can be anything
         b = 8'b00000001; //b will be 1, but can be anything
         cin = 1'b1; //cin is set to be 1, but could also be 0
         enable = 1'b1; //circuit is enabled
         #10 $display("a=%b, b=%b, cin=%b, enable=%b, Cout=%b, S=%b", a, b, cin, enable, Cout, S);
        #10;
      end
      $finish;
   end

   //
   // ---------------- INSTANTIATE UNIT UNDER TEST (UUT) ----------------
   //
  adder #(.N(N)) uut(.a(a), .b(b), .cin(cin), .enable(enable), .S(S), .Cout(Cout));

endmodule