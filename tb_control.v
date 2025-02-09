`timescale 1ns/1ns
`include "Control_unit.v"

module Simulacao;
    reg [5:0] Op;
    wire RegDst;
    wire Branch;
    wire MemRead;
    wire MemtoREG;
    wire RegWrite;
    wire MemWrite;
    wire ALUSrc;
    wire [1:0] ALUOp;

    ControlUnit control(
        .Op(Op),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoREG(MemtoREG),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp)
    );

    initial begin
        $dumpfile("sinal_control_unit.vcd");
        $dumpvars(0, Simulacao);

        Op = 6'b000000;
        
        #10;
        Op = 6'b100011;
        
        #10;
        Op = 6'b101011;

        #10;
        Op = 6'b000100;

        #10;
        $finish;
    end
endmodule