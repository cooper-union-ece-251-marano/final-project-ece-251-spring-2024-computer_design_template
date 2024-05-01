//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski & Siann Han
//
//     Create Date: 2024-05-28
//     Module Name: regfile
//     Description: 16-bit RISC register file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef REGFILE
`define REGFILE

`timescale 1ns/100ps

module regfile # (parameter DATA_WIDTH = 16, parameter ADDR_WIDTH = 5) (
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic clock,
    input logic write_enable,
    input logic [ADDR_WIDTH - 1:0] read_address1,
    input logic [ADDR_WIDTH - 1:0] read_address2,
    input logic [ADDR_WIDTH - 1:0] write_address,
    input logic [DATA_WIDTH - 1:0] write_data,
    output logic [DATA_WIDTH - 1:0] read_data1,
    output logic [DATA_WIDTH - 1:0] read_data2
    );
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    // internal reg array
    logic [DATA_WIDTH - 1:0] registers[(2 ** ADDR_WIDTH) - 1:0];

    // write op:
    // write data on the pos edge of the clock if write enable is high
    always @(posedge clock) begin
        if (write_enable) begin
            registers[write_address] <= write_data;
        end
    end

    // read op:
    // Combinational block for assigning read data outputs

  always_comb begin
    // default values of 0
    read_data1 = {DATA_WIDTH{1'b0}};
    read_data2 = {DATA_WIDTH{1'b0}};

    // assign read data based on read addresses
    if (read_address1 != 0) begin
        read_data1 = registers[read_address1];
    end

    if (read_address2 != 0) begin
        read_data2 = registers[read_address2];
    end
end

endmodule

`endif // REGFILE
<<<<<<< Updated upstream



        

    
=======
>>>>>>> Stashed changes
