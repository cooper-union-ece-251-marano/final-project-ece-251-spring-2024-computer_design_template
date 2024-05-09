///////////////////////////////////////////////////////////////////////////////
//
// Full Adder module
//
// Full adder module for your Computer Architecture Elements Catalog
//
// module: adder
// hdl: Verilog
//
// author: Kristof Jablonowski <kristof.jablonowski@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef ADDER
`define ADDER

module adder #(parameter w = 16)(  // adder width parameter
    input [w - 1:0] a,
    input [w - 1:0] b,
    output reg [w - 1:0] s
);
  
    logic [w:0] temp;

    always @ (*) begin
        temp = a + b;
        s = temp[w - 1:0];
    end

endmodule

`endif //_ADDER_SV
