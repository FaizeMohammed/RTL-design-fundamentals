# Vending Machine FSM

A Moore FSM-based vending machine that accepts ₹1 and ₹2 coins, dispenses a product when the total reaches ₹3 or more, and returns ₹1 change when ₹4 is inserted.

## Specifications

* Moore finite state machine (FSM)
* Accepts ₹1 and ₹2 coins
* Product dispensed at ₹3
* Product dispensed with ₹1 change at ₹4
* Supports coins in any order
* Synchronous active-high reset
* Invalid coin input `11` is ignored
* Self-checking SystemVerilog testbench

## Interface

| Signal    | Direction | Description                    |
|-----------|-----------|--------------------------------|
| `clk`     | Input     | Clock                          |
| `reset`   | Input     | Synchronous active-high reset  |
| `coin`    | Input     | Coin input (`01`=₹1, `10`=₹2) |
| `Product` | Output    | Asserted when product is dispensed |
| `Return`  | Output    | Asserted when ₹1 change is returned |

## Functionality

### States

The FSM represents the accumulated amount:

S0 → ₹0
S1 → ₹1
S2 → ₹2
S3 → ₹3
S4 → ₹4

## Simulation Waveform
<img width="1860" height="191" alt="Screenshot 2026-09-15 213846" src="https://github.com/user-attachments/assets/20475589-6b6b-4222-8a73-4c030feb8521" />
