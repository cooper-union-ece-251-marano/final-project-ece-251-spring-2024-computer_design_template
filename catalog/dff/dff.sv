//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski and Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: dff
//     Description: 16 bit D flip flop
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DFF
`define DFF
`timescale 1ns/100ps

module dff # (parameter n = 16)
   //
   // ---------------- PORT DEFINITIONS ----------------
   //
   (input logic [n-1:0] d, input clk, rst, en, output logic [n-1:0] q);// output logic [n-1:0] qn);
   //
   // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
always @ (posedge clk, posedge rst) begin
      if (en)
         begin
             if (rst) // 0 on reset
                begin
                    q  = 0;
                    //qn = ~q;
                 end
             else // q follows d, posedge triggered
                 begin
                     q  <= d;
                    // qn <= ~d;
                 end
         end
              else
                  begin
                     assign q = 'bz;
                     //assign qn ='bz;
                  end
end
endmodule

`endif // DFF
