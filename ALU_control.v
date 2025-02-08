module control_unit (
    input wire [5:0] opcode,
    output wire RegDst,
    output wire ALUSrc,
    output wire Memtoreg,
    output wire RegWrite,
    output wire MemRead,
    output wire MemWrite,
    output wire Branch,
    output wire [1:0] ALUOp1
);
    
endmodule