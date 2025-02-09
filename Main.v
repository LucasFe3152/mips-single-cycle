`include "ALU.v"
`include "Add4.v"
`include "Adder32.v"
`include "Control_unit.v"
`include "DataMemory.v"
`include "MemoriaDeInstrucoes.v"
`include "Mux.v"
`include "Registradores.v"
`include "ShiftLeft2.v"
`include "SignalExtend.v"
`include "ALU_control.v"
`include "FetchUnit.v"

module main(
    input wire clk,
    input wire reset
);
    wire [31:0] instrucao;
    wire [31:0] mux_write_data;
    wire [31:0] registerReaded1;
    wire [31:0] registerReaded2;
    wire [31:0] mux_alu;
    wire [31:0] ALUResult;
    wire [31:0] extended_address;
    wire [31:0] readData;
    wire [31:0] shifted_extended;
    wire [4:0] mux_registor_destiny;
    wire [3:0] ALUOperation;
    wire [1:0] ALUOp;
    wire RegDst;
    wire Branch;
    wire MemRead;
    wire MemtoREG;
    wire RegWrite;
    wire MemWrite;
    wire ALUSrc;
    wire Zero;
    wire branch_result;

    FetchUnit fetch(
        .clk(clk),
        .reset(reset),
        .branch(branch_result),
        .extended_address(shifted_extended),
        .instrucao(instrucao)
    );

    ControlUnit controlUnit(
        .Op(instrucao[31:26]),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoREG(MemtoREG),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp)
    );

    mux5 m1(
        .a(instrucao[20:16]),
        .b(instrucao[15:11]),
        .selector(RegDst),
        .out(mux_registor_destiny)
    );

    mux32 m2(
        .a(ALUResult),
        .b(readData),
        .selector(MemtoREG),
        .out(mux_write_data)
    );
    
    mux32 m3(
        .a(registerReaded2),
        .b(extended_address),
        .selector(ALUSrc),
        .out(mux_alu)
    );

    SignExtend extender(
        .in(instrucao[15:0]),
        .out(extended_address)
    );

    Registradores registradores(
        .ReadRegister1(instrucao[25:21]),
        .ReadRegister2(instrucao[20:16]),
        .WriteRegister(mux_registor_destiny),
        .WriteData(mux_write_data),
        .RegWrite(RegWrite),
        .clk(clk),
        .ReadData1(registerReaded1),
        .ReadData2(registerReaded2)
    );

    ALU alu(
        .A(registerReaded1),
        .B(mux_alu),
        .ALUOperation(ALUOperation),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    ALUControl alucontrol(
        .ALUOp(ALUOp),
        .funct(instrucao[5:0]),
        .ALUOperation(ALUOperation)
    );

    DataMemory dmemory(
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(ALUResult),
        .writeData(registerReaded2),
        .readData(readData)
    );

    ShiftLeft2 shifter(
        .in(extended_address),
        .out(shifted_extended)
    );

    assign branch_result = Branch & Zero;

endmodule