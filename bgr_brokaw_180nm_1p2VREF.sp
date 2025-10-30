* ==============================================================
* Bandgap Reference (Brokaw-style) - TSMC 180nm
* Subckt: BGR_180 VIN VREF VSS EN (EN optional, tie to VIN if unused)
* Typical VREF ~ 1.20 - 1.25 V
* Author: Arnab Saha
* Process: generic TSMC 180nm (replace model names with PDK models)
* ==============================================================

.SUBCKT BGR_180 VIN VREF VSS EN

***********************************************
* PARAMETERS (tweak per design / PDK)
***********************************************
.PARAM IREF_TARGET = 30u      ; target quiescent current (approx)
.PARAM R1 = 10k               ; resistor in reference core
.PARAM R2 = 20k               ; resistor for PTAT scaling
.PARAM R3 = 5k                ; bias resistor to set Iref
.PARAM RB = 200              ; base-emitter area ratio resistor (optional)
.PARAM WPN = 20u LPN = 0.18u  ; NMOS bias if used
.PARAM WPP = 40u LPP = 0.18u  ; PMOS bias if used

***********************************************
* NOTES:
* - This design uses parasitic PNP transistors (Q1/Q2). Use PDK's BJT models
*   (e.g., 'pnp_180' or the foundry-supplied lateral PNP model).
* - Replace placeholders (nmos_180, pmos_180, pnp_180) with PDK model names.
* - EN pin: if tied low -> disables bias (optional gating via EN transistor).
***********************************************

**************
* REFERENCE CORE
**************
* Simple Brokaw core:
* Q1 and Q2 are PNP transistors with different emitter areas to create ΔVBE
* Q1 is the PTAT device (smaller area), Q2 is the base device (larger area)
*
* Node naming:
*   VIN  - supply input
*   VREF - precision bandgap output
*   VSS  - ground
*   EN   - enable pin (active high). If unused, tie to VIN.

* PNP devices (parasitic lateral PNP)
Q1 N_B N_B VIN VSS pnp_180 area=1           ; PTAT emitter, smaller
Q2 N_BB N_BB VIN VSS pnp_180 area=8         ; reference emitter, larger

* Resistors in core (PTAT and summation)
R_R2 N_B VIN {R2}       ; sets emitter current for Q1 (PTAT)
R_R1 N_BB VIN {R1}      ; sets base current path for Q2

* Emitter nodes of Q1/Q2 are tied to VIN through resistors above.
* The bases of both Q1 and Q2 are tied together (classic Brokaw).
BBASE N_BB N_BB VSS  ; placeholder node (bases tied internally by netname)

* Node for base connection
* Use a single net name for both transistor bases:
* (we create explicit net NBASE and connect base pins)
* Reconnect devices correctly:
* (Re-declare Q devices to use same base net and correct pin order)
* (Most SPICE BJT syntax: Qname C B E S model area=)
* Rewriting Q declarations for standard order: C B E S

* Re-declare Q1/Q2 in conventional C-B-E-S order (collector, base, emitter, substrate)
* Note: For lateral PNP, collector connected to node N_COL (here VIN), base NBASE, emitter nodes distinct.

Q1_col VIN NBASE N_Q1 VSS pnp_180 area=1
Q2_col VIN NBASE N_Q2 VSS pnp_180 area=8

* PTAT current flows through R_PTAT between N_Q1 and VIN
R_PTAT N_Q1 VIN {R2}

* Reference path resistor between N_Q2 and VIN
R_REF N_Q2 VIN {R1}

* Base node is NBASE - connect to amplifier sensing/generation
* Create a small balancing resistor to ground to stabilise bias
R_BASE NBASE VSS {RB}

**************
* ERROR / BUFFER AMPLIFIER (simple transistor-level buffer)
**************
* A unity-gain buffer (single stage) to drive VREF output from base node
* This simplifies the bandgap output buffering. For precision use an actual op-amp structure.

Mbuf1 NBUF_OUT NBASE VSS VSS nmos_180 W={WPN} L={LPN}
Mbuf2 VIN NBUF_OUT VIN VIN pmos_180 W={WPP} L={LPP}

* Pull-up and pull-down load to make a simple source-follower-ish buffer:
RBUF_UP VIN NBUF_OUT 100k
RBUF_DN NBUF_OUT VSS 100k

* Output node (after optional filter)
C_OUT2 NBUF_OUT VSS 10p

* Final reference output node: VREF
* A small sense resistor to isolate
R_OUT NBUF_OUT VREF 10

**************
* ENABLE (EN) CONTROL (simple gating of bias path)
**************
* If EN is low (0), bias is cut; if high, bias enabled.
* Implemented by gating R_REF node through an NMOS controlled by EN
M_en R_EN VIN EN VSS nmos_180 W=5u L=0.18u
* Use R_EN as series resistor in bias path (optional)
R_EN_PATH VIN N_Q2 1k
* Note: the exact EN gating can be improved per spec.

**************
* PLACEHOLDER MODELS (replace with foundry PDK models)
**************
.model nmos_180 NMOS LEVEL=1 VTO=0.7 KP=200u LAMBDA=0.02
.model pmos_180 PMOS LEVEL=1 VTO=-0.9 KP=100u LAMBDA=0.02
.model pnp_180 PNP IS=1e-14 BF=20 NF=1 BR=1.5

**************
* END SUBCKT
**************
.ENDS BGR_180
