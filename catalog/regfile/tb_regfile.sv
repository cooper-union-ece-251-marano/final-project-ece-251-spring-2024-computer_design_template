//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski & Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: tb_regfile
//     Description: Test bench for simple behavorial register file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_REGFILE
`define TB_REGFILE

`timescale 1ns/100ps
`include "regfile.sv"

module tb_regfile;

    parameter DATA_WIDTH = 16;
    parameter ADDR_WIDTH = 5;

    logic clock;
    logic write_enable;
    logic [ADDR_WIDTH - 1:0] read_address1;
    logic [ADDR_WIDTH - 1:0] read_address2;
    logic [ADDR_WIDTH - 1:0] write_address;
    logic [DATA_WIDTH - 1:0] write_data;
    logic [DATA_WIDTH - 1:0] read_data1;
    logic [DATA_WIDTH - 1:0] read_data2;

    regfile #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clock(clock),
        .write_enable(write_enable),
        .read_address1(read_address1),
        .read_address2(read_address2),
        .write_address(write_address),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // clock w 10 ns period
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    // Test
    initial begin
        write_enable = 0;
        read_address1 = 0;
        read_address2 = 0;
        write_address = 0;
        write_data = 0;

        #10;

        // Test 1:
        //write data to address 3
        write_enable = 1;
        write_address = 5'd3;
        write_data = 16'hABCD;
        #10;

        //read data from address 3
        write_enable = 0;
        read_address1 = 5'd3;
        #10;

// check
        if (read_data1 != 16'hABCD) begin
          $display("Test failed");
        end
        else
        begin
          $display("Test Passed");
        end

        //Test 2:
        // write data to address 5
        write_enable = 1;
        write_address = 5'd5;
        write_data = 16'h1234;
        #10;

        // read data from address 5
        write_enable = 0;
        read_address2 = 5'd5;
        #10;

        if (read_data2 != 16'h1234)
          begin
            $display("Test Failed");
          end
        else
        begin
            $display("Test Passed");
        end

        //Test 3
        //write data to address 0 (should not change)
        write_enable = 1;
        write_address = 5'd0;
        write_data = 16'hFFFF;
        #10;

      //Read data from address 0 (should be 0)
        write_enable = 0;
        read_address1 = 5'd0;
        #10;

        if (read_data1 != 16'b0)
          begin
            $display("Test Failed");
          end
        else
          begin
            $display("Test Passed");
          end

        $finish;
    end

    initial begin
        $monitor("Time = %0t, read_data1 = %h, read_data2 = %h", $time, read_data1, read_data2);
    end
endmodule
`endif // TB_REGFILE