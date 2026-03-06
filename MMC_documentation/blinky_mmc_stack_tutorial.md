# Blinky MMC stack

## Objectives

The goal of this tutorial is to do a first MMC stack without using power with the following structure:

<img width="945" height="362" alt="image" src="https://github.com/user-attachments/assets/234ecd67-7ccf-4750-a6f6-b0edc3febc43" />

The main board serves as the central controller in the classical structure of the MMC. It will generate a connection sequence going from 0 to 3 that indicates how many modules should be connected. Then, it choses which modules to connect according to the preset preference order M1 → M2 → M3.

Then, the main board sends the connection commands g1, g2 and g3 via the Ethernet cables to the M1, M2 and M3 boards. If the board receives the command to be connected, it turns ON its SPIN board LED. If the board receives the command to be disconnected, it turns OFF its SPIN board LED.

## Required Hardware

•	4 TWIST boards with SPIN

•	DC Power Supply (48 V, 2 A)

•	3 Ethernet cables (RJ45)

•	Cables to connect with the power supply

•	PC 64-bits (windows or linux)

## Required Software

•	Git

•	Visual Studio Code with PlatformIO 

## Get tutorial code from VScode

First, we need to load the Blinky MMC stack code from the OwnTech example repository version in https://github.com/analuhaas/examples 
1.	In VScode, open the folder where you previously cloned OwnTech’s github.
2.	In platformio.ini file, substitute the owntech_examples variable link by https://github.com/analuhaas/examples.git 
3.	Go to platform.io icon  , go to Examples Twist under the Project Tasks tab and click on “Blinky MMC arm”.

 <img width="200" height="157" alt="image" src="https://github.com/user-attachments/assets/8a7caae0-2a27-446f-ae00-dbf916f47d0d" />

4.	Now you have the good code to execute the tutorial in your VScode.

## Hardware setup

5.	Connect the 4 TWIST/SPIN board with the DC power supply as in the image below.
6.	Connect the 4 TWIST/SPIN boards together via ethernet cables to enable communication as in the image below.
7.	Connect the Main TWIST/SPIN board with the PC as in the image below using a USB to USB-C cable.

<img width="625" height="660" alt="image" src="https://github.com/user-attachments/assets/396315c0-ee05-4be6-b214-d3c99f068b60" />

After making the connections and connecting the PC to the main with the USB-C cable, you should have something like this:
<img width="655" height="491" alt="image" src="https://github.com/user-attachments/assets/f00e40d0-d8cd-466b-9989-639ec222e86c" />

<img width="758" height="85" alt="image" src="https://github.com/user-attachments/assets/c70de4ea-1be1-4e34-bf1d-82dbfb5c7316" />

## Executing the tutorial

8.	Optional: Change switching frequency using sw_period variable (default 10000 equivalent to 1 Hz)
9.	Repeat for all 4 boards:
    - Build <img width="26" height="26" alt="image" src="https://github.com/user-attachments/assets/b76afa22-1370-44ea-b8a6-de654ba3a3ac" />
and Upload <img width="40" height="31" alt="image" src="https://github.com/user-attachments/assets/dfe091d8-802c-462d-b31b-6450e9c9158b" /> main.ccp code to the board changing the variable module_ID to MMC_LEAD, MMC_SM1, MMC_SM2 or MMC_SM3 according to the board function.

```
/* --------------USER VARIABLES DECLARATIONS------------------- */

/* TODO : Define module_ID depending on the ID of the board */
uint8_t module_ID = MMC_SM1; // The ID of the module, can be set to MMC_LEAD or any other SMx
```

10.	Open the serial monitor using the   icon with USB-C cable connected with the master, as shown in the hardware setup.
11.	Press h to display the help menu.
12.	Turn on the power supply around 15 V to power the 4 SPIN boards. The main and M1, M2 and M3 boards starts in IDLE mode.
13.	Press p to switch to POWER mode and the modules LEDs will start to light up and off according to the connection sequence.
14.	Press i to switch to IDLE mode and stop the stack operation.
15.	Turn off the power supply.

## Expected results during POWER mode

https://github.com/user-attachments/assets/b48dbae1-9d3b-4fd4-9842-21abe6c78a97


