echo "=== Testing Core Modules ==="

echo "1. Testing ALU..."
iverilog -o sim/alu_test src/alu.v tests/test_alu.v
vvp sim/alu_test

echo ""
echo "Core module tests completed!"
