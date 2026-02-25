# MMC phase test in open-loop (Task 3 of 3rd CARROTS Hackathon - Grenoble)

## Objectives and context

The objective of this task if to build a MMC phase considering that we already have two MMC stacks of 5 modules (one from GeePs and one from LAAS).

<img width="350" height="569" alt="WP1Hackathon_objective" src="https://github.com/user-attachments/assets/2fd0f94b-d88b-4281-a67d-d3690338cbe5" />

To do it we have to overcome some issues identified during the 1A work:

### Issue #I1 - Presence of low-side filter

The low-side filter formed by L1 and Clow1 causes oscillations in the generated stack voltage

#### Proposition #P1c - Counter oscillations with ramping switching duty cycle

A software only solution is to do a gradual increase of the duty cycle in the transition between disconnected and connected state of one module.

### Issue #I2 - High frequency oscillations in ILow1 current measure

The fact that the current measure is made between Clow1 and L1 causes the measurement to oscillate at high frequency.

#### Proposition #P2b - External sensor connected to the SPIN

Ideally, we would need a measurement unit to be connected to the TWIST/SPIN to supply the measurement. To avoid implementing the complete solution, we can emulate the idea by using a always bypassed module connected to the stack. This module can even be the Central Controller module.

<img width="350" height="484" alt="MMC_arm_test_theoric_electrical_circuit_withCC" src="https://github.com/user-attachments/assets/ba956e8a-74b2-45dc-8999-a29053da289c" />

### Issue #I3 – Bootstrap circuit

The bootstrap capacitor discharges becauses it does not sustain operation at 50 Hz, causing the module to pass from connected to blocked state.

#### Proposition #P3c - Operate in switch mode with connected state at duty cycle 0.95

A software only solution is to operate at duty cycle 0.95 instead of 1 during connected state to avoid bootstrap capacitor discharge.

### Issue #I4 - Capacitor module too small for operation at 50 Hz

The high-side capacitor Chigh capacitance is of 188.4 µF, which is too small for 50 Hz operation.

#### Proposition #P4c - Increasing module capacitance

To do some of our test, we will need to increase the module capacitance by connecting capacitors in parallel to Vhigh and GND terminals of the module's boards.

### Issue #I6 - Not possible to feed digital 6 V in series

It is for now not possible to feed the digital 6 V in series due to fuses position:

<img width="350" height="506" alt="image" src="https://github.com/user-attachments/assets/fd49fcc0-f103-41ab-a1d2-4157646520d0" />

### Proposition #P6 - Improve the digital 6 V external supply configuration

Basically we can make the 6 V supply in series if we change the fuse position:

<img width="350" height="506" alt="MMC_6V_supply_series_modified" src="https://github.com/user-attachments/assets/74429f85-3bb0-4e70-9275-d5c2b8172429" />


## Required Hardware list
- 11 TWIST boards with SPIN (extra 5 if necessary?)
- 2 DC power supplies of 6 V with minimum 2 A
- 2 DC power supply of (48 V, 5 A)
- 2 Protection diodes (at least 100 V)
- 2 DC bus capacitors around 4500 µF
- 2 stack inductances around 50 mH
- 1 variable resistor
- 10 ethernet cables
- PC 64-bits (windows or linux)
- Oscilloscope
- Current probes (10 A peak-to-peak, 10 kHz)
- Differential probes for voltage measurements

## Required Software list
- Git
- Visual Studio Code with PlatformIO 

## Get base code from VScode

First, we need to load the base code from the stack test with CVB in the OwnTech example repository version in https://github.com/analuhaas/examples 
1.	In VScode, open the folder where you previously cloned OwnTech’s github.
2.	In platformio.ini file, substitute the owntech_examples variable link by https://github.com/analuhaas/examples.git 
3.	Go to platform.io icon <img width="34" height="36" alt="image" src="https://github.com/user-attachments/assets/7e95c1b1-b0ee-473a-b434-a95adbce17a5" />, go to Examples Twist under the Project Tasks tab and click on “MMC arm – with CVB”.

<img width="300" height="235" alt="image" src="https://github.com/user-attachments/assets/295e63d3-559a-4d32-9f65-5078789b8511" />

4.	Now you have the good code to start in your VScode.

## WP1 Task 3.1: Stack Hardware setup
#### Subtask objective: Verify if stacks are still working individually.

Repeat for the upper and lower stacks:

5.	Connect the modules boards in series using VLOW1 and GND terminals to form an MMC stack using banana cables (figure below).
7.	Connect each module to the External Auxiliary DC Power Supply to the TWIST via the 6 V and DGND PINs. Make sure that the External Auxiliary DC Power Supply is configured to deliver 6 V with limiting current of 2 A. Make sure the power supply OUTPUT IS OFF (figure below).
8.	Connect the boards using ethernet cables as in the image (figure below).
9.	Connect the stack to the main DC power supply, R and Rdec resistances and diode (figure below).

<img width="804" height="700" alt="image" src="https://github.com/user-attachments/assets/267497c6-c74f-442c-b332-5ae715eeec2e" />

9.	Connect the voltage and current measurements with the oscilloscope.
10.	Configure your Oscilloscope (PicoScope or other).
11.	Test the stack using the CVB code with circuit #1.
    - Get the correct test code using “MMC arm – with CVB”  button.
    - Repeat to all 5 module boards M1, M2, M3, M4, M5:
      * Connect the board to the PC via a USB-C cable.
      * Build <img width="26" height="26" alt="image" src="https://github.com/user-attachments/assets/4b1113ad-539e-43b8-b027-26ed47c0ba9f" /> and Upload <img width="40" height="31" alt="image" src="https://github.com/user-attachments/assets/2d3610c6-f896-49e7-bcda-5db36a032896" /> the code main.cpp into the board.
      * Open the serial monitor and copy the board ID to the identification list in the code according to its function in the stack
        <img width="515" height="245" alt="image" src="https://github.com/user-attachments/assets/19cb6637-ec63-4e6f-a469-4d22c07fd88f" />

      * Do again: Build <img width="26" height="26" alt="image" src="https://github.com/user-attachments/assets/4b1113ad-539e-43b8-b027-26ed47c0ba9f" /> and Upload <img width="40" height="31" alt="image" src="https://github.com/user-attachments/assets/2d3610c6-f896-49e7-bcda-5db36a032896" /> the code main.cpp into the board.
    - Build <img width="26" height="26" alt="image" src="https://github.com/user-attachments/assets/4b1113ad-539e-43b8-b027-26ed47c0ba9f" /> and Upload <img width="40" height="31" alt="image" src="https://github.com/user-attachments/assets/2d3610c6-f896-49e7-bcda-5db36a032896" /> the code main.cpp into the Central Controller board.
    - Make sure the External Auxiliary DC Power Supply is configured to deliver 6 V with limiting current at max 2 A. TURN ON the External Auxiliary DC Power Supplies output.
    - After the capacitor voltages comes back to 0, TURN ON the main power supply $u_{dc}$.
    - After the modules are charged with stable voltages more and less at the same level, click “p” to start stack operation with NLM (with CVB).
    - After 20 s, TURN OFF the main power supply $u_{dc}$.
    - Click “i” to stop stack operation and put all boards in IDLE mode (blocked state).
    - TURN OFF all 6V External Auxiliary DC Power Supplies.

## WP1 Task 3.2: Phase test using phase circuit#1 (no current)

#### Subtask objective: Verify if stack voltages are well generated, having stepped waveform, and well synchronized, having 180° phase-shift.


<img width="300" height="639" alt="MMC_phase_test_circuit1_theoric_electrical_circuit (1)" src="https://github.com/user-attachments/assets/2141b051-88c0-4b76-a64e-02be3ce04db8" />

MMC Data:

- $𝑢_{𝑑𝑐} = 48 𝑉$
- $𝑓=50 𝐻𝑧$
- $𝐶=𝐶_{𝐻𝑖𝑔ℎ}=188,4 \mu 𝐹$

By performing simulation with [phase circuit#1 simulink](https://github.com/analuhaas/MMC/tree/tutorials_updates/MMC_models/Phase/TWIST_based/circuit1) we obtain the following simulation results:
- There is only current for charging capacitors. Less than 1 A on the stack ($𝑖_{𝑢,𝑝}$ and $𝑖_{𝑙,𝑝}$)
- Open circuit = No AC phase current

<img width="1275" height="583" alt="image" src="https://github.com/user-attachments/assets/69d8366c-bdd3-4642-b6b2-55a1436de936" />


## WP1 Task 3.3: Phase test using phase circuit#2 (AC current)
#### Subtask objective: Verify if a AC current proportional to AC voltage is generated.

<img width="300" height="639" alt="MMC_phase_test_circuit2_theoric_electrical_circuit (1)" src="https://github.com/user-attachments/assets/33474dd4-71ba-4660-9fdf-43f3c3c99929" />

MMC Data:

- $𝑢_{𝑑𝑐} = 48 𝑉$
- $𝑓=50 𝐻𝑧$
- $𝐶=𝐶_{𝐻𝑖𝑔ℎ}=188,4 \mu 𝐹$
- $𝑅=15 \Omega$

By performing simulation with [phase circuit#2 simulink](https://github.com/analuhaas/MMC/tree/tutorials_updates/MMC_models/Phase/TWIST_based/circuit2) we obtain the following simulation results:
- AC phase current present but not sinusoidal
- AC phase current has same format as AC voltage (resistance load)
- Only positive currents on the stacks due to protection diodes

<img width="6201" height="2835" alt="Circuit2_f50Hz_duty095_Chigh188muF_isigma" src="https://github.com/user-attachments/assets/53187dc5-df82-44e4-b5dc-5c311b8cf09f" />

## WP1 Task 3.4: Phase test using phase circuit#3  (Negative stack currents)
#### Subtask objective: Verify if the stack currents achieves negative values.

<img width="300" height="639" alt="MMC_phase_test_circuit3_theoric_electrical_circuit (1)" src="https://github.com/user-attachments/assets/f626162a-e4a0-4c2d-b192-12da25898ed0" />

MMC Data:

- $𝑢_{𝑑𝑐} = 48 𝑉$
- $𝑓=50 𝐻𝑧$
- $𝐶=𝐶_{𝐻𝑖𝑔ℎ}=188,4 \mu 𝐹$ or $𝐶=1868,4 \mu 𝐹$
- $𝑅=15 \Omega$
- $𝐶_{𝑏𝑢𝑠}=4400 \mu 𝐹$

By performing simulation with [phase circuit#3 simulink](https://github.com/analuhaas/MMC/tree/tutorials_updates/MMC_models/Phase/TWIST_based/circuit3) we obtain the following simulation results:
- Negative currents but too much oscillations, probably due to fast current demand (small C) and switching harmonics
- Harmonics also present on $i_Sigma$ current
- Improved voltage and current outputs
  
<img width="6201" height="2835" alt="Circuit3_f50Hz_duty095_Chigh188muF_isigma" src="https://github.com/user-attachments/assets/f16e4df0-a792-4d23-ab61-bb77071de245" />

We tried to increment the module capacitance from $𝐶=𝐶_{𝐻𝑖𝑔ℎ}=188,4 \mu 𝐹$ to $𝐶=1868,4 \mu 𝐹$ and obtained these results:
- Increasing C reduced oscillations but  stack current still have switching harmonics
- Switching Harmonics still present on $i_Sigma$ current but reduced
  
<img width="6201" height="2835" alt="Circuit3_f50Hz_duty095_Chigh1800muF_isigma" src="https://github.com/user-attachments/assets/34e626a9-edac-4f8f-ab22-068dea0f6d8e" />


## WP1 Task 3.5: Phase test using phase circuit#4 (Filtered AC current)
#### Subtask objective: Verify if the stack currents are sinusoidal and if a AC sinusoidal current is generated.

<img width="300" height="639" alt="MMC_phase_test_circuit4_theoric_electrical_circuit (2)" src="https://github.com/user-attachments/assets/b57a9449-8169-4c1b-b5f0-d65b16265987" />
MMC Data:

- $𝑢_{𝑑𝑐} = 48 𝑉$
- $𝑓=50 𝐻𝑧$
- $𝐶=𝐶_{𝐻𝑖𝑔ℎ}=188,4 \mu 𝐹$ or $𝐶=1868,4 \mu 𝐹$
- $𝑅=15 \Omega$
- $𝐶_{𝑏𝑢𝑠}=4400 \mu 𝐹$
- $𝐿_{𝑠𝑡𝑎𝑐𝑘}=60 𝑚𝐻$

By performing simulation with [phase circuit#4 simulink](https://github.com/analuhaas/MMC/tree/tutorials_updates/MMC_models/Phase/TWIST_based/circuit4) we obtain the following simulation results:
- Smooth stack current but deformed voltage because capacitors are too small makes charge/discharge fast
- Phase voltage and current almost sinusoidal
- 2 omega Harmonics present on $i_Sigma$ current
  
<img width="6201" height="2835" alt="Circuit4_f50Hz_duty095_Chigh188muF_isigma" src="https://github.com/user-attachments/assets/07366fb0-2299-40c9-8cf9-282450400a25" />

We tried to increment the module capacitance from $𝐶=𝐶_{𝐻𝑖𝑔ℎ}=188,4 \mu 𝐹$ to $𝐶=1868,4 \mu 𝐹$ and obtained these results:
- Smooth current and stepped voltage on stack due to slower capacitor charge/discharge
- Phase voltage and current sinusoidal
- Almost null 2 omega Harmonics on $i_Sigma$ current
  
<img width="6201" height="2835" alt="Circuit4_f50Hz_duty095_Chigh1800muF_isigma" src="https://github.com/user-attachments/assets/74d6f3a2-f7de-4874-a943-10e6035690c2" />


  


