//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: dmem
//     Description: 32-bit RISC memory ("data" segment)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DMEM
`define DMEM

`timescale 1ns/100ps

module dmem
    #(parameter n = 16,  // Data width set for 16 bits
      parameter r = 9)  // Address width set for 512 memory locations (9 bits, not 10)
(
    input  logic clk, write_enable,
    input  logic [(n-1):0] addr, writedata,
    output logic [(n-1):0] readdata
);

    // Memory array
    logic [(n-1):0] RAM[0:(2**r-1)];

    // Data read operation, word aligned by ignoring the least significant bit
    assign readdata = RAM[addr[(r-1):1]];  // Adjusted for 16-bit word alignment
    
    // Initialize RAM value to 0
    integer i;  // Declaring the loop variable
    initial begin
        for (i = 0; i < 2**r; i = i + 1)  // Ensure the loop iterates over the correct range
            RAM[i] <= 16'd0;
    end

    // Write operation, word aligned
    always @(posedge clk)
        if (write_enable)
            RAM[addr[(r-1):1]] <= writedata;  // Adjusted for 16-bit word alignment

endmodule

`endif // DMEM
