*=============================================================
*  CMOS Two-Stage Operational Amplifier (180nm)
*=============================================================
*  Technology : 180 nm CMOS (typical 1.8 V)
*  Architecture: Differential Input Pair + Active Load
*                Second Stage Common Source + Miller Compensation
*=============================================================

*------------ Power Rails ------------
* Define global supplies for ADE
.global VDD VSS

*------------ I/O Terminals ----------
* VINP  : Non-inverting input
* VINN  : Inverting input
* VOUT  : Amplifier output
* VBIAS : External bias input for tail current source

*------------ Differential Pair Stage ------------
* NMOS Input Pair
M1 N1 VINP NTAIL VSS NMOS L=0.18u W=9u
M2 N2 VINN NTAIL VSS NMOS L=0.18u W=9u

* PMOS Active Load (current mirror)
M3 N1 N1 VDD VDD PMOS L=0.18u W=18u   ; diode-connected load
M4 N2 N1 VDD VDD PMOS L=0.18u W=18u   ; active mirror load

* Output of first stage (single-ended)
* Take from right branch (N2)
* Node name for clarity:
* N2 → internal node between first & second stages

*------------ Second Stage ------------
* Common-Source Amplifier
M5 VOUT N2 VSS VSS NMOS L=0.18u W=18u

* Active PMOS Load
M6 VDD VOUT VDD VDD PMOS L=0.18u W=36u

*------------ Compensation ------------
* Miller Capacitor between Stage 1 output (N2) and Stage 2 output (VOUT)
Ccomp N2 VOUT 2p

*------------ Tail Current Source ------------
* NMOS tail current transistor
M7 NTAIL VBIAS VSS VSS NMOS L=0.36u W=6u

*------------ Bias Circuit (optional) ------------
* You may generate VBIAS from on-chip bias network; external pin for now.

*------------ Load (for connectivity only) ------------
* Dummy resistive load for convergence (remove in schematic)
RLOAD VOUT VSS 1Meg

*------------ Device Models ------------
* Replace below models with foundry PDK models in ADE.
.model NMOS NMOS (LEVEL=1 VTO=0.7 KP=200u LAMBDA=0.02)
.model PMOS PMOS (LEVEL=1 VTO=-0.9 KP=100u LAMBDA=0.02)

*------------ End of File ------------
.END
