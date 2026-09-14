# Parameterized ALU Design and Verification

A parameterized Arithmetic Logic Unit (ALU) designed using SystemVerilog and verified using a self-checking SystemVerilog testbench.

## Features

- Parameterized data width
- Addition with carry detection
- Subtraction with borrow detection
- Bitwise AND
- Bitwise OR
- Bitwise XOR
- Logical left shift
- Logical right shift
- Greater-than comparison
- Zero flag generation

## Verification

The ALU was verified using a directed, self-checking SystemVerilog testbench.

The testbench includes:
- Directed test cases
- Expected result calculation
- Expected carry/borrow calculation
- Zero flag checking
- PASS/FAIL reporting using a checking task

## Operations

| Opcode | Operation |
|--------|-----------|
| 000 | Addition |
| 001 | Subtraction |
| 010 | AND |
| 011 | OR |
| 100 | XOR |
| 101 | Shift Left |
| 110 | Shift Right |
| 111 | Greater Than Comparison |

## Simulation Result

All directed test cases passed successfully.

- Tests Passed: 11
- Tests Failed: 0
- Compilation Errors: 0
- Warnings: 0

## Tools

- SystemVerilog
- QuestaSim / Questa

## Project Structure

```text
├── alu.sv
├── alu_tb.sv
└── README.md
