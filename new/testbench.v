`timescale 1ns/1ps

module tb_alu16;

    reg  [15:0] a;
    reg  [15:0] b;
    reg  [3:0]  op;
    wire [15:0] result;
    wire        zero;
    wire        carry_out;

    alu16 dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .zero(zero),
        .carry_out(carry_out)
    );

    initial begin
        $display("==== ALU16 TEST START ====");

        // ADD
        a = 16'h0003; b = 16'h0005; op = 4'b0000; #10;
        $display("ADD : a=%h b=%h op=%b result=%h zero=%b carry=%b", a, b, op, result, zero, carry_out);

        // SUB
        a = 16'h0009; b = 16'h0004; op = 4'b0001; #10;
        $display("SUB : a=%h b=%h op=%b result=%h zero=%b carry=%b", a, b, op, result, zero, carry_out);

        // AND
        a = 16'h00F0; b = 16'h0FF0; op = 4'b0010; #10;
        $display("AND : a=%h b=%h op=%b result=%h zero=%b carry=%b", a, b, op, result, zero, carry_out);

        // OR
        a = 16'h00F0; b = 16'h0F0F; op = 4'b0011; #10;
        $display("OR  : a=%h b=%h op=%b result=%h zero=%b carry=%b", a, b, op, result, zero, carry_out);

        // XOR
        a = 16'h00FF; b = 16'h0F0F; op = 4'b0100; #10;
        $display("XOR : a=%h b=%h op=%b result=%h zero=%b carry=%b", a, b, op, result, zero, carry_out);

        // NOT
        a = 16'h00FF; b = 16'h0000; op = 4'b0101; #10;
        $display("NOT : a=%h b=%h op=%b result=%h zero=%b carry=%b", a, b, op, result, zero, carry_out);

        // SLL
        a = 16'h0003; b = 16'h0000; op = 4'b0110; #10;
        $display("SLL : a=%h b=%h op=%b result=%h zero=%b carry=%b", a, b, op, result, zero, carry_out);

        // SRL
        a = 16'h0006; b = 16'h0000; op = 4'b0111; #10;
        $display("SRL : a=%h b=%h op=%b result=%h zero=%b carry=%b", a, b, op, result, zero, carry_out);

        // EQ true
        a = 16'h00AA; b = 16'h00AA; op = 4'b1000; #10;
        $display("EQ1 : a=%h b=%h op=%b result=%h zero=%b carry=%b", a, b, op, result, zero, carry_out);

        // EQ false
        a = 16'h00AA; b = 16'h00AB; op = 4'b1000; #10;
        $display("EQ0 : a=%h b=%h op=%b result=%h zero=%b carry=%b", a, b, op, result, zero, carry_out);

        // ADD with carry
        a = 16'hFFFF; b = 16'h0001; op = 4'b0000; #10;
        $display("ADDc: a=%h b=%h op=%b result=%h zero=%b carry=%b", a, b, op, result, zero, carry_out);

        $display("==== ALU16 TEST END ====");
        $finish;
    end

endmodule