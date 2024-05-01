//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Isabel Zulawski & Siann Han
// 
//     Create Date: 2024-05-28
//     Module Name: mux2
//     Description: 2 to 1 multiplexer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef MUX2
`define MUX2

module mux2 # (parameter N = 16)
   //
   // ---------------- PORT DEFINITIONS ----------------
   //
   (
      input [15:0] a, b,
      input sel, enable, // y=a if sel=0; y=b if sel=1
      output reg [15:0] y,
      output reg [15:0] temp
   );
   //
   // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
   //
always @(*) begin
    if(enable) begin
      if (sel == 1'b0)
        begin
          temp = a;
        end
      else
        begin
          temp = b;
        end
    y = temp;
    end
    else y = 'bz;
end

endmodule

`endif // MUX2
