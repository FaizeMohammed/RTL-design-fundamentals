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
# time=                   2,rstn=1,en=1,count=0000
# time=                   5,rstn=1,en=1,count=0001
# time=                  15,rstn=1,en=1,count=0010
# time=                  25,rstn=1,en=1,count=0011
# time=                  35,rstn=1,en=1,count=0100
# time=                  45,rstn=1,en=1,count=0101
# time=                  55,rstn=1,en=1,count=0110
# time=                  65,rstn=1,en=1,count=0111
# time=                  75,rstn=1,en=1,count=1000
# time=                  85,rstn=1,en=1,count=1001
# time=                  95,rstn=1,en=1,count=1010
# time=                 105,rstn=1,en=1,count=1011
# time=                 115,rstn=1,en=1,count=1100
# time=                 125,rstn=1,en=1,count=1101
# time=                 135,rstn=1,en=1,count=1110
# time=                 145,rstn=1,en=1,count=1111
# PASS,count_expected=15,count_dut=15
# time=                 155,rstn=1,en=1,count=0000
# time=                 165,rstn=1,en=1,count=0001
# PASS,count_expected= 1,count_dut= 1
# time=                 166,rstn=0,en=1,count=0000
# PASS,count_expected= 0,count_dut= 0
# time=                 167,rstn=1,en=1,count=0000
# time=                 175,rstn=1,en=1,count=0001
# time=                 185,rstn=1,en=1,count=0010
# time=                 195,rstn=1,en=1,count=0011
# time=                 205,rstn=1,en=1,count=0100
# time=                 215,rstn=1,en=1,count=0101
# time=                 225,rstn=1,en=1,count=0110
# time=                 235,rstn=1,en=1,count=0111
# time=                 245,rstn=1,en=1,count=1000
# time=                 255,rstn=1,en=1,count=1001
# time=                 265,rstn=1,en=0,count=1010
# PASS,count_expected=10,count_dut=10

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
