//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski & Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: tb_mux2
//     Description: Test bench for 2 to 1 multiplexer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

`include "./mux2.sv"

module tb_mux2;
   parameter N = 16;
   reg [N-1:0] a, b;
   reg sel, enable;   //inputs are reg for test bench
   wire [N-1:0] y;     //outputs are wire for test bench

   //
   // ---------------- INITIALIZE TEST BENCH ----------------
   //
   initial
     begin
        $dumpfile("tb_mux2.vcd"); // for Makefile, make dump file same as module name
        $dumpvars(0, uut);
     end

   //apply input vectors
   initial
   begin: apply_stimulus
   enable = 1'b1;
   a = 8'b00001111;
   b = 8'b11110000;
   sel = 1'b0;
   #20
   $display("a=%b, b=%b, sel=%b, enable=%b, y=%b", a, b, sel, enable, y);
   #20
   sel = 1'b1;
   #20
   $display("a=%b, b=%b, sel=%b, enable=%b, y=%b", a, b, sel, enable, y);
   end

   //
   // ---------------- INSTANTIATE UNIT UNDER TEST (UUT) ----------------
   //
   mux2 uut(.a(a), .b(b), .sel(sel), .enable(enable), .y(y));

endmodule