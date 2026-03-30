module srl1_16 (
    input  wire [15:0] a,
    output wire [15:0] y
);
    assign y = {1'b0, a[15:1]};
endmodule