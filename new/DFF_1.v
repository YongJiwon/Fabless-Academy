`timescale 1ns / 1ps

module DFF_1 (
    input clk,
    input rst_n,
    input [3:0] a,
    input [3:0] b,
    output reg [4:0] out
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        out <= 5'd0;
    else
        out <= a + b;
end

endmodule