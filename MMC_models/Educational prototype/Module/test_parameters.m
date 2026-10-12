%% 1 module sim

% External parameters
R = 15; %load resistance [Ohm]
VDC = 40; %power supply voltage [V]
Rdec = 15; %resistance for discharging capacitor phase having 4 A [Ohm]
R_s = R; %series resistance of the test circuit (R_s in the model) [Ohm]
R_p = Rdec; %parallel resistance of the test circuit (R_p in the model) [Ohm]
C_M_extra = 0; %extra capacitance in parallel to C_High (0 = no extra capacitor) [F]

