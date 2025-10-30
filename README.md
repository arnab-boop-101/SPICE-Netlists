# SPICE-Netlists
SPICE circuit netlists for analog/AMS IPs from Virtuoso/Spectre
# CMOS Two-Stage Operational Amplifier (180 nm)

This repository contains a transistor-level SPICE netlist of a **two-stage CMOS operational amplifier** designed in **180 nm CMOS technology**.  
It is optimized for integration in analog IP development, mixed-signal SoCs, and educational design studies.

---

## Overview

**Architecture:**  
- Differential NMOS input pair with PMOS active mirror load  
- Common-source second gain stage with PMOS active load  
- Miller compensation for frequency stabilization  
- External tail-bias for current control  
- Supply: **1.8 V** typical

This is a clean, simulation-ready reference design suitable for **Cadence Virtuoso ADE**, **Spectre**, **HSPICE**, or **Ngspice** environments.

---



---

## Node and Port Summary

| Node | Description |
|------|--------------|
| `VINP` | Non-inverting input |
| `VINN` | Inverting input |
| `VOUT` | Amplifier output |
| `VBIAS` | External bias for tail current source |
| `VDD` | Positive power supply (1.8 V) |
| `VSS` | Ground reference |

---

## Design Specs (Typical 180 nm)

| Parameter | Target Value | Notes |
|------------|---------------|-------|
| Supply Voltage | 1.8 V | Standard 180 nm low-voltage CMOS |
| DC Gain | 70 – 80 dB | Depends on bias current and load |
| GBW | 5 – 10 MHz | For ~10 pF capacitive load |
| Phase Margin | > 60° | With proper Miller cap sizing |
| Input Common Mode Range | 0.3 – 1.2 V | Nominal bias |
| Output Swing | 0.2 – 1.6 V | Typical single-ended output |
| Tail Current | 10 – 15 µA | Set via `VBIAS` |

 `VBIAS` ≈ 0.7–0.9 V for ~10 µA tail current.



## 🧑‍🔬 Author

**Analog Design Engineer - lead/staff**  
Lead: **Arnab Saha**  
Focus: Analog Accelerators, FPAAA-based Adaptive Hardware, and AI Compute IPs  
