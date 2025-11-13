# 32-bit Single Cycle RISC-V CPU

CPSC 440 Computer Architecture

## Project Overview
Implementation of a 32-bit single-cycle RISC-V CPU supporting RV32I base instruction set.

## Current Status
- Project structure initialized
- Basic module templates
- Development environment setup in progress

## Core CPU Architecture
- 32-bit RISC-V RV32I instruction set
- single cycle execution model
- multiple stage pipeline
- 4kb instruciton memory, hex file upload
- 32 register file with x0 hardwired to 0

## instruction support
- R-type : add, sub, or, xor, slt, sltu, sll, srl, sra
- I type: addi, ori, xori, slti, ....

##Key components:
- ALU : support arithmetic, comparison operations
- register file: 32 registered with x0 hardwired to zero
- memeory units: seperate instruction and data memory odule

## verificaitn and testing
- tesetbench + waveform generation
- unit tests for modules
- auotmated simulation scripts
- error handling for memory access

# project structure:

TheDefaultCPUandDesign/
├── src/ # Verilog source files
│ ├── cpu.v #  CPU integration
│ ├── alu.v # Arithmetic Logic Unit
│ ├── regfile.v # 32-register file
│ ├── controlUnit.v # Main control logic
│ ├── aluControl.v # ALU operation decoding
│ ├── immediateGen.v # Immediate value extraction
│ ├── instructionMemory.v # 4KB instruction memory
│ ├── dataMemory.v # 4KB data memory
│ └── pcRegister.v # Program counter
├── tests/ # Test files
│ ├── testbench.v # Main testbench
│ ├── test_base.hex # Test program
│ ├── test_simple.hex # Simple test program
│ └── test_alu.v # ALU unit test
├── scripts/ # Automation scripts
│ ├── runSimulation.sh # Main simulation runner
│ ├── test_phase.sh # Comprehensive testing
│ ├── quickCheck.sh # Environment verification
│ └── setup_environment.sh # Tool setup
├── sim/ # Simulation outputs (generated)
│ ├── tb.vcd # Waveform file
│ └── tb.vvp # Compiled testbench
├── docs/ # Documentation
│ └── project_documentation.md # Detailed documentation
└── README.md # This file

# quick start
- bash
# isntall required tools (ubuntu)

# Make scripts executable
chmod +x scripts/*.sh

# Run complete simulation
./scripts/runSimulation.sh

# View Waveforms
gtkwave sim/tb.vcd

## AI Assistance :

- tools used : ChatGPT
- verilog syntax issues: assistance with resolving compliation errors relating to signed arithmetic operations and case statement syntax
- script optimization : bash script error handling improvements
- syntax verification : Verilog syntax checking for complex operations
- used for: documentation assistance
- for project overview
- gap analysis: helped to identify missing components and documentation requirements
-  Testbench op: suggestions for improving waveform generation and simulation monitoring
- Development workflow: ideas for testing approaches and verification
- guidance on documentation formatting and project structure presentation

- example prompt: "How to properly connect control signals in a RISC-V single cycle processor?"


common issues:
- compilation erros
- simulation crashes: verify test files existing in tests/
- PC not advancing

Author : Alexis Keck
