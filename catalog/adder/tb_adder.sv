//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Aidan Cusa & Kristof Jablonowski
// 
//     Create Date: 2023-02-07
//     Module Name: tb_adder
//     Description: Test bench for simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module tb_adder;

    parameter WIDTH = 16;  // Parameter for the width of the adder
    reg [WIDTH-1:0] A, B;  // Inputs are reg for the testbench
    reg Cin;               // Carry-in for the testbench
    wire [WIDTH-1:0] Sum;  // Output Sum is wire for the testbench
    wire Cout;             // Carry-out for the testbench
    reg EN;                // Enable signal for the testbench
    reg RST;               // Reset signal for the testbench

    // Instantiate the Unit Under Test (UUT)
    adder #(.WIDTH(WIDTH)) uut(
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .Sum(Sum), 
        .Cout(Cout),
        .EN(EN),      // Connect EN signal
        .RST(RST)     // Connect RST signal
    );

    // Initialize testbench
    initial begin
        $dumpfile("tb_adder.vcd"); 
        $dumpvars(0, tb_adder);         
        
        // Initialize signals
        A = 0; B = 0; Cin = 0; EN = 0; RST = 1; #10;
        RST = 0; EN = 1; // Release reset and enable the adder
        
        // Apply random inputs
        A = $random; B = $random; Cin = 0; #10;
        A = $random; B = $random; Cin = 1; #10;
        A = $random; B = $random; Cin = 0; #10;
        A = $random; B = $random; Cin = 1; #10;
        
        // Finish simulation
        $finish;
    end

    // Monitoring
    initial begin
        $monitor("Time = %0t: A = %b, B = %b, Cin = %b, EN = %b, RST = %b -> Sum = %b, Cout = %b",
                  $time, A, B, Cin, EN, RST, Sum, Cout);
    end

endmodule
