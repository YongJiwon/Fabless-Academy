`timescale 1ns / 1ps

module FA_4bit(
    a_in,
    b_in,
    c_in,
    sum_out,
    c_out
);


//LSB 캐리는 0값을 넣어줘야함, 1을 넣는다는건 소숫점 올림을 한다는 이야기임

input  [3:0] a_in;
input [3:0] b_in;
input c_in;
output [3:0] sum_out;
output  c_out;
wire [2:0] w_c_out;


full_adder FA0(
    .a_in(a_in[0]),
    .b_in(b_in[0]),
    .c_in(c_in),
    .sum_out(sum_out[0]),
    .c_out(w_c_out[0])
);

full_adder FA1(
    .a_in(a_in[1]),
    .b_in(b_in[1]),
    .c_in(w_c_out[0]),
    .sum_out(sum_out[1]),
    .c_out(w_c_out[1])
);

full_adder FA2(
    .a_in(a_in[2]),
    .b_in(b_in[2]),
    .c_in(w_c_out[1]),
    .sum_out(sum_out[2]),
    .c_out(w_c_out[2])
);

full_adder FA3(
    .a_in(a_in[3]),
    .b_in(b_in[3]),
    .c_in(w_c_out[2]),
    .sum_out(sum_out[3]),
    .c_out(c_out)
);


    



endmodule
/*
module FA_4bit(
    a_in,
    b_in,
    sum_out,
    c_in,
    c_out

    );

*/