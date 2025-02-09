`timescale 1ns/1ns
`include "Main.v"


module Simulacao;
    reg clk;
    reg reset;
    integer i;

    main mips(
        .clk(clk),
        .reset(reset)
    );


    always #5 clk = ~clk;

    initial begin
        $dumpfile("mips_sim.vcd");
        $dumpvars(0, Simulacao);

        clk = 0;

        reset = 1;
        #20;
        reset = 0;

        #400;

        $display("Registradores:");
        for (i = 0; i < 32; i = i + 1) begin
            $display("$%d: (%d)", i, $signed(mips.registradores.registers[i]));
        end
        
        
        $display("Memoria:");
        for (i = 0; i < 11; i = i + 1) begin
            $display("Mem[%d]: (%d)", i, $signed(mips.dmemory.memory[i]));
        end
        
        $finish;
    end

    
endmodule