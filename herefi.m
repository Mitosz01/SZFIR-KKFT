function herefi()
k = 5*10^(9);
R = 8.31;
Ea = 65000;
F0A = 0.001;
T0A = 25;
T0B = 45;
C0A = 2;
C0B = 2;
Ro = 998;
RoH = 998;
Cp = 3140;
CpH = 3140;
U = 1200;
F0H = 0.01;
T0H = 90;
                %Ezután változtatandó értékek jönnek, úgyhogy ezeket külön szedtem
F0B = 0.004;
F = F0A + F0B;   %0.004ig 

V = 0.1;         %0.1, 0.5 és 1
A = 5*V^(2/3);
VH = V/10;

tspan = [0 300];
initial_conditions = [0; 0];



function dCdt = CSTR(C, C0A, C0B, F0A, F0B, F, V, k)

CA = C(1);
CB = C(2);

r = k * CA * CB;


dCBdt = (C0B* F0B / V) - (CB * F / V) - r;
dCAdt = (C0A * F0A / V) - (CA * F / V) - r;

dCdt = [dCAdt; dCBdt];

end


[t, C] = ode15s(@(t, C) CSTR(C, C0A, C0B, F0A, F0B, F, V, k), tspan, initial_conditions);

% Plot the results
figure;
plot(t, C(:,1), 'b-', t, C(:,2), 'r-');
xlabel('Time t');
ylabel('Concentration');
legend('C_A', 'C_B');
title('Concentration of A and B over time in a CSTR');

end