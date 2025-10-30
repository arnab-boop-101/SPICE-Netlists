* ==============================================================
* LDO REGULATOR — 1.8V INPUT → 1.2V OUTPUT  (TSMC 180nm CMOS)
* Author: Arnab Saha
* Process: Generic TSMC 180nm
* ==============================================================
* Node Naming Convention:
* VIN     : Input supply (1.8 V)
* VOUT    : Regulated output (1.2 V target)
* VREF    : Reference voltage (0.5 V)
* VERR    : Error amplifier output (gate of PMOS pass device)
* VSS     : Ground
* ==============================================================
* External Connections:
*   .SUBCKT LDO_1V2 VIN VOUT VREF VSS
* ==============================================================

.SUBCKT LDO_1V2 VIN VOUT VREF VSS

***************
* PARAMETERS
***************
.PARAM VDD=1.8
.PARAM VREFVAL=0.5
.PARAM WPMOS_PASS=300u
.PARAM LPMOS_PASS=0.18u
.PARAM WN_AMP=10u
.PARAM LN_AMP=0.18u
.PARAM WP_AMP=20u
.PARAM LP_AMP=0.18u

***************
* ERROR AMPLIFIER (Two-stage Opamp)
***************
* Differential input: (VREF, feedback from VOUT)
* Output drives gate of PMOS pass device

M1 N1 VREF VERR VSS nmos_180 W={WN_AMP} L={LN_AMP}
M2 N2 VOUT VERR VSS nmos_180 W={WN_AMP} L={LN_AMP}
M3 N1 N1 VIN VIN pmos_180 W={WP_AMP} L={LP_AMP}
M4 N2 N2 VIN VIN pmos_180 W={WP_AMP} L={LP_AMP}

* Active load current mirror
M5 VERR N1 VIN VIN pmos_180 W={WP_AMP} L={LP_AMP}

* Compensation capacitor
Ccomp VERR VSS 10p

***************
* PMOS PASS DEVICE
***************
M_PASS VOUT VERR VIN VIN pmos_180 W={WPMOS_PASS} L={LPMOS_PASS}

***************
* FEEDBACK NETWORK
***************
R1 VOUT VFB 100k
R2 VFB VSS 50k
* Feedback voltage = (R2 / (R1 + R2)) * VOUT = 0.4 * VOUT ≈ 0.48V for 1.2V VOUT

***************
* REFERENCE INPUT
***************
VREFSRC VREF VSS DC {VREFVAL}

***************
* LOAD CAPACITOR & RESISTOR
***************
CLOAD VOUT VSS 1u
RLOAD VOUT VSS 60   ; ≈20 mA load current at 1.2V

***************
* END SUBCKT
***************
.ENDS LDO_1V2

* ==============================================================
* Example instantiation (commented out — for your ADE testbench)
* X1 VIN VOUT VREF VSS LDO_1V2
* VDD VIN 0 DC 1.8
* VSS 0 0
* .LIB 'tsmc018.lib' TT
* .END
* ==============================================================
