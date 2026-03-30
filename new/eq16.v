module eq16 (
    input  wire [15:0] a,
    input  wire [15:0] b,
    output wire [15:0] y
);
    assign y = (a == b) ? 16'd1 : 16'd0;
endmodule