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

module adder #(
    parameter WIDTH = 16  // Parameter for the width of the adder
)(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input Cin,
    output reg [WIDTH-1:0] Sum,
    output reg Cout,
    input EN,           // Enable signal
    input RST          // Reset signal
);

    // Internal carry and sum wires
    wire [WIDTH-1:0] internal_sum;
    wire [WIDTH-1:0] carry;

    // LSB Adder
    full_adder fa0 (
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),
        .Sum(internal_sum[0]),
        .Cout(carry[0])
    );

    // More adders for the rest of the bits
    genvar i;
    generate
        for (i = 1; i < WIDTH; i = i + 1) begin : full_adder_loop
            full_adder fa (
                .A(A[i]),
                .B(B[i]),
                .Cin(carry[i-1]),
                .Sum(internal_sum[i]),
                .Cout(carry[i])
            );
        end
    endgenerate

always @* begin  
    if (RST) begin
        Sum = 0;
        Cout = 0;
    end else if (!EN) begin
        Sum = {WIDTH{1'bz}};  // High impedance when not enabled
        Cout = 1'bz;
    end else begin
        Sum = internal_sum;
        Cout = carry[WIDTH-1];
    end
end

endmodule

module full_adder(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
);
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (A & Cin) | (B & Cin);
endmodule

`endif
