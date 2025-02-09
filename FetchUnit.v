module FetchUnit(
    input wire clk,                 // Clock
    input wire reset,               // Reset para inicializar o PC
    input wire branch,
    input wire [31:0] extended_address,
    output wire [31:0] instrucao    // Instrução buscada da memória
);

    // Registrador do PC
    reg [31:0] pc;

    // Fios para conexão entre módulos
    wire [31:0] pc_incrementado4;
    wire [31:0] pc_incrementado;
    wire [31:0] added_instruction;

    // Instancia o módulo Add4 para incrementar o PC
    Add4 somador (
        .in(pc),
        .out(pc_incrementado4)
    );

    Adder32 ad(
        .a(pc_incrementado4),
        .b(extended_address),
        .sum(added_instruction)
    );

    mux32 m4(
        .a(pc_incrementado4),
        .b(added_instruction),
        .selector(branch),
        .out(pc_incrementado)
    );

    // Instancia o módulo MemoriaDeInstrucoes para buscar instruções
    MemoriaDeInstrucoes memoria (
        .addr(pc),
        .instrucao(instrucao)
    );

    // Lógica do PC: Incrementa ou reseta
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa o PC no reset
            pc <= 32'b0;            
        end else begin
            // Atualiza o PC com o próximo endereço
            pc <= pc_incrementado;  
        end
    end

endmodule
