# Low-frequency test simulation in Simulink with TWIST-based MMC module model

## Context

In this simulation we reproduce the experimental test of a individual MMC module operation in all its states in low frequency. The experimental test has the circuit structure below. $R_{dec}$ resistance is connected in parallel to the module in order to emulate negative currents discharging the module capacitor.

<img width="950" height="337" alt="image" src="https://github.com/user-attachments/assets/de5827ad-cbf8-4072-86f0-27bafe5b573d" />

A TWIST board is used as a HB module of the MMC by programming its second leg (LEG2) to be deactivated, having the following circuit. Observe that the HIGH terminals are open (Vhigh to GND).

<img width="930" height="292" alt="image" src="https://github.com/user-attachments/assets/10807b55-72c9-4e88-b6c3-b971613964ae" />

The test consists of putting the module M1 in Disconnected, Connected and Blocked states according to the correspondence table below:

<img width="1296" height="251" alt="image" src="https://github.com/user-attachments/assets/5c430161-335f-41b3-bf52-ce9dba61e553" />

All these different states are illustrated in the figure below according to the current sign:

<img width="1132" height="487" alt="image" src="https://github.com/user-attachments/assets/8c45f5c7-c54d-4904-96c9-5d7b672d05bf" />

The figure below shows the low-frequency test sequence applied to the module with its expected results. Notice that DC power supply is activated at 0s and deactivated at 0.45 s. Notice that the inductor $L_1$ and capacitor $C_{1Low}$ in the low-side of the TWIST module where added to the module representation.

<img width="945" height="332" alt="image" src="https://github.com/user-attachments/assets/2c0c8ff6-9a88-4c1d-b548-b751c5b41702" />

## Simulink Circuit

The Simulink

## Inputs

## Outputs

## Executing the simulation
