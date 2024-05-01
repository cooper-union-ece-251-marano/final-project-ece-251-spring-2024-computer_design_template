//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Siann Han and Isabel Zulawski
// 
//     Create Date: 2024-04-27
//     Module Name: dmem
//     Description: 16-bit RISC memory ("data" segment)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DMEM
`define DMEM

`timescale 1ns/100ps

module dmem
// n=bit length of register; r=bit length of addr to limit memory and not crash your verilog emulator
    #(parameter n = 16, parameter r = 6)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic clk, write_enable,
    input  logic [(n-1):0] addr, writedata,
    output logic [(n-1):0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [(n-1):0] RAM[0:(2**r-1)];

    assign readdata = {RAM[addr], RAM[addr + 1]};

    // Clock generation
    always @(posedge clk) begin
    if (write_enable) begin
        RAM[addr] <= writedata[15:8];    // High byte
        RAM[addr + 1] <= writedata[7:0]; // Low byte
    end
end

endmodule

`endif // DMEM
