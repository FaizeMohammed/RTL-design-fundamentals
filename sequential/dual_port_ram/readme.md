# Synchronous Dual-Port RAM (8x16)

## Overview
This project implements a synchronous, simple dual-port RAM in Verilog with separate write and read ports operating on a single clock domain.

## Specifications
- **Depth:** 8 locations (`3-bit` address bus)
- **Data Width:** 16 bits
- **Ports:** 1 Write Port (`we`, `wr_addr`, `data_in`), 1 Read Port (`re`, `rd_addr`, `data_out`)
- **Read Behavior:** Synchronous (Registered Read Output)
- **Clocking:** Single clock domain (`clk`)

## Block Interface
| Signal Name | Direction | Width | Description |
|---|---|---|---|
| `clk` | Input | 1 | Clock signal |
| `we` | Input | 1 | Write Enable (Active High) |
| `re` | Input | 1 | Read Enable (Active High) |
| `wr_addr` | Input | 3 | Write Address |
| `rd_addr` | Input | 3 | Read Address |
| `data_in` | Input | 16 | Data Input for Write |
| `data_out` | Output | 16 | Data Output for Read |

## Verification Strategy
A self-checking testbench was developed using Verilog tasks (`write`, `read`, `read_write`) and a reference array (`expected_mem`) to compare actual RTL outputs against predicted memory state on a cycle-by-cycle basis.

Key scenarios verified:
1. Basic Write followed by Read.
2. Simultaneous Read and Write to different addresses.
3. Simultaneous Read and Write to the same address (Read-Old-Data behavior).
4. Reading unwritten locations (verifying 'x' handling).

## What I Learned
- Hardware inference differences between synchronous read (Block RAM) and asynchronous read (Distributed RAM/LUTs).
- Race condition mitigation by merging dual-port memory logic into a single clock block.
- Structuring self-checking testbench tasks driving synchronous interfaces cleanly.
