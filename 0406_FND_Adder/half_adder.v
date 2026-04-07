`timescale 1ns / 1ps



module half_adder(
    a_in,
    b_in,
    sum_out,
    c_out
);

input a_in;
input b_in;
output sum_out;
output c_out;

assign sum_out = a_in^b_in;
assign c_out = a_in & b_in;


endmodule
