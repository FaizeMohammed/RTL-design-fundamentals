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

## Tools

* Verilog
* SystemVerilog
* QuestaSim

## Project Structure

```text
counter/
├── counter.v
├── counter_tb.sv
└── README.md
```
