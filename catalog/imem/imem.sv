//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Siann Han and Isabel Zulawski
// 
//     Create Date: 2024--04-28
//     Module Name: imem
//     Description: 16-bit RISC memory (instruction "text" segment)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef IMEM
`define IMEM

`timescale 1ns/100ps

module imem
    #(parameter n = 16, parameter r = 6) (
    input  logic [(r-1):0] addr,
    output logic [(n-1):0] readdata
);

    // Declare RAM array with 16-bit width and 2^r locations
    logic [(n-1):0] RAM[0:(2**r-1)];

    initial begin
      // Ensure the file 'mult-prog_exe' contains only up to 4 hex digits per line
      $readmemh("mult-prog_exe", RAM);
    end

    // Assign the data at address 'addr' to 'readdata'
    assign readdata = RAM[addr]; // word aligned

endmodule

`endif // IMEM

