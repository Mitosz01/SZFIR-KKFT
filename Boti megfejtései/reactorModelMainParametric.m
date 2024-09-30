clear all
close all
clc

% parameters to be varied and some reasonable values to be found for a 85 %
% conversion

FB0v = linspace(0.000,0.004,30);    % m^3/s [up to 0.004]
FH0 = 0.005;    % m^3/s [0up to 0.01]
V = 0.5;        % m^3   [0.1 or 0.5 or 1]

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

% initialize the vector of outputs to be followed in the parametric study

Xv = zeros(1,length(FB0v));
Tv = zeros(1,length(FB0v));
Tjv = zeros(1,length(FB0v));
CAv = zeros(1,length(FB0v));
CCv = zeros(1,length(FB0v));

for i = 1 : length(FB0v)

    % solving the differential equations
    
    odefun = @(t,y) reactorModelODE(t,y,k,R,Ea,FA0,FB0v(i),TA0,TB0,cA0,cB0,rho,rhoH,cp,cpH,V,VH,FH0,TH0,U,A);
    tspan = [0,2*3600]; % a sampling time long enough to reach a steady-state
    y0 = [0 0 0 0 20 20];
    
    [T,Y] = ode45(odefun,tspan,y0);
    
    % calculating the conversion for reagent "A" 

    X = 1 - ((FA0 + FB0v(i)) * Y(end,1)) / (FA0 * cA0);

    Xv(i) = X;
    Tv(i) = Y(end,5);
    Tjv(i) = Y(end,6);
    CAv(i) = Y(end,1);
    CCv(i) = Y(end,3);

end

% figz

subplot(1,3,1)
plot(FB0v,CAv,'ro','linestyle','--')
hold on
plot(FB0v,CCv,'bo','linestyle','--')
legend('Reagent A','Product C')
xlabel('F_B^0, m^3/2')
ylabel('Concentration, kmol/m3')
grid on
box on

subplot(1,3,2)
plot(FB0v,Tv,'ro','linestyle','--')
hold on
plot(FB0v,Tjv,'bo','linestyle','--')
legend('Reactor','Jacket')
xlabel('F_B^0, m^3/2')
ylabel('Temperature, ^oC')
grid on
box on

subplot(1,3,3)
plot(FB0v,Xv,'ro','linestyle','--')
legend('Conversion')
xlabel('F_B^0, m^3/2')
ylabel('Conversion, -')
grid on
box on
