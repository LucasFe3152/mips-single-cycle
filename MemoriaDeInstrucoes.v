module MemoriaDeInstrucoes(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instrucao // Instrução lida
);

    reg [31:0] memoria [255:0];
    integer i;

    initial begin
        // Programa de teste que usa todas as instruções suportadas
        memoria[0]  = 32'h20080005;  // addi $t0, $zero, 5    # t0 = 5
        memoria[1]  = 32'h20090003;  // addi $t1, $zero, 3    # t1 = 3
        memoria[2]  = 32'h01095020;  // add $t2, $t0, $t1     # t2 = t0 + t1 = 8
        memoria[3]  = 32'hAC0A0000;  // sw $t2, 0($zero)      # Mem[0] = t2 (8)
        memoria[4]  = 32'h8C0B0000;  // lw $t3, 0($zero)      # t3 = Mem[0] (8)
        memoria[5]  = 32'h012A6022;  // sub $t4, $t1, $t2     # t4 = t1 - t2 = -5
        memoria[6]  = 32'h012A682A;  // slt $t5, $t1, $t2     # t5 = (t1 < t2) = 1
        memoria[7]  = 32'h11090001;  // beq $t0, $t1, 2       # Não pula (5 != 3)
        memoria[8]  = 32'h08000010;  // j 16                   # Pula para instrução 16
        memoria[9]  = 32'h01285024;  // and $t2, $t1, $t0     # Não deve executar
        memoria[16] = 32'h01285025;  // or $t2, $t1, $t0      # t2 = t1 OR t0
        memoria[17] = 32'h00000000;  // nop - fim do programa

        // Zera o resto da memória
        for (i = 18; i < 256; i = i + 1) begin
            memoria[i] = 32'b0;
        end
    end

    assign instrucao = memoria[addr[9:2]];// Usa os bits 9:2 para indexar (alinhado em palavras)

endmodule 