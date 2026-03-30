module subtractor16 (
    input  wire [15:0] a,
    input  wire [15:0] b,
    output wire [15:0] diff,
    output wire        cout
);
    wire [15:0] b_comp;

    assign b_comp = ~b;

    adder16 u_adder16_sub (
        .a   (a),
        .b   (b_comp),
        .cin (1'b1),
        .sum (diff),
        .cout(cout)
    );
endmodule