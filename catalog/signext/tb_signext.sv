//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski & Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: tb_signext
//     Description: Test bench for sign extender
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./signext.sv"

module tb_signext;

   reg enable;
   reg [7:0] in;  //inputs are reg for test bench
   wire [15:0] out;     //outputs are wire for test bench


   //
   // ---------------- INITIALIZE TEST BENCH ----------------
   //

initial
     begin
        $dumpfile("tb_signext.vcd"); // for Makefile, make dump file same as module name
        $dumpvars(0, uut);
      in = 8'b0;
      enable = 1'b1;
     end

   //apply input vectors
   initial
   begin: apply_stimulus
     reg[7:0] invect; //invect[7] terminates the for loop
     for (int i = 0; i < 256; i++)
      begin
        invect = i;
        in = invect;
     #10 $display("enable=%b, in=%b, out=%b", enable, in, out);
          end
   end
   //
   // ---------------- INSTANTIATE UNIT UNDER TEST (UUT) ----------------
   //
  signext uut(.enable(enable), .in(in), .out(out));

endmodule