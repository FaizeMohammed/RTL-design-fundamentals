# 1011 Sequence Detector

A Moore FSM-based sequence detector designed to detect the serial input sequence `1011` with overlapping sequence detection and an asynchronous active-low reset.

## Specifications

* Moore finite state machine (FSM)
* Detects the sequence `1011`
* Overlapping sequence detection
* Asynchronous active-low reset
* Single-bit serial input
* Self-checking SystemVerilog testbench

## Interface

| Signal     | Direction | Description                   |
|------------|-----------|-------------------------------|
| `clk`      | Input     | Clock                         |
| `rstn`     | Input     | Asynchronous active-low reset |
| `din`      | Input     | Serial input bit              |
| `detected` | Output    | Asserted when `1011` is detected |

## Functionality

### Reset

When `rstn = 0`, the FSM is immediately reset to the idle state `S0`.

### Sequence Detection

The FSM tracks the incoming serial bits:
S0 → S1(1) → S2(10) → S3(101) → S4(1011)

<img width="1805" height="346" alt="Screenshot 2026-09-15 150405" src="https://github.com/user-attachments/assets/d06fc3a3-185e-4388-9bf6-0bb77b538f57" />

            

