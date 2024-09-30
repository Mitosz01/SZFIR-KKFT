clear all
close all
clc

% parameters to be varied and some reasonable values to be found for a 85 %
% conversion

FB0 = 0.002;    % m^3/s [up to 0.004]
FH0 = 0.001;    % m^3/s [up to 0.01]
V = 0.1;        % m^3   [0.1 or 0.5 or 1]

% parameters

k = 5e9;
R = 8.31;
Ea = 65000;
FA0 = 0.001;    % m^3/s   
TA0 = 25;       % Celsius
TB0 = 45;       % Celsius
TH0 = 90;       % Celsius
cA0 = 2;        % kmol/m^3
cB0 = 2;        % kmol/m^3
rho = 998;      % kg/m^3
rhoH = 998;     % kg/m^3
cp = 3140;      % J/kg/K
cpH = 3140;     % J/kg/K
VH = V/10;      % m^3
U = 1200;        % W/m^2/K
A = 5*V^(2/3);  % m^2

% solving the differential equations

odefun = @(t,y) reactorModelODE(t,y,k,R,Ea,FA0,FB0,TA0,TB0,cA0,cB0,rho,rhoH,cp,cpH,V,VH,FH0,TH0,U,A);
tspan = [0, 2*3600];            %   a sampling time long enough to reach a steady-state
y0 = [0 0 0 0 20 20];

[T,Y] = ode45(odefun,tspan,y0);

% figures

subplot(1,2,1)
semilogx(T/60,Y(:,1))
hold on
semilogx(T/60,Y(:,3))
legend('Reagent A','Product C')
xlabel('Time, minutes')
ylabel('Concentration, kmol/m^3')
set(gca,'xlim',[1e-3,T(end)/60])
grid on
box on

subplot(1,2,2)
semilogx(T/60,Y(:,5))
hold on
semilogx(T/60,Y(:,6))
legend('Reactor','Jacket')
xlabel('Time, minutes')
ylabel('Temperature, ^oC')
set(gca,'xlim',[1e-3,T(end)/60])
grid on
box on