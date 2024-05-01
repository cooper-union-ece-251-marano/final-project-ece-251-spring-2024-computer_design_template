//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski & Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: signext
//     Description: 8 to 16 bit sign extender
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
//doesnt need reset because its combinatorial

`ifndef SIGNEXT
`define SIGNEXT
`timescale 1ns/100ps

module signext # (
  parameter InputWidth  = 8, //input is an 8b number
  parameter OutputWidth = 16 //output is a 16b number
)
   //
   // ---------------- PORT DEFINITIONS ----------------
   //
(
  input  logic signed [InputWidth-1:0]  in,
  input enable,
  output logic signed [OutputWidth-1:0] out
);

   //
   // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
   //
 always @(*) begin
  if(enable)
    assign out = {{OutputWidth-InputWidth{in[InputWidth-1]}}, in }; //extends with sign
  else
    out = 'bz;
end
endmodule

`endif // SIGNEXT