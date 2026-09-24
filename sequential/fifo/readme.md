# Synchronous FIFO — 8x8

## Overview

A parameterized-style synchronous FIFO implementation using Verilog.

The FIFO stores 8-bit data and has a depth of 8 entries. It supports synchronous write and read operations with an asynchronous active-low reset.

This project focuses on understanding FIFO architecture, pointers, occupancy tracking, full/empty generation, and self-checking verification using a reference queue.

---

## Specifications

| Parameter | Value |
|---|---|
| Data width | 8 bits |
| FIFO depth | 8 entries |
| Write clock | `clk` |
| Read clock | Same `clk` |
| Reset | Asynchronous active-low |
| Write operation | `wr_en && !full` |
| Read operation | `rd_en && !empty` |
| Full condition | `count == 8` |
| Empty condition | `count == 0` |

---

## FIFO Architecture

The FIFO consists of:

- 8 × 8-bit memory
- Write pointer
- Read pointer
- 4-bit occupancy counter
- Full flag
- Empty flag
- Registered data output

### Write Pointer

The write pointer identifies the memory location where the next accepted write occurs.

The pointer is 3 bits wide because the FIFO contains 8 locations.


wr_ptr: 0 → 1 → 2 → ... → 7 → 0<img width="1852" height="271" alt="Screenshot 2026-09-24 172351" src="https://github.com/user-attachments/assets/10f0eb2b-bfa5-4f56-bbbb-551ca6612b76" />
