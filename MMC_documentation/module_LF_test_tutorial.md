# Individual MMC module test

## Objectives and context

The goal of this tutorial is to test a individual MMC module operation in all its states in both low and high frequency. For that, we used the circuit structure below. R_{dec} resistance is connected in parallel to the module in order to emulated negative currents discharging the module capacitor.

<img width="950" height="337" alt="image" src="https://github.com/user-attachments/assets/767e4a0e-1f4f-4deb-a81a-e97e42c9170a" />

The board serves as a HB module of the MMC by programming its second leg (LEG2) to be deactivated, having the following circuit. Observe that the HIGH terminals are open (Vhigh to GND).

<img width="930" height="292" alt="image" src="https://github.com/user-attachments/assets/a64b8101-93ff-4cf3-aa89-9a7673162536" />

The tutorial will consist of putting the module M1 in Disconnected, Connected and Blocked states according to the correspondence table below:

<img width="609" height="102" alt="image" src="https://github.com/user-attachments/assets/b40040b7-96c9-4848-abca-fafacb5d3b94" />

The module state is controlled using the board first leg (LEG1) switches Q1 and Q2 command (sw_{Q1} and sw_{Q2}):
Connected state:
- sw_{Q1}=1 (close Q1 MOSFET) and sw_{Q2}=0 (open Q2 MOSFET)
- The module is considered to be connected to the circuit, contributing to the stack with its capacitor voltage and the current pass through its capacitor.
Disconnected state:
- sw_{Q1}=0 (open Q1 MOSFET) and sw_{Q2}=1 (close Q2 MOSFET)
- The module is considered to be bypassed from the circuit having null voltage output and the current does not pass through its capacitor.
Blocked state:
- sw_{Q1}=0 (open Q1 MOSFET) and sw_{Q2}=0 (open Q2 MOSFET)
- Since both switches gate commands are to be turned off, only the MOSFETs anti-parallel diodes conducts. Which diodes conducts will depend only if current sign is positive or negative.

All these different states are illustrated in the figure below according to the current sign:

<img width="1132" height="487" alt="image" src="https://github.com/user-attachments/assets/652a469a-8b22-483e-88c5-8a05e72940e8" />

First, the individual module test is performed in low-frequency and then in high-frequency. The figure below shows the low-frequency test sequence. The user must manually TURN ON the udc power supply to start the sequence first part (positive current) and also TURN OFF udc to start the sequence second part (negative current).

 <img width="1058" height="329" alt="image" src="https://github.com/user-attachments/assets/b372ae91-24dc-4940-bb5d-f31a6c85fc2a" />

The figure below shows the high-frequency test sequence. The user must manually TURN ON the udc power supply to start the sequence first part (positive current) and also TURN OFF udc to start the sequence second part (negative current).

<img width="1196" height="273" alt="image" src="https://github.com/user-attachments/assets/398de20b-e65f-4635-873c-d428c7d0546c" />

## Required Hardware list:
- 1 TWIST boards with SPIN
- DC Power Supply (48 V, 2 A)
- Protection diode (at least 50 V)
- 2 resistors of 15 $\Omega$
- PC 64-bits (windows or linux)
- Oscilloscope
- Current probe
- 2 BNC adaptors to differential voltage measurement or differential probes

## Required Software list:
- Git
- Visual Studio Code with PlatformIO

!!! If not done yet you should have done the initial tutorial on how to setup VScode for OwnTech usage.

## Get tutorial code from VScode

First, we need to load the Single module test code from the OwnTech example repository version in https://github.com/analuhaas/examples 
1.	In VScode, open the folder where you previously cloned OwnTech’s github.
2.	In platformio.ini file, substitute the owntech_examples variable link by https://github.com/analuhaas/examples.git 
3.	Go to platform.io icon  , go to Examples Twist under the Project Tasks tab and click on “Single MMC module – LF test (modified)” or “Single MMC module – HF test (modified)” according to the used test sequence.

<img width="456" height="358" alt="image" src="https://github.com/user-attachments/assets/8f169340-3e0a-42a9-a91e-f5a9272749ab" />

4.	Now you have the good code to execute the tutorial in your VScode.

