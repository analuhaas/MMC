%% Clean everything
clear all; clc; 
% close all;

%% Sequence and Twist configuration

data_save = false; % true : save in a .mat file the following data : duty / VHigh / V1Low / V2Low / IHigh / I1Low / I2Low
power_losses = false; % true : takes into account power losses from the MOSFETs / false : no power losses
isInterleaved = false; % true : 180° phase shift between leg 1 and leg 2 / false : 0° phase shift
isC1low1Active = false;
isC2low1Active = false;
is6VExternallySupplied = false;
isFeederJumperOpen = false;


%% Simulation configuration

latest_sim_name = 'MMC_1module_twist_LF_20261012.slx'; %Version with modifications: Power supply characteristics, Feeder, Feeder threshold

latest_test_parameters = "test_parameters.m";
latest_twist_parameters = "twist_parameters.m";

sim_time = 1; %overall simulation time
t_init_sim = -0.01; % [s] Simulation start time
Ts = 1e-6; % [s] Simulation sample period

%Sequence variables - LF sequence (same as the module test code LF_sequence/main.cpp)
% VDC is turned ON at t = 0 s and turned OFF at t_X
% The second part of the sequence starts when VDC is turned OFF (t_X >= 0.45 s), as in the code
t_X = 0.45; %[s] time where VDC = 0V
f_HF_test = 50; %[Hz] Frequency of the connected/disconnected step (f_sw_HF in the code)

% Mode of each step: 0 = disconnected, 1 = connected, 2 = blocked, 3 = connected/disconnected at f_HF_test
% Step i goes from time_steps(i) to time_steps(i+1)
%               blocked  connected  disconnected  conn/disc  disconnected  blocked     connected   blocked (IDLE)
steps_modes = [ 2,       1,         0,            3,         0,            2,          1,          2];
time_steps  = [ 0,       0.1,       0.2,          0.3,       0.4,          t_X+0.25,   t_X+0.35,   t_X+0.45,   sim_time];

% External parameters
R = 15; %load resistance [Ohm]
VDC = 40; %power supply voltage [V]
Rdec = 15; %resistance for discharging capacitor phase having 4 A [Ohm]
R_s = R; %series resistance of the test circuit (R_s in the model) [Ohm]
R_p = Rdec; %parallel resistance of the test circuit (R_p in the model) [Ohm]
C_M_extra = 0; %extra capacitance in parallel to C_High (0 = no extra capacitor) [F]

%% Setup depending on user configuration

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

%% Initialize test parameters

run(latest_test_parameters);
%% Initialize twist parameters

run(latest_twist_parameters);
source_V = 0;  %source voltage [V] - inicial module capacitor voltage

if(is6VExternallySupplied == false)
    feeder_current_lower_rate_limit = -300;
else
    feeder_current_lower_rate_limit = -10;

end

%% Start simulink simulation

tic

% open(latest_sim_name);
sim(latest_sim_name);

if(data_save == true)
    % Data output save
    results = ans;
    VDC_name = string(VDC);
    save('sim_results/results_phase_VDC'+VDC_name+'V_freq'+round(f0)+'Hz_RsRp'+round(R_s)+'Ohms','results');  
end

toc


