# Processador MIPS de Ciclo Único em Verilog

Este é um projeto de um processador MIPS de ciclo único desenvolvido em Verilog. O processador suporta um conjunto básico de instruções MIPS e pode ser utilizado como base para o estudo e a compreensão dos princípios fundamentais de arquitetura de computadores. A implementação é baseada em um processador de ciclo único, onde todas as operações são realizadas em um único ciclo de clock.

## Instruções Suportadas

O processador implementa as seguintes instruções:

### 1. `lw` (Load Word)
- **Formato**: `lw $rt, offset($rs)`
- Carrega um valor de 32 bits da memória para o registrador `$rt`. O endereço da memória é calculado somando o valor de `$rs` com o valor do `offset`.

### 2. `sw` (Store Word)
- **Formato**: `sw $rt, offset($rs)`
- Armazena o valor de 32 bits do registrador `$rt` na memória, no endereço calculado como soma de `$rs` e `offset`.

### 3. `beq` (Branch Equal)
- **Formato**: `beq $rs, $rt, offset`
- Se o conteúdo dos registradores `$rs` e `$rt` forem iguais, o processador realiza um salto para o endereço especificado pelo `offset`.

### 4. `addi` (Add Immediate)
- **Formato**: `addi $rt, $rs, immediate`
- Soma o valor imediato (constante) ao valor no registrador `$rs` e armazena o resultado no registrador `$rt`.

### 5. `add` (Addition)
- **Formato**: `add $rd, $rs, $rt`
- Soma os valores nos registradores `$rs` e `$rt`, armazenando o resultado em `$rd`.

### 6. `sub` (Subtraction)
- **Formato**: `sub $rd, $rs, $rt`
- Subtrai o valor no registrador `$rt` do valor no registrador `$rs` e armazena o resultado em `$rd`.

### 7. `and` (Logical AND)
- **Formato**: `and $rd, $rs, $rt`
- Realiza uma operação lógica AND bit a bit entre os registradores `$rs` e `$rt`, e armazena o resultado em `$rd`.

### 8. `or` (Logical OR)
- **Formato**: `or $rd, $rs, $rt`
- Realiza uma operação lógica OR bit a bit entre os registradores `$rs` e `$rt`, e armazena o resultado em `$rd`.

### 9. `slt` (Set on Less Than)
- **Formato**: `slt $rd, $rs, $rt`
- Compara os valores nos registradores `$rs` e `$rt`. Se o valor em `$rs` for menor que o valor em `$rt`, o registrador `$rd` recebe o valor 1; caso contrário, recebe 0.

## Como Executar

### Requisitos

- **Verilog Simulator** (Icarus Verilog e GTKWAVE)
- **Make** (para automação de construção e simulação)

### Passos para Simular

1. Clone o repositório para sua máquina local:
2. Caso queria rodar outro código no processador apenas substitua pelo código hexadecimal no arquivo "codigo.mem"
3. Execute a instrução make all
4. A saída da simulação são todos os registradores e algumas posições da memória, pode ser facilmente alterado no arquivo "tb_main.v"

