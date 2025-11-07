#!/bin/bash

echo "** RISC-V Single Cycle CPU Simulation **"

# selecting test file. The default is test_base.hex
TEST_FILE=${1:-"test_base.hex"}

FULL_PATH="tests/$TEST_FILE"

echo "Looking for test file: $FULL_PATH"

# Checking if the file exits, if not, then..
if [ ! -f "$FULL_PATH" ]; then
echo " error, Test file not found : $FULL_PATH"
echo "Available test files in : "
ls tests/*hex 2>/dev/null || echo "No .hex files found"
exit 1
fi

echo "Found test file: $FULL_PATH"


#creating simulation directory here:
mkdir -p sim



#all verilog modules compiling
echo "1. Compiling Verilog files..."
iverilog -o sim/tb.vvp \
    -I src \
    src/alu.v \
    src/regfile.v \
    src/controlUnit.v \
    src/aluControl.v \
    src/immediateGen.v \
    src/instructionMemory.v \
    src/dataMemory.v \
    src/pcRegister.v \
    src/cpu.v \
    tests/testbench.v

#check compiling success
if [ $? -ne 0 ]; then
    echo "Compilation failed!"
    exit 1
fi

echo " Compilation successful, yay! Lets continue.."

echo "2. Running simulation..."
#execute simulation
vvp sim/tb.vvp

# Check simulation success
if [ $? -ne 0 ]; then
    echo " Oh no! Simulation failed!"
    exit 1
fi


echo "3. Simulation completed! "

# Check for waveform file
if [ -f "sim/tb.vcd" ]; then
    echo " Waveform file:  -->  sim/tb.vcd"
    echo "To view waveforms, run: -->   gtkwave sim/tb.vcd"
else


    echo "  No waveform file generated"
fi

echo ""
echo "**Simulation Complete!! **"
