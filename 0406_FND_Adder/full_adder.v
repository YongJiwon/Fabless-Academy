`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/07 10:07:10
// Design Name: 
// Module Name: full_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder(
    a_in,
    b_in,
    c_in,
    c_out,
    sum_out
    );

input  a_in;
input  b_in;
input  c_in; //캐리 입력
output sum_out; //합 출력
output  c_out; //캐리 출력


wire sum_in;
wire sum_2; //HF0의 sum_out출력
wire w_c1;
wire w_c2;
//assign sum_out = (a_in^b_in)^c_in; //A^B^C
//assign c_out = (a_in & b_in)+ c_in & (a_in^b_in); // (AxB) + Cx(A^B)

//assign sum_out = (sum_in)^c_in; //A^B^C
//assign c_out = (a_in & b_in)+ c_in & sum_in; // (AxB) + Cx(A^B)


assign c_out   = w_c1 | w_c2;

half_adder HF0(
    .a_in(a_in),
    .b_in(b_in),
    .c_out(w_c1),
    .sum_out(sum_in)
);
assign sum_out = sum_2;

half_adder HF1(
    .a_in(sum_in),
    .b_in(c_in),
    .c_out(w_c2),
    .sum_out(sum_2)

);




endmodule
