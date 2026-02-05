# Opto_ML_Solution
Single-stage SystemVerilog pipeline register implementing a standard valid/ready handshake with correct backpressure handling and no data loss.

# Single-Stage Valid/Ready Pipeline Register (SystemVerilog)
This repository contains a fully synthesizable single-stage pipeline register
implemented in SystemVerilog using a standard valid/ready handshake protocol.

## Overview
The module sits between an upstream producer and a downstream consumer and
provides one stage of buffering. It accepts data when `in_valid` and `in_ready`
are asserted, holds data during downstream backpressure, and forwards the data
when `out_ready` is asserted. The design guarantees no data loss or duplication
and supports full throughput with one transfer per cycle when both sides are
ready.

## Features
- Standard valid/ready handshake
- Correct backpressure handling
- No data loss or duplication
- Single-cycle throughput (consume and accept in same cycle)
- Asynchronous active-low reset
- Fully synthesizable RTL

## Interface
- `in_valid`, `in_ready`, `in_data`: upstream interface
- `out_valid`, `out_ready`, `out_data`: downstream interface

## Implementation Notes
The design uses a single internal register to store data and a valid flag that
represents the buffer state (empty/full). The `in_ready` signal is asserted when
the buffer is empty or when the downstream is ready to accept data.
