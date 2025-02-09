// TestBench
`include "Main.v"
module TestBenchMIPS;
    reg clk;
    reg reset;

    main mips(
        .clk(clk),
        .reset(reset)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("mips_sim.vcd");
        $dumpvars(0, TestBenchMIPS);

        reset = 1;
        #20;
        reset = 0;

        // Executa por tempo suficiente para testar todas as instruções
        #400;

        // Mostra resultados finais
        $display("\n=== Final State of Registers ===");
        $display("$t0 (R8):  %h (%d)", mips.registradores.registers[8], $signed(mips.registradores.registers[8]));
        $display("$t1 (R9):  %h (%d)", mips.registradores.registers[9], $signed(mips.registradores.registers[9]));
        $display("$t2 (R10): %h (%d)", mips.registradores.registers[10], $signed(mips.registradores.registers[10]));
        $display("$t3 (R11): %h (%d)", mips.registradores.registers[11], $signed(mips.registradores.registers[11]));
        $display("$t4 (R12): %h (%d)", mips.registradores.registers[12], $signed(mips.registradores.registers[12]));
        $display("$t5 (R13): %h (%d)", mips.registradores.registers[13], $signed(mips.registradores.registers[13]));
        
        $display("\n=== Memory Content ===");
        $display("Mem[0]: %h (%d)", mips.dmemory.memory[0], $signed(mips.dmemory.memory[0]));
        
        $finish;
    end

    // Monitor de execução detalhado
    always @(posedge clk) begin
        if (!reset) begin
            $display("\nTime=%0t PC=%h", $time, mips.fetch.pc);
            $display("Instruction=%h", mips.instrucao);
            case(mips.instrucao[31:26])
                6'b000000: begin // R-type
                    case(mips.instrucao[5:0])
                        6'b100000: $display("ADD $%d, $%d, $%d", mips.mux_write_data, mips.registerReaded1, mips.registerReaded2);
                        6'b100010: $display("SUB $%d, $%d, $%d", mips.mux_write_data, mips.registerReaded1, mips.registerReaded2);
                        6'b100100: $display("AND $%d, $%d, $%d", mips.mux_write_data, mips.registerReaded1, mips.registerReaded2);
                        6'b100101: $display("OR $%d, $%d, $%d", mips.mux_write_data, mips.registerReaded1, mips.registerReaded2);
                        6'b101010: $display("SLT $%d, $%d, $%d", mips.mux_write_data, mips.registerReaded1, mips.registerReaded2);
                    endcase
                end
                6'b100011: $display("LW $%d, %d($%d)", mips.registerReaded2, $signed(mips.shifted_extended), mips.registerReaded1);
                6'b101011: $display("SW $%d, %d($%d)", mips.registerReaded2, $signed(mips.shifted_extended), mips.registerReaded1);
                6'b000100: $display("BEQ $%d, $%d, %d", mips.registerReaded1, mips.registerReaded2, $signed(mips.shifted_extended));
                6'b001000: $display("ADDI $%d, $%d, %d", mips.registerReaded2, mips.registerReaded1, $signed(mips.shifted_extended));
                // 6'b000010: $display("J %d", mips.jump_address);
            endcase
            $display("ALU Result=%h", mips.ALUResult);
        end
    end
endmodule