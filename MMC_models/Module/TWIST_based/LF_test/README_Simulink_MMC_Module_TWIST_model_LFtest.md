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

The Simulink circuit of MMC_1module_twist_LF_20260219.slx represents the experimental test circuit. Inside the Twist power block, the TWIST board is modelled considering its power block + feeder behaviors.

<img width="1103" height="683" alt="image" src="https://github.com/user-attachments/assets/8393dcc1-0419-4a97-8318-50f23ab44110" />

The low-frequency sequence is generated using logic blocks:

<img width="1220" height="484" alt="image" src="https://github.com/user-attachments/assets/3ffb8381-d6d6-45ed-94df-bf860d8b4c44" />

## Inputs

The simulation can be configured using the following inputs on the script_MMC_1module_twist_LF_20260219.m file:

- Inputs for Twist configuration

```
data_save = false; % true : save data in a .mat file the following data
power_losses = false; % true : takes into account power losses from the MOSFETs / false : no power losses
isInterleaved = false; % true : 180° phase shift between leg 1 and leg 2 / false : 0° phase shift
isC1low1Active = false; % true : Q5 is closed / false : Q5 is open
isC2low1Active = false; % true : Q6 is closed / false : Q6 is open
is6VExternallySupplied = false; % true : 6 V external supply is used to supply auxiliary circuits / false : feeder is used to supply auxiliary circuits
isFeederJumperOpen = false; % true : feeder disconnected from the board circuit / false : feeder can be used
C1low_variable = false; % true : feeder disconnected from the board circuit / false : feeder can be used
```

- Inputs for simulation configuration

```
latest_sim_name = 'MMC_1module_twist_LF_20260219.slx'; % Simulink simulation to execute
latest_test_parameters = "test_parameters.m"; % Circuit parameters (udc, R, Rdec, etc...)
latest_twist_parameters = "twist_parameters.m"; % TWIST parameters (specifications from TWIST KICAD or obtained experimentally)
sim_time = 1; % [s] Overall simulation time
t_init_sim = -0.01; % [s] Simulation start time
Ts = 1e-6; % [s] Simulation sample period
```

- Inputs for low-frequency sequence configuration

```
t1 = 0.1; % [s] Sequence time t1 (default 0.1)
t2 = 0.2; % [s] Sequence time t2 (default 0.2)
t3 = 0.7; % [s] Sequence time t3 (default 0.7)
t4 = 0.8; % [s] Sequence time t4 (default 0.8)
Vdc_off_time = 0.45; %[s] Time where VDC = 0V
Vdc_on_time = 0; %[s] Time where VDC = 40V
```

## Outputs

The simulation results can be observed via the scope area or one can plot externally the results by using the simulation output variables:

```
out.modules : contains module current i_M1, module capacitor voltage Vc_M1 and module voltage Vm_M1
out.bus_dc : contains protection diode voltage v_D, DC current i_dc and DC power supply voltage v_dc
```

The outputs are saved if data_save option is true in to "sim_results" folder

## Executing the simulation

1.	Clone this repository or download the "LF_test" folder in your PC.
2.	In matlab, go to "LF_test" folder.
3.	Open script_MMC_1module_twist_LF_20260219.m file.
4.	Configure your simulation using the script inputs.
5.	Save and run script_MMC_1module_twist_LF_20260219.m.

The simulink simulation window will appear and simulation will start

6.	Observe the results via scope our by plotting the saved outputs
