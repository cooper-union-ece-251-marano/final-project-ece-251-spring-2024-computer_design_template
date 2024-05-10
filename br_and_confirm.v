module br_and_confirm(br, confirm, pc_sel);
    input br;
    input confirm;
    output reg pc_sel;

    always@(*)
    begin
        pc_sel = br & confirm;
    end
endmodule

