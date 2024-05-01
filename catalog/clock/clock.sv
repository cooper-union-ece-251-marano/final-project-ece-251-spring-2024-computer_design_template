//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski & Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: clock
//     Description: Clock generator; duty cycle = 50%
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CLOCK
`define CLOCK
`timescale 1ns/1ns

module clock # (
        parameter period = 10
    )
    (
        input enable, reset,
        output logic clk = 0
    );
   //
   //
   // ---------------- PORT DEFINITIONS ----------------
   //
    localparam half_period = period/2; //50% duty cycle

   //
   // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
   //

   always begin
    #half_period;
    clk = ~clk; //toggle clock every half period
    if (reset) clk = 1'b0; //clock goes low on reset
    if (!enable) clk = 'bz; //clock goes hi z when disabled
  end

endmodule

`endif // CLOCK
