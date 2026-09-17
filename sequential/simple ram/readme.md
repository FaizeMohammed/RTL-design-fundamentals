# Single-Port RAM

A parameterized single-port RAM with synchronous write and asynchronous read.

## Specifications

* Parameterized data width
* Parameterized memory depth
* Synchronous write operation
* Asynchronous read operation
* Write enable control
* Self-checking testbench
* Independent reference memory used for DUT verification

## Interface

| Signal  | Direction | Description |
| ------- | --------- | ----------- |
| `clk`   | Input     | Clock |
| `we`    | Input     | Write enable |
| `addr`  | Input     | Memory address |
| `wdata` | Input     | Data to be written |
| `rdata` | Output    | Data read from memory |

## Simulation Output

<img width="1830" height="210" alt="Screenshot 2026-09-17 114320" src="https://github.com/user-attachments/assets/d1d04a0d-1966-4c5e-a1ce-387f2fb1d9eb" />

