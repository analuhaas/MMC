# MMC phase test simulation with open-loop control using CVB algorithm in Simulink with TWIST-based MMC module model (circuit #1)

## Context

In this simulation we reproduce the experimental test of a MMC phase with 5 modules per stack (10 modules in total). The simulation can be either done using circuit 1, circuit 2, circuit 3, or circuit 4 represented in the figure.

<img width="3442" height="2016" alt="circuits_phase_reunis" src="https://github.com/user-attachments/assets/a0cde823-55ab-4fc0-b6b2-ec38cfede754" />

In experiments, a TWIST board is used as a HB module of the MMC by programming its second leg (LEG2) to be deactivated, having the following circuit. Observe that the HIGH terminals are open (Vhigh to GND). This is reproduced in Simulink using the TWIST board model.

<img width="930" height="292" alt="image" src="https://github.com/user-attachments/assets/10807b55-72c9-4e88-b6c3-b971613964ae" />

The test consists of using NLM modulation to connect/disconnect modules in order to generate close to sinusoidal voltage on the phase AC side.

The NLM modulation consists of attributing levels according to the modulation signal amplitude using the function round such that the level attributed to the modulation signal is the nearest integer and its principle is represented here:

<img width="535" height="92" alt="image" src="https://github.com/user-attachments/assets/74da965e-80fd-4cbb-880d-40876b350559" />

For example, if the modulation signal is 2.6, it is going to be attributed to level 3. For the MMC, the modulation signal is a sinusoidal wave, making that the NLM modulation result is a stepped wave-form as shown:

<img width="696" height="477" alt="image" src="https://github.com/user-attachments/assets/01411f54-3f82-4d93-9f90-3989b0d5dcd1" />

This stepped wave-form output of the NLM indicates how many modules should be connected in the upper and lower stacks ($N_{\left(u,l\right),p}^{on}$) according to time.

The modulation signal for upper and lower stacks are dephased of 180° to produce a sinusoidal phase voltage centered in 0.

In this simulation, the modulation is followed by a Capacitor Voltage Balancing (CVB) algorithm that chooses which modules to connect at each stack in order to have equilibrated voltage between all modules. The CVB algorithm makes is choice according to measured capacitor voltages and arm current as described in the algorithm schematic:

<img width="945" height="390" alt="image" src="https://github.com/user-attachments/assets/636c67aa-bcf6-4b46-b763-debafd0bcee2" />

It then generates the command to connect or disconnect the modules by setting the gate command signals ($g_{\left(u,l\right),p}^{M1}$, $g_{\left(u,l\right),p}^{M2}$,..., $g_{\left(u,l\right),p}^{MN}$), to 1 (module connected) or 0 (module disconnected). The complete schematic of the open-loop control implemented:

<img width="677" height="296" alt="image" src="https://github.com/user-attachments/assets/afdb26bc-5e65-4d8c-aae6-403ef0decfac" />


## Simulink Circuit

The Simulink circuit of MMC_phase_hackathon_circuit1_HAAS_20260216.slx represents the experimental test circuit 1 for the phase. Extra capacitances can be added to the module via Vhigh terminals of the modules such as done experimentally.

<img width="851" height="705" alt="image" src="https://github.com/user-attachments/assets/27818971-d585-4545-a4bb-ecbc971a92b1" />

Inside the module block, the TWIST board model is used as programmed like a Half-Bridge (HB) module.

<img width="801" height="602" alt="image" src="https://github.com/user-attachments/assets/15a66fe3-af3d-486c-be73-052481ed3291" />

Inside the control, the NLM modulation is generated using:

<img width="426" height="188" alt="image" src="https://github.com/user-attachments/assets/c73c2ddd-85c2-4add-9d6c-60c2f20bf7ab" />

And the CVB algorithm is composed by first a sorting block (generates the order of the modules with ascending capacitor voltage and the measured current sign) and the algorithm itself (decides the modules to connect). The algorithm is only executed if the number of connected modules demanded by the modulation changes.

<img width="906" height="465" alt="image" src="https://github.com/user-attachments/assets/e45ea0d2-8d91-4546-872b-d23b55b4dcac" />

The CVB algorithm is executing for both upper and lower stacks individually.

## Inputs

The simulation can be configured using the following inputs on the script_MMC_phase_circuit1_twist_20260216.m file:

- Inputs for Twist configuration

```
data_save = false; % true : save data in a .mat file the following data
power_losses = false; % true : takes into account power losses from the MOSFETs / false : no power losses
isInterleaved = false; % true : 180° phase shift between leg 1 and leg 2 / false : 0° phase shift
isC1low1Active = false; % true : Q5 is closed / false : Q5 is open
isC2low1Active = false; % true : Q6 is closed / false : Q6 is open
is6VExternallySupplied = false; % true : 6 V external supply is used to supply auxiliary circuits / false : feeder is used to supply auxiliary circuits
isFeederJumperOpen = false; % true : feeder disconnected from the board circuit / false : feeder can be used
```

- Inputs for simulation configuration

```
latest_sim_name = 'MMC_phase_hackathon_circuit1_HAAS_20260216.slx'; % Simulink simulation to execute
latest_test_parameters = "param_phase_circuit1_HAAS_20260216.m"; % Circuit parameters (udc, R, Rdec, etc...)
latest_twist_parameters = "twist_parameters.m"; % TWIST parameters (specifications from TWIST KICAD or obtained experimentally)
sim_time = 1; % [s] Overall simulation time
t_init_sim = -0.01; % [s] Simulation start time
Ts = 1e-6; % [s] Simulation sample period
```

- Inputs for test sequence configuration

```
time_charge = 0.05; % [s] Modules capacitors charging phase duration
time_decharge = 1; % [s] Start of modules discharge (VDC = 0V turned off)
```

## Outputs

The simulation results can be observed via the scope area or one can plot externally the results by using the simulation output variables:

```
out.i_u : stores upper stack current i_u
out.i_l : stores lower stack current i_l
out.vm_u : stores the upper stack voltage
out.vm_l : stores the lower stack voltage
out.va : stores the phase AC voltage
out.vc_1 : stores module M1 capacitor voltage vc_M1
out.vc_2 : stores module M2 capacitor voltage vc_M2
out.vc_3 : stores module M3 capacitor voltage vc_M3
out.vc_4 : stores module M4 capacitor voltage vc_M4
out.vc_5 : stores module M5 capacitor voltage vc_M5
out.vc_6 : stores module M6 capacitor voltage vc_M6
out.vc_7 : stores module M7 capacitor voltage vc_M7
out.vc_8 : stores module M8 capacitor voltage vc_M8
out.vc_9 : stores module M9 capacitor voltage vc_M9
out.vc_10 : stores module M10 capacitor voltage vc_M10
out.vm_1 : stores module M1 voltage vm_M1
out.vm_2 : stores module M2 voltage vm_M2
out.vm_3 : stores module M3 voltage vm_M3
out.vm_4 : stores module M4 voltage vm_M4
out.vm_5 : stores module M5 voltage vm_M5
out.vm_6 : stores module M6 voltage vm_M6
out.vm_7 : stores module M7 voltage vm_M7
out.vm_8 : stores module M8 voltage vm_M8
out.vm_9 : stores module M9 voltage vm_M9
out.vm_10 : stores module M10 voltage vm_M10
out.vd_u : stores upper protection diode voltage vd_u
out.vd_l : stores lower protection diode voltage vd_l
out.m_u : stores the sinusoidal open-loop reference for upper stack voltage (NLM modulation input)
out.m_l : stores the sinusoidal open-loop reference for lower stack voltage (NLM modulation input)
out.N_u : stores the number of connected modules on the upper stack (NLM modulation output)
out.N_l : stores the number of connected modules on the lower stack (NLM modulation output)
out.i_u_M1_meas : stores upper stack current i_u measured by M1 that is used on the CVB algorithm
out.i_l_M1_meas : stores lower stack current i_l measured by M6 that is used on the CVB algorithm
```

The outputs are saved if data_save option is true in to "sim_results" folder

## Executing the simulation

1.	Clone this repository or download the "circuit1" folder in your PC.
2.	In matlab, go to "circuit1" folder.
3.	Open script_MMC_phase_circuit1_twist_20260216.m file.
4.	Configure your simulation using the script inputs.
5.	Save and run script_MMC_phase_circuit1_twist_20260216.m.

The simulink simulation window will appear and simulation will start

6.	Observe the results via scope our by plotting the saved outputs

