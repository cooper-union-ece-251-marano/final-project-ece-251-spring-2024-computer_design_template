//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski & Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: tb_sl2
//     Description: Test bench for shift left by 2 (multiply by 4)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_SL2
`define TB_SL2

`timescale 1ns/100ps
`include "sl2.sv"

module tb_sl2;
    parameter n = 16;
    logic [(n-1):0] in, out;

    initial begin
        $dumpfile("sl2.vcd");
        $dumpvars(0, uut);
        $monitor("time=%0t \t in=%b out=%b", $realtime, in, out);
    end

    initial begin
        in <= #n'h0000000F;
    end

    sl2 uut(
        .in(in), .out(out)
    );
endmodule
`endif // TB_SL2
