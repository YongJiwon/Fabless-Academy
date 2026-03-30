module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);
    wire s1, c1, c2;

    assign s1   = a ^ b;
    assign c1   = a & b;
    assign sum  = s1 ^ cin;
    assign c2   = s1 & cin;
    assign cout = c1 | c2;
endmodule