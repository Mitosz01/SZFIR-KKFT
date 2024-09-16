clear all
close all
clc

cA0 = 2;
cB0 = 2;
k = 5*10^(9);
R = 8.31;
Ea = 65000;
FA0 = 0.001;
FB0 = 0.004;
TA0 = 25;
TB0 = 45;
Ro = 998;
RoH = 998;
Cp = 3140;
CpH = 3140;
V = 0.1;
VH = V/10;
U = 1200;
A = 5 * V^(2/3);
FH0 = 0.01;
TH0 = 90;


tspan = [0 2*3600];

odefun = @(t, y) reaktorODE(t, y, cA0, FA0, FB0, V, k, Ea, R, cB0, Ro, Cp, FH0, VH, TH0, TA0, TB0, U, A, RoH, CpH );

y0 = [0 0 0 0 20 20];
[t,y] = ode45(odefun, tspan, y0);