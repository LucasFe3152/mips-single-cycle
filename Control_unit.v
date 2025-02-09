module ControlUnit(
    input wire [5:0] Op,
    output reg RegDst,
    output reg Branch,
    output reg MemRead,
    output reg MemtoREG,
    output reg RegWrite,
    output reg MemWrite,
    output reg ALUSrc,
    output reg [1:0] ALUOp
);

    // r-type: OPCODE = 0
    // load = 35
    // store = 43
    // branch = 4
    always @(*) begin
        case (Op) 
            6'b000000: begin
                RegDst = 1'b1;
                ALUSrc = 1'b0;
                MemtoREG = 1'b0;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b10;
            end
            6'b100011: begin
                RegDst = 1'b0;
                ALUSrc = 1'b1;
                MemtoREG = 1'b1;
                RegWrite = 1'b1;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b00;
            end
            6'b101011: begin
                RegDst = 1'bx;
                ALUSrc = 1'b1;
                MemtoREG = 1'bx;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b1;
                Branch = 1'b0;
                ALUOp = 2'b00;
            end
            6'b000100: begin
                RegDst = 1'bx;
                ALUSrc = 1'b0;
                MemtoREG = 1'bx;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b1;
                ALUOp = 2'b01;
            end
            6'b001000: begin
                RegDst = 1'b0;
                ALUSrc = 1'b1;
                MemtoREG = 1'b0;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b00;
            end
            default: begin
                RegDst = 1'b0;
                ALUSrc = 1'b0;
                MemtoREG = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b11;
            end
        endcase
    end
endmodule