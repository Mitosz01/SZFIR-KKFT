clear all
close all 
clc

%Tabulátorral kiemeltem azokat a definíciókat, amiket előreláthatólag majd
%változtatni kell
cA0 = 2;
cB0 = 2;
k = 5*10^(9);
R = 8.31;
Ea = 65000;
FA0 = 0.001;
            FB0v = linspace(0.000,0.004,30); %0.001től 0.004ig 
TA0 = 25;
TB0 = 45;
Ro = 998;
RoH = 998;
Cp = 3140;
CpH = 3140;
            V = 0.5; % 0.1 vagy 0.5 vagy 1 
            VH = V/10;
U = 1200;
            A = 5 * V^(2/3);
FH0 = 0.01;
TH0 = 90;


%vektorok kialakítása

Xv = zeros(1,length(FB0v));
Tv = zeros(1,length(FB0v));
Tjv = zeros(1,length(FB0v));
CAv = zeros(1,length(FB0v));
CCv = zeros(1,length(FB0v));

for i = 1 : length(FB0v)



odefun = @(t, y) reaktorODE_2(t, y, cA0, FA0, FB0v(i), V, k, Ea, R, cB0, Ro, Cp, ...
    FH0, VH, TH0, TA0, TB0, U, A, RoH, CpH );

tspan = [0 600];
y0 = [0 0 0 0 20 20];

[t,y] = ode45(odefun, tspan, y0);

X = 1 - ((FA0 + FB0v(i)) * y(end,1)) / (FA0 * cA0);

Xv(i) = X;
Tv(i) = y(end,5);
Tjv(i) = y(end,6);
CAv(i) = y(end,1);
CCv(i) = y(end,3);

end

subplot(1,3,1)
plot(FB0v,CAv,'ro','linestyle','--')
hold on
plot(FB0v,CCv,'bo','linestyle','--')
legend('Reagent A','Product C')
xlabel('F_B^0, m^(3/s)')
ylabel('Concentration, kmol/m3')
title('FB0 vs concentration')
grid on
box on

subplot(1,3,2)
plot(FB0v,Tv,'ro','linestyle','--')
hold on
plot(FB0v,Tjv,'bo','linestyle','--')
legend('Reactor','Jacket')
xlabel('F_B^0, (m^3/s)')
ylabel('Temperature, ^oC')
title('FB0 vs temperature')
grid on
box on

subplot(1,3,3)
plot(FB0v,Xv,'ro','linestyle','--')
legend('Conversion')
xlabel('F_B^0, (m^3/s)')
ylabel('Conversion, -')
title('FB0 vs conversion')
grid on
box on

% FBO = 0.000965517 V = 0.5 m^3 Konv = 0.854