// ALU Testbench
// Tests all operations of the ALU module

`timescale 1ns/1ps

module alu_tb;

    logic [7:0] a, b;
    logic [3:0] op;
    logic [15:0] result;
    logic carry, zero;

    // Instantiate the ALU
    alu uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .carry(carry),
        .zero(zero)
    );

    // Operation codes
    parameter ADD = 4'b0000;
    parameter SUB = 4'b0001;
    parameter AND = 4'b0010;
    parameter OR  = 4'b0011;
    parameter XOR = 4'b0100;
    parameter SHL = 4'b0101;
    parameter SHR = 4'b0110;
    parameter MUL = 4'b0111;

    initial begin
        $display("ALU Testbench Started");
        $display("Time\tA\tB\tOp\tResult\tCarry\tZero");
        $monitor("%0t\t%d\t%d\t%d\t%d\t%b\t%b", $time, a, b, op, result, carry, zero);

        // Test Addition
        a = 8'd10; b = 8'd5; op = ADD; #10;
        a = 8'd255; b = 8'd1; op = ADD; #10;  // Test carry

        // Test Subtraction
        a = 8'd20; b = 8'd5; op = SUB; #10;
        a = 8'd5; b = 8'd20; op = SUB; #10;

        // Test AND
        a = 8'b11110000; b = 8'b10101010; op = AND; #10;

        // Test OR
        a = 8'b11110000; b = 8'b10101010; op = OR; #10;

        // Test XOR
        a = 8'b11110000; b = 8'b10101010; op = XOR; #10;

        // Test Shift Left
        a = 8'b00000001; b = 8'd0; op = SHL; #10;

        // Test Shift Right
        a = 8'b10000000; b = 8'd0; op = SHR; #10;

        // Test Multiply
        a = 8'd10; b = 8'd5; op = MUL; #10;

        // Test Zero Flag
        a = 8'd0; b = 8'd0; op = ADD; #10;

        $display("\nALU Testbench Completed");
        $finish;
    end

endmodule
