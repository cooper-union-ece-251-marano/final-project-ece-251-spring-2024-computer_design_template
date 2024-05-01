//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski and Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: adder
//     Description: simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////

// This circuit does not require reset because it is combinatorial logic

`ifndef ADDER
`define ADDER
`timescale 1ns/100ps

module adder # (parameter N = 16)
   //
   // ---------------- PORT DEFINITIONS ----------------
   (
     input [N-1:0] a, b, // a + b
     input enable, reset, cin, // cin = carry in
     output reg [N-1:0] S, // s = sum
     output reg Cout // Cout = carry out
   );
   // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
 always @ (a or b or cin) // trigger on a, b, or cin
    begin
      if (enable) // add if enabled
        begin
              {Cout, S} = a + b + cin;
                end
      else // if disabled, set sum and Cout to hi z
        begin
            S = 'bz;
            Cout = 'bz;
         end
    end
endmodule

`endif // ADDER