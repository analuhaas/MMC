%% Clean everything
clear all; clc; close all;

%% Sequence and Twist configuration

data_save = false; % true : save in a .mat file the following data : duty / VHigh / V1Low / V2Low / IHigh / I1Low / I2Low
power_losses = false; % true : takes into account power losses from the MOSFETs / false : no power losses
isInterleaved = false; % true : 180° phase shift between leg 1 and leg 2 / false : 0° phase shift
HaveChargingPhase = false;
isC1low1Active = false;
isC2low1Active = false;
is6VExternallySupplied = true;
isFeederJumperOpen = true;
isDutyCycleRamp = false;
C1low_variable = false;

% Initialize times and frequencies
twist_freq_data_sampling = 20e3; %data sampling frequency
twist_data_sampling_period = 1/twist_freq_data_sampling; %data sampling delay
twist_data_acquisition_delay = 50e-9; %data acquisition at the peak of the carry

%% Simulation configuration

latest_sim_name = 'MMC_stack_centralized_HAAS_20260927.slx';

latest_twist_parameters = "twist_parameters.m";

sim_time = 1.5; %overall simulation time
t_init_sim = 0; % [s] Simulation start time
% Ts = 5e-7; % [s] Simulation sample period
Ts = 1e-6; % [s] Simulation sample period

time_charge = 0.1; % [s] Charging time. Until time_charge, the capacitors charges passively - used only if HaveChargingPhase = true
time_decharge = 1.5; % [s] Discharging time, its the time where VDC is turned off and capacitors starts to discharge

duty_cycle = 1.0;

%% Communication model parameters 
Tcom   = 10e-6;     % Time of communication
Nnodes = 5;        % Number of module communicating
Tcom_sample = round(Tcom / Ts);

if abs(Tcom_sample - round(Tcom_sample)) < 1e-12
    Kcom = round(Tcom_sample);
else
    Kcom = ceil(Tcom_sample); % In case Tcom is not a integer multiple of Ts
end

%% Hardware model parameters (twist + MMC)

run(latest_twist_parameters);

if(is6VExternallySupplied == false)
    feeder_current_lower_rate_limit = -300;
else
    feeder_current_lower_rate_limit = -10;

end

% Circuit parameters
VDC = 48; % [V] DC voltage
f0 = 50; % [Hz] Electrical frequency
L_arm = 30e-3; % [H] Arm inductance
R_arm = 0.2; % [H] Arm resistor
C_bus = 4400e-6; % [H] Arm test inductance
R_s = 30; % [Ω] Stack test resistance
R_p = R_s; % [Ω] Stack test resistance

% C_m = 188.4e-6; % [F] Module capacitor capacitance (base TWIST)
C_m = 1308.4e-6; % [F] Module capacitor capacitance

C_M_extra = C_m-twist_high_side_C;
N=5; % [-] Total number of modules per arm

% Modulation parameters
m = 1; % Modulation for simple model -> Vac = m * VDC/2
a = 1; % Modulation for simple model -> Changes the state of charge of voltage module Vm = a * VDC/2 + m * VDC/2 sin(wt)

% Parameters controller
f_control = 10e3; % [Hz] Control task frequency
%% Setup depending on user configuration (DO NOT CHANGE THIS PART OF THE CODE)

if(~HaveChargingPhase)
    source_V = VDC/N;  %source voltage [V] - inicial module capacitor voltage
else
    source_V = 0;  %source voltage [V] - inicial module capacitor voltage
end

if(~isInterleaved)
    twist_phase_shift_leg_2_deg = 0; %no phase shift
else
    twist_phase_shift_leg_2_deg = 180; %interleaved phase shift
end

if(~isC1low1Active)
    C1low1_active = 0;
else
    C1low1_active = 1;
end

if(~isC2low1Active)
    C2low1_active = 0;
else
    C2low1_active = 1;
end

%% Start simulink simulation

tic

% open(latest_sim_name);
sim(latest_sim_name);

if(data_save == true)
    % Data output save
    results = ans;
    VDC_name = string(VDC);
    save('sim_results/results_phase_VDC'+VDC_name+'V_freq'+round(f0)+'Hz_Larm'+round(L_arm*1e6)+'uH_Cm'+round(C_m*1e6)+'uF','results');  
end

toc


