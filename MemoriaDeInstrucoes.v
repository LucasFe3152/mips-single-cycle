module MemoriaDeInstrucoes(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instrucao // Instrução lida
);

    reg [31:0] memoria [255:0];
    integer i;

    initial begin
        $readmemh("codigo.mem", memoria);
    end

    assign instrucao = memoria[addr[9:2]];// Usa os bits 9:2 para indexar (alinhado em palavras)

endmodule 