%% Clean everything
clear all; clc;
% close all;

%% Sequence and Twist configuration

data_save = false; % true : save in a .mat file the following data : duty / VHigh / V1Low / V2Low / IHigh / I1Low / I2Low
power_losses = false; % true : takes into account power losses from the MOSFETs / false : no power losses
isInterleaved = false; % true : 180° phase shift between leg 1 and leg 2 / false : 0° phase shift
HaveChargingPhase = true;
isC1low1Active = false;
isC2low1Active = false;
is6VExternallySupplied = true;
isFeederJumperOpen = true;
isDutyCycleRamp = true;

%% Simulation configuration

% latest_sim_name = 'MMC_stack_openloop_NLM_CVB_twist.slx'; 
% latest_sim_name = 'MMC_stack_openloop_NLM_noCVB_twist.slx'; 
latest_sim_name = 'MMC_stack_openloop_NLM_CVB_dutycycleramp_twist.slx'; 

latest_MMC_parameters = "param_stacksim_20260219.m";
latest_twist_parameters = "twist_parameters.m";

sim_time = 1.5; %overall simulation time
t_init_sim = 0; % [s] Simulation start time
Ts = 5e-7; % [s] Simulation sample period

time_charge = 0.2; % [s] Charging time - used only if HaveChargingPhase = true
time_decharge = 0.8; % [s] Decharging time

duty_cycle_max = 0.95;
duty_cycle_min = 0;
%% Initialize twist parameters

run(latest_twist_parameters);

if(is6VExternallySupplied == false)
    feeder_current_lower_rate_limit = -300;
else
    feeder_current_lower_rate_limit = -10;

end

% Initialize times and frequencies
twist_freq_data_sampling = 20e3; %data sampling frequency
twist_data_sampling_period = 1/twist_freq_data_sampling; %data sampling delay
twist_data_acquisition_delay = 50e-9; %data acquisition at the peak of the carry
%% Initialize MMC parameters

run(latest_MMC_parameters);
%% Setup depending on user configuration

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
    if(is6VExternallySupplied == false)
        if(isC1low1Active == true)
            save('sim_results/20260116/arm_sim/results_armsim_VDC'+VDC_name+'V_freq'+round(f0)+'Hz_Larm'+round(L_arm*1e6)+'uH_Cm'+round(C_m*1e6)+'uF_feeder_avecC1low','results');
        else
            save('sim_results/20260116/arm_sim/results_armsim_VDC'+VDC_name+'V_freq'+round(f0)+'Hz_Larm'+round(L_arm*1e6)+'uH_Cm'+round(C_m*1e6)+'uF_feeder_sansC1lowelec','results');
        end
    else
        if(isFeederJumperOpen == true)
            if(isC1low1Active == true)
                save('sim_results/20260116/arm_sim/results_armsim_VDC'+VDC_name+'V_freq'+round(f0)+'Hz_Larm'+round(L_arm*1e6)+'uH_Cm'+round(C_m*1e6)+'uF_6Vext_avecC1low_jumperopen','results');
            else
                save('sim_results/20260116/arm_sim/results_armsim_VDC'+VDC_name+'V_freq'+round(f0)+'Hz_Larm'+round(L_arm*1e6)+'uH_Cm'+round(C_m*1e6)+'uF_R'+round(R)+'Ohms_6Vext_sansC1lowelec_jumperopen_CVB_detailedmeasure_dutycycleramp4','results');
            end
        else
            if(isC1low1Active == true)
                save('sim_results/20260116/arm_sim/results_armsim_VDC'+VDC_name+'V_freq'+round(f0)+'Hz_Larm'+round(L_arm*1e6)+'uH_Cm'+round(C_m*1e6)+'uF_6Vext_avecC1low','results');
            else
                save('sim_results/20260116/arm_sim/results_armsim_VDC'+VDC_name+'V_freq'+round(f0)+'Hz_Larm'+round(L_arm*1e6)+'uH_Cm'+round(C_m*1e6)+'uF_6Vext_sansC1lowelec','results');
            end
        end
    end
end


toc


