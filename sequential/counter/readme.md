# Parameterized Counter

A parameterized synchronous up-counter with an asynchronous active-low reset and enable control.

## Specifications

* Parameterized counter width
* Asynchronous active-low reset
* Synchronous counting
* Enable-controlled increment
* Natural modulo `2^WIDTH` wraparound
* Self-checking SystemVerilog testbench
* Reference model used for DUT verification

## Interface

| Signal  | Direction | Description                   |
| ------- | --------- | ----------------------------- |
| `clk`   | Input     | Clock                         |
| `rstn`  | Input     | Asynchronous active-low reset |
| `en`    | Input     | Counter enable                |
| `count` | Output    | Current counter value         |

## Functionality

### Reset

When `rstn = 0`, the counter is immediately cleared to zero.

### Counting

When `rstn = 1` and `en = 1`, the counter increments on every rising edge of `clk`.

### Hold

When `rstn = 1` and `en = 0`, the counter retains its previous value.

### Wraparound

The counter naturally wraps around after reaching its maximum value.

For `WIDTH = 4`:

```text
0000 → 0001 → 0010 → ... → 1111 → 0000
```

Therefore, the counter operates modulo `2^WIDTH`.

## Verification

The testbench contains an independent reference model and self-checking mechanism.

The following scenarios were verified:

* Asynchronous reset
* Counter increment
* Enable disabled / hold condition
* Maximum value to zero wraparound
* Reset during operation
* Multiple counting cycles
* DUT vs. reference-model comparison

### Result

All functional test cases passed with no DUT mismatches.

Example output:
 time=                   0,rstn=0,en=0,count=0000
 time=                   2,rstn=1,en=1,count=0000
 time=                   5,rstn=1,en=1,count=0001
 time=                  15,rstn=1,en=1,count=0010
 time=                  25,rstn=1,en=1,count=0011
 time=                  35,rstn=1,en=1,count=0100
<img width="1777" height="291" alt="Screenshot 2026-09-13 160250" src="https://github.com/user-attachments/assets/ce9d63ba-aeca-423e-99e7-d105444bd061" />


## Tools

* SystemVerilog
* QuestaSim

## Project Structure

```text
counter/
├── counter.v
├── counter_tb.sv
└── README.md
```
