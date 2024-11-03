clear all
close all
clc

a1 = 0.0079; %kmol/m3
a2 = 0.108; %-
Mw = 215; %kg/kmol
Eg = 45000; %kJ/mol
R = 8.31; %kJ/molK
kp = 10^(11); %#/m3/s
p = 3;          %-
kg = 75;         %m/s
g = 1.32;        %-
T_r = 40;        %°C
F = 0.004;     %m3/s
cAl_r = Mw * a1 * exp(a2* ( T_r ) ); 
rho = 998;      %kg/m3
rho_c = 998;    %kg/m3
rho_cr = 1300;  %kg/m3
kv = pi/6;      %-
cp = 3140;      %j/kg/K
cp_c = 3140;    %J/kg/K
%változhat
V = 5;          %m3
Vc = V/10;       %m3
U = 1800;       %W/m2/K
A = 5*V^(2/3);  %m2
Fc0 = 0.05;     %m3/s
Tc0 = 0;         %°C


tspan = [0 10^(6)];
y0 = [0 20 20 0 0 0 0];
odefun = @(t, y) crystallisationODE(t,y,a1,a2,kp,kg,Mw,kv,rho_cr,F,V,T_r,U,A,rho,cp,Fc0,Tc0,rho_c,cp_c,Vc,R,Eg,g,p,cAl_r);

[t , y ] = ode45(odefun, tspan, y0);

L = (y(:,5) ./ y(:,4))*10^6;

Y = ( y(:,7) * rho_cr )/( cAl_r * Mw );

subplot(1,4,1)
semilogx(t,y(:,2))
hold on
plot(t,y(:,3))
legend("Crystallization temperature","Cape temperature")
xlabel("time/s")
ylabel("Temperature (°C)")
grid on
box on

subplot(1,4,2)
semilogx(t,y(:,4))
xlabel("time/s")
ylabel("0 th moment specific particle number #/m3")
box on
grid on

subplot(1,4,3)
semilogx(t,L)
xlabel("time/s")
ylabel("Average particle size mikroM")
box on
grid on

subplot(1,4,4)
semilogx(t,Y)
xlabel("time/s")
ylabel("yield/-")
box on 
grid on