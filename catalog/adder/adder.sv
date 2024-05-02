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
    input c_in,
    input reset,
    output reg [w - 1:0] s,
    output reg c_out
);
  
    always @ (*) begin
        if(reset) begin
            c_out = 'b0;
            s = 'b0;
        end
        else begin
            {c_out, s} = a + b + c_in;
        end
    end

endmodule

`endif //_ADDER_SV
