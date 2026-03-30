module sll1_16 (
    input  wire [15:0] a,
    output wire [15:0] y
);
    assign y = {a[14:0], 1'b0};
endmodule