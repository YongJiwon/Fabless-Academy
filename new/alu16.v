module alu16 (
    input  wire [15:0] a,
    input  wire [15:0] b,
    input  wire [3:0]  op,
    output reg  [15:0] result,
    output wire        zero,
    output reg         carry_out
);
    wire [15:0] add_result;
    wire [15:0] sub_result;
    wire [15:0] and_result;
    wire [15:0] or_result;
    wire [15:0] xor_result;
    wire [15:0] not_result;
    wire [15:0] sll_result;
    wire [15:0] srl_result;
    wire [15:0] eq_result;

    wire add_cout;
    wire sub_cout;

    adder16 u_adder16 (
        .a   (a),
        .b   (b),
        .cin (1'b0),
        .sum (add_result),
        .cout(add_cout)
    );

    subtractor16 u_subtractor16 (
        .a    (a),
        .b    (b),
        .diff (sub_result),
        .cout (sub_cout)
    );

    and16 u_and16 (
        .a(a),
        .b(b),
        .y(and_result)
    );

    or16 u_or16 (
        .a(a),
        .b(b),
        .y(or_result)
    );

    xor16 u_xor16 (
        .a(a),
        .b(b),
        .y(xor_result)
    );

    not16 u_not16 (
        .a(a),
        .y(not_result)
    );

    sll1_16 u_sll1_16 (
        .a(a),
        .y(sll_result)
    );

    srl1_16 u_srl1_16 (
        .a(a),
        .y(srl_result)
    );

    eq16 u_eq16 (
        .a(a),
        .b(b),
        .y(eq_result)
    );

    always @(*) begin
        result    = 16'd0;
        carry_out = 1'b0;

        case (op)
            4'b0000: begin // ADD
                result    = add_result;
                carry_out = add_cout;
            end

            4'b0001: begin // SUB
                result    = sub_result;
                carry_out = sub_cout;
            end

            4'b0010: begin // AND
                result    = and_result;
                carry_out = 1'b0;
            end

            4'b0011: begin // OR
                result    = or_result;
                carry_out = 1'b0;
            end

            4'b0100: begin // XOR
                result    = xor_result;
                carry_out = 1'b0;
            end

            4'b0101: begin // NOT A
                result    = not_result;
                carry_out = 1'b0;
            end

            4'b0110: begin // SLL
                result    = sll_result;
                carry_out = a[15];
            end

            4'b0111: begin // SRL
                result    = srl_result;
                carry_out = a[0];
            end

            4'b1000: begin // EQ
                result    = eq_result;
                carry_out = 1'b0;
            end

            default: begin
                result    = 16'd0;
                carry_out = 1'b0;
            end
        endcase
    end

    assign zero = (result == 16'd0);

endmodule