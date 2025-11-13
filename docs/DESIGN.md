# RISC-V CPU Design Documentation

## Block Diagram

      +----------------+      +-----------------+
      | Instruction    |      |   Control Unit  |
      | Memory (imem)  |----->|                 |
      +----------------+      +--------+--------+
                 |                      |
      +----------v----------+           |
      |   Instruction       |           |
      |   Decode            |           |
      +----------+----------+           |
                 |                      |
      +----------v----------+           |
      |   Register File     |           |
      |   (regfile)         |           |
      +----------+----------+           |
                 |                      |
      +----------v----------+           |
      |   ALU               |<----------+
      |   (alu)             |
      +----------+----------+
                 |
      +----------v----------+
      |   Data Memory       |
      |   (dmem)            |
      +---------------------+



## Datapath Description

### Single-Cycle Architecture
- **Instruction Fetch**: PC → Instruction Memory → Instruction Register
- **Instruction Decode**: Split into opcode, registers, immediates
- **Register Read**: Read two source registers from register file
- **Execute**: ALU performs arithmetic/logical operations
- **Memory Access**: Load/Store operations with data memory
- **Write Back**: Results written back to register file

### Control Signals
- **RegWrite**: Enable register file write
- **ALUSrc**: Selects between register and immediate ALU input
- **MemtoReg**: Selects between ALU result and memory data for writeback
- **MemWrite**: Enables data memory write
- **Branch**: Indicates branch instruction
- **ALUOp**: Specifies ALU operation type

## Supported Instruction Format Handling
add, sub, and, or, xor
[31:25] funct7 | [24:20] rs2 | [19:15] rs1 | [14:12] funct3 | [11:7] rd | [6:0] opcode

### R-type Instructions (Register operations)

addi, lw, jalr
[31:20] immediate | [19:15] rs1 | [14:12] funct3 | [11:7] rd | [6:0] opcode

### S-type Instructions

sw
[31:25] imm[11:5] | [24:20] rs2 | [19:15] rs1 | [14:12] funct3 | [11:7] imm[4:0] | [6:0] opcode

### B- type Instructions

beq, bne
[31:25] imm[12|10:5] | [24:20] rs2 | [19:15] rs1 | [14:12] funct3 | [11:7] imm[4:1|11] | [6:0] opcode


## Module Specifications

### ALU Operations
- **Arithmetic**: ADD, SUB
- **Logical**: AND, OR, XOR
- **Comparison**: SLT, SLTU
- **Shift**: SLL, SRL, SRA

### Memory Mapping
- **Instruction Memory**: 0x00000000 and up
- **Data Memory**: Separate address space
- **Word-aligned** accesses (32-bit)

### Register File
- **32 registers** (x0-x31)
- **x0 hardwired to 0**
- **Read ports**: 2 (rs1, rs2)
- **Write port**: 1 (rd)

### T Output :

** RISC-V Single Cycle CPU Simulation **
Looking for test file: tests/test_base.hex
Found test file: tests/test_base.hex
1. Compiling Verilog files...
 Compilation successful, yay! Lets continue..
2. Running simulation...
WARNING: src/instructionMemory.v:19: $readmemh(tests/test_base.hex): Not enough words in the file for the requested range [0:1023].
VCD info: dumpfile sim/tb.vcd opened for output.
*** RISC-V CPU Testbench Starting ***
Reset released
Cycle 2: PC=0x00000000
Cycle 3: PC=0x00000004
Cycle 4: PC=0x00000008
Cycle 5: PC=0x0000000c
Cycle 6: PC=0x00000010
Cycle 7: PC=0x00000014
Cycle 8: PC=0x00000018
Cycle 9: PC=0x0000001c
Cycle 10: PC=0x00000020
Cycle 11: PC=0x00000024
Cycle 12: PC=0x00000028
Cycle 13: PC=0x00000028
Cycle 14: PC=0x00000028
Cycle 15: PC=0x00000028
Cycle 16: PC=0x00000028
Cycle 17: PC=0x00000028
Cycle 18: PC=0x00000028
Cycle 19: PC=0x00000028
Cycle 20: PC=0x00000028
Cycle 21: PC=0x00000028
Cycle 22: PC=0x00000028
Cycle 23: PC=0x00000028
Cycle 24: PC=0x00000028
Cycle 25: PC=0x00000028
Cycle 26: PC=0x00000028
Cycle 27: PC=0x00000028
Cycle 28: PC=0x00000028
Cycle 29: PC=0x00000028
Cycle 30: PC=0x00000028
Cycle 31: PC=0x00000028
Cycle 32: PC=0x00000028
Cycle 33: PC=0x00000028
Cycle 34: PC=0x00000028
Cycle 35: PC=0x00000028
Cycle 36: PC=0x00000028
Cycle 37: PC=0x00000028
Cycle 38: PC=0x00000028
Cycle 39: PC=0x00000028
Cycle 40: PC=0x00000028
Cycle 41: PC=0x00000028
Cycle 42: PC=0x00000028
Cycle 43: PC=0x00000028
Cycle 44: PC=0x00000028
Cycle 45: PC=0x00000028
Cycle 46: PC=0x00000028
Cycle 47: PC=0x00000028
Cycle 48: PC=0x00000028
Cycle 49: PC=0x00000028
Cycle 50: PC=0x00000028
Cycle 51: PC=0x00000028
Cycle 52: PC=0x00000028
Cycle 53: PC=0x00000028
Cycle 54: PC=0x00000028
Cycle 55: PC=0x00000028
Cycle 56: PC=0x00000028
Cycle 57: PC=0x00000028
Cycle 58: PC=0x00000028
Cycle 59: PC=0x00000028
Cycle 60: PC=0x00000028
Cycle 61: PC=0x00000028
Cycle 62: PC=0x00000028
Cycle 63: PC=0x00000028
Cycle 64: PC=0x00000028
Cycle 65: PC=0x00000028
Cycle 66: PC=0x00000028
Cycle 67: PC=0x00000028
Cycle 68: PC=0x00000028
Cycle 69: PC=0x00000028
Cycle 70: PC=0x00000028
Cycle 71: PC=0x00000028
Cycle 72: PC=0x00000028
Cycle 73: PC=0x00000028
Cycle 74: PC=0x00000028
Cycle 75: PC=0x00000028
Cycle 76: PC=0x00000028
Cycle 77: PC=0x00000028
Cycle 78: PC=0x00000028
Cycle 79: PC=0x00000028
Cycle 80: PC=0x00000028
Cycle 81: PC=0x00000028
Cycle 82: PC=0x00000028
Cycle 83: PC=0x00000028
Cycle 84: PC=0x00000028
Cycle 85: PC=0x00000028
Cycle 86: PC=0x00000028
Cycle 87: PC=0x00000028
Cycle 88: PC=0x00000028
Cycle 89: PC=0x00000028
Cycle 90: PC=0x00000028
Cycle 91: PC=0x00000028
Cycle 92: PC=0x00000028
Cycle 93: PC=0x00000028
Cycle 94: PC=0x00000028
Cycle 95: PC=0x00000028
Cycle 96: PC=0x00000028
Cycle 97: PC=0x00000028
Cycle 98: PC=0x00000028
Cycle 99: PC=0x00000028
Cycle 100: PC=0x00000028
Cycle 101: PC=0x00000028

** Simulation Results **
Final PC: 0x00000028

Simulation completed
3. Simulation completed!
 Waveform file:  -->  sim/tb.vcd
To view waveforms, run: -->   gtkwave sim/tb.vcd

**Simulation Complete!! **
