//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski and Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: tb_dff
//     Description: Test bench for 16 bit D flip flop
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./dff.sv"

module tb_dff;
    //
    // ---------------- DECLARATIONS OF PARAMETERS ----------------
    //
    parameter N = 16;
    //
    // ---------------- DECLARATIONS OF DATA TYPES ----------------
    //

     reg [15:0] d;
  reg clk, rst, en; //inputs are reg for test bench
  wire [15:0] q; //, qn;     //outputs are wire for test bench

   //
    //
    // ---------------- INITIALIZE TEST BENCH ----------------

initial
    begin
      d = 16'b0;
      rst = 0;
      en = 1;
      clk = 0;
    end

always #5 clk = ~clk;

   initial
   begin: apply_stimulus
    reg [7:0] invect; //invect[7] terminates the for loop
     for (int i = 0; i < 256; i = i + 1)
      begin
       invect = i;
        d = invect;


        #5 $display("clk=%b, rst=%b, en=%b, d=%b, q=%b", clk, rst, en, d, q);
      end
      $finish;
   end

   //
   // ---------------- INSTANTIATE UNIT UNDER TEST (UUT) ----------------
   //
  dff uut(.clk(clk), .en(en), .rst(rst), .d(d), .q(q));

endmodule