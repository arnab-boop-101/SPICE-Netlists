# SPICE-Netlists
SPICE circuit netlists for analog/AMS IPs from Virtuoso/Spectre
# CMOS Two-Stage Operational Amplifier (180 nm)

This repository contains a transistor-level SPICE netlist of a **two-stage CMOS operational amplifier** designed in **180 nm CMOS technology**.  
It is optimized for integration in analog IP development, mixed-signal SoCs, and educational design studies.

---

## 🧩 Overview

**Architecture:**  
- Differential NMOS input pair with PMOS active mirror load  
- Common-source second gain stage with PMOS active load  
- Miller compensation for frequency stabilization  
- External tail-bias for current control  
- Supply: **1.8 V** typical

This is a clean, simulation-ready reference design suitable for **Cadence Virtuoso ADE**, **Spectre**, **HSPICE**, or **Ngspice** environments.

---

## 📁 File Contents

| File | Description |
|------|--------------|
| `cmos_opamp_180nm.sp` | Base transistor-level SPICE netlist (two-stage CMOS op-amp) |
| `models/` | Folder for technology model cards (to be linked from your 180 nm PDK) |
| `README.md` | Documentation for design usage and integration |

---

## ⚙️ Node and Port Summary

| Node | Description |
|------|--------------|
| `VINP` | Non-inverting input |
| `VINN` | Inverting input |
| `VOUT` | Amplifier output |
| `VBIAS` | External bias for tail current source |
| `VDD` | Positive power supply (1.8 V) |
| `VSS` | Ground reference |

---

## 🧠 Design Specs (Typical 180 nm)

| Parameter | Target Value | Notes |
|------------|---------------|-------|
| Supply Voltage | 1.8 V | Standard 180 nm low-voltage CMOS |
| DC Gain | 70 – 80 dB | Depends on bias current and load |
| GBW | 5 – 10 MHz | For ~10 pF capacitive load |
| Phase Margin | > 60° | With proper Miller cap sizing |
| Input Common Mode Range | 0.3 – 1.2 V | Nominal bias |
| Output Swing | 0.2 – 1.6 V | Typical single-ended output |
| Tail Current | 10 – 15 µA | Set via `VBIAS` |

---

## 🧪 Usage Notes

1. **Link the PDK models:**  
   Replace the placeholder `.model` statements with your 180 nm foundry NMOS/PMOS model files.

2. **Bias setup:**  
   - Connect a bias network or DC source to `VBIAS` to set the tail current (`M7`).  
   - Typical `VBIAS` ≈ 0.7–0.9 V for ~10 µA tail current.

3. **Simulation in ADE:**  
   - Import `cmos_opamp_180nm.sp` into a schematic symbol or testbench.  
   - Define `VDD`, `VSS`, `VINP`, `VINN`, `VOUT`, and `VBIAS` pins.  
   - Configure `.dc`, `.ac`, `.tran` analyses in ADE (no embedded `.op`/`.ac` in the netlist).  

4. **Compensation:**  
   The compensation capacitor (`Ccomp`) is defaulted to **2 pF**; adjust based on load and target bandwidth.

---

## 🧱 Future Extensions

- **Cascode Op-Amp** (higher gain, better PSRR)  
- **Folded-Cascode Architecture** (wider input range, better CMRR)  
- **Class-AB Output Stage** (for larger capacitive loads)  
- **On-Chip Bias Generator** for self-contained biasing

---

## 📜 License

This design is released under the **MIT License**, allowing reuse and modification for research and educational purposes.  
For commercial IP adaptation, please contact **Vellex Computing**.

---

## 🧑‍🔬 Author

**Analog Design Team – Vellex Computing**  
Lead: **Arnab Saha**  
Focus: Analog Accelerators, FPAAA-based Adaptive Hardware, and AI Compute IPs  
