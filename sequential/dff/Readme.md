# Parameterized D Flip-Flop

## Description
Parameterized D flip-flop/register with asynchronous active-low reset.

## Features
- Parameterized data width
- Positive-edge triggered
- Asynchronous active-low reset
- Self-checking SystemVerilog testbench
- Independent reference model

## Verification
The testbench verifies:
- Asynchronous reset
- Reset release
- Data capture on positive clock edge
- Data hold between clock edges
- Multiple data changes before a clock edge
- Reset after data capture

Simulation result:
PASS
Errors: 0
Warnings: 0
