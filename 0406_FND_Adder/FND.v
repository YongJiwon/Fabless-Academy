/*
1자리 전용 0~9까지

`timescale 1ns / 1ps


module FND (
    input  wire [3:0] buttons_a,
    input  wire [3:0] buttons_b,
    output reg  [7:0] segment_display,
    output reg  [3:0]digit_enable,
    output wire c_out_seg
);
wire [3:0]data;
always @(*) begin
    // 첫 번째 자리만 ON (active-high)
    digit_enable = 4'b1111;

    case (data)

        5'd0: segment_display = 8'b1100_0000; // 0 
        5'd1: segment_display = 8'b1111_1001; // 1 
        5'd2: segment_display = 8'b1010_0100; // 2  O
        5'd3: segment_display = 8'b1011_0000; // 3 O
        5'd4: segment_display = 8'b1001_1001; // 4
        5'd5: segment_display = 8'b1001_0010; // 5
        5'd6: segment_display = 8'b1000_0010; // 6
        5'd7: segment_display = 8'b1111_1000; // 7
        5'd8: segment_display = 8'b1000_0000; // 8
        5'd9: segment_display = 8'b1001_0000; // 9
        default: segment_display = 8'b0000_0000; // blank
    endcase
end

FA_4bit FA_fnd(
    .a_in(buttons_a),
    .b_in(buttons_b),
    .c_in(1'b0),
    .sum_out(data),
    .c_out(c_out_seg)
);


endmodule

*/

//hex Display FND  /개별 자리 동작
`timescale 1ns / 1ps

module FND (
    input  wire       clk,
    input  wire       rst,
    input  wire [3:0] buttons_a,
    input  wire [3:0] buttons_b,
    output reg  [7:0] segment_display,
    output reg  [3:0] digit_enable,
    output wire       c_out_seg
);

wire [3:0] data;

// 스캔용
reg [15:0] clk_div;
reg [1:0]  scan_sel;
reg [3:0]  current_digit;

// 원래 구조 유지: 내부에서 4비트 가산기 수행
FA_4bit FA_fnd(
    .a_in(buttons_a),
    .b_in(buttons_b),
    .c_in(1'b0),
    .sum_out(data),
    .c_out(c_out_seg)
);

// 분주 카운터
always @(posedge clk or posedge rst) begin
    if (rst)
        clk_div <= 16'd0;
    else
        clk_div <= clk_div + 16'd1;
end

// 자리 선택 카운터
always @(posedge clk_div[15] or posedge rst) begin
    if (rst)
        scan_sel <= 2'b00;
    else
        scan_sel <= scan_sel + 2'b01;
end

// 어느 자리를 켤지 선택
always @(*) begin
    case (scan_sel)
        2'b00: begin
            digit_enable = 4'b1110;   // 1번째 자리 ON (active-low)
            current_digit = data;     // 합 표시
        end
        2'b01: begin
            digit_enable = 4'b1101;   // 2번째 자리 ON
            current_digit = {3'b000, c_out_seg}; // carry 표시
        end
        2'b10: begin
            digit_enable = 4'b1011;   // 3번째 자리 ON
            current_digit = 4'd0;
        end
        2'b11: begin
            digit_enable = 4'b0111;   // 4번째 자리 ON
            current_digit = 4'd0;
        end
        default: begin
            digit_enable = 4'b1111;
            current_digit = 4'd0;
        end
    endcase
end

// 숫자 표시 (active-low)
always @(*) begin
    case (current_digit) //alwayws문에서만 case사용가능
        4'd0:  segment_display = 8'b1100_0000; // 0   => 8'hC0
        4'd1:  segment_display = 8'b1111_1001; // 1  => 8'hF9
        4'd2:  segment_display = 8'b1010_0100; // 2  => 8'hA4
        4'd3:  segment_display = 8'b1011_0000; // 3  => 8'hB0
        4'd4:  segment_display = 8'b1001_1001; // 4  => 8'h99
        4'd5:  segment_display = 8'b1001_0010; // 5  => 8'h92
        4'd6:  segment_display = 8'b1000_0010; // 6  => 8'h82
        4'd7:  segment_display = 8'b1111_1000; // 7  => 8'hF8
        4'd8:  segment_display = 8'b1000_0000; // 8  => 8'h80
        4'd9:  segment_display = 8'b1001_0000; // 9  => 8'h90
        4'd10: segment_display = 8'b1000_1000; // A  => 8'h88
        4'd11: segment_display = 8'b1000_0011; // b  => 8'h83
        4'd12: segment_display = 8'b1100_0110; // C  => 8'hC6
        4'd13: segment_display = 8'b1010_0001; // d  => 8'hA1
        4'd14: segment_display = 8'b1000_0110; // E  => 8'h86
        4'd15: segment_display = 8'b1000_1110; // F  => 8'h8E
        default: segment_display = 8'b1111_1111; // blank => 8'hFF
    endcase
end

endmodule