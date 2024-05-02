//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: YOUR NAMES
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

    parameter w = 16;  	// width of adder
    reg [w - 1:0] a, b; // adder inputs
    reg c_in;           // carry in
    wire [w - 1:0] s;  	// output sum
    reg reset;        // enable

    //uut (unit under test)
    adder #(.w(w)) uut(
        .reset(reset),
        .a(a), 
        .b(b), 
        .c_in(c_in), 
        .s(s), 
        .c_out(c_out)
    );

    initial begin
        $dumpfile("tb_adder.vcd"); 
        $dumpvars(0, uut);         
        
        #10
        // let a = 101110110 and b = 101110110 s.t. sum should = 101110110
        a = 8'b10101010; 
        b = 8'b11001100;
        c_in = 0; 
        #10;

        //apply random values with carry in = 1 and carry in = 0
        a = $random; 
        b = $random; 
        c_in = 1; 
        #10;

        a = $random; 
        b = $random; 
        c_in = 0; 
        #10;
        
        reset = 1;
        #10;
        $finish;
    end

    // monitor the ouputs along with the time they occured
    initial begin
        $monitor("Time = %0t: a = %b, b = %b, c_in = %b -> s = %b, c_out = %b, reset = %b",
            $time, a, b, c_in, s, c_out, reset);
    end

endmodule
