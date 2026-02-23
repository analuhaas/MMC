# MMC phase test in open-loop
### [Task 1] 3rd CARROTS Hackathon - Grenoble

## Objectives and context

## Required Hardware list
- 11 TWIST boards with SPIN
- 2 DC power supplies of 6 V with minimum 2 A
- 1 DC power supply of (48 V, 5 A)
- Protection diode (at least 100 V)
- 2 resistors of 15 $\Omega$
- 10 ethernet cables
- PC 64-bits (windows or linux)
- Oscilloscope
- Current probes
- BNC adaptors to differential voltage measurement or differential probes

## Required Software list
- Git
- Visual Studio Code with PlatformIO 

## Get base code from VScode

First, we need to load the base code from the stack test with CVB in the OwnTech example repository version in https://github.com/analuhaas/examples 
1.	In VScode, open the folder where you previously cloned OwnTech’s github.
2.	In platformio.ini file, substitute the owntech_examples variable link by https://github.com/analuhaas/examples.git 
3.	Go to platform.io icon <img width="34" height="36" alt="image" src="https://github.com/user-attachments/assets/7e95c1b1-b0ee-473a-b434-a95adbce17a5" />, go to Examples Twist under the Project Tasks tab and click on “MMC arm – with CVB”.

<img width="456" height="358" alt="image" src="https://github.com/user-attachments/assets/295e63d3-559a-4d32-9f65-5078789b8511" />

4.	Now you have the good code to start in your VScode.

## WP1 Task 3.1: Stack Hardware setup

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

## WP1 Task 3.2: Phase test using phase circuit#1

## WP1 Task 3.3: Phase test using phase circuit#2

## WP1 Task 3.4: Phase test using phase circuit#3

## WP1 Task 3.5: Phase test using phase circuit#4
