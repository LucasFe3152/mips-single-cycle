`timescale 1ns/1ns
`include "ALU_control.v"
`include "ALU.v"

module Simulacao;
    reg [1:0] ALUOp;
    reg [5:0] funct;
    reg [31:0] a;
    reg [31:0] b;
    wire [3:0] operation;

    wire [31:0] ALUResult;
    wire Zero;

    ALUControl control(
        .ALUOperation(operation),
        .ALUOp(ALUOp),
        .funct(funct)
    );

    ALU alu1(
        .A(a),
        .B(b),
        .ALUOperation(operation),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    initial begin
        $dumpfile("sinal_alucontrol.vcd");
        $dumpvars(0, Simulacao);

        a = 32'b00000000000000000000000000000000;
        b = 32'b11111111111111111111111111111111;

        ALUOp = 2'b00; 

        #10;

        ALUOp = 2'b01;

        #10;

        ALUOp = 2'b10;

        funct = 6'b100000;

        #10;

        funct = 6'b100010;

        #10;

        funct = 6'b100100;

        #10;

        funct = 6'b100101;

        #10;

        funct = 6'b101010;

        #10;

        $finish;
    end

    initial begin
        $monitor("Time: %0d, ALUOp: %d, funct: %d, ALUResult: %d, Zero: %b",
        $time, ALUOp, funct, ALUResult, Zero);
    end

endmodule