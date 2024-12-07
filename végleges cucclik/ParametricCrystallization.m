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
cAl_r = Mw * a1 * exp(a2* ( T_r ) ); %kmol/m^3
rho = 998;      %kg/m3
rho_c = 998;    %kg/m3
rho_cr = 1300;  %kg/m3
kv = pi/6;      %-
cp = 3140;      %j/kg/K
cp_c = 3140;    %J/kg/K

%változhat
                                V = 10;          %m3
Vc = V/10;       %m3
U = 1800;       %W/m2/K
A = 5*V^(2/3);  %m2
                                Fc0v = linspace(0.000,0.050,30) ;   %m3/s
Tc0 = 0;         %°C

%vektorok

Tkristv =    zeros(1,length(Fc0v));
Tkopv =      zeros(1,length(Fc0v));
Lv =         zeros(1,length(Fc0v));
Pv  =         zeros(1,length(Fc0v));
Yv =         zeros(1,length(Fc0v));

for i = 1 : length(Fc0v)

    tspan = [0 10^(6)];
    y0 = [0 20 20 0 0 0 0];
    odefun = @(t, y) crystallisationODE(t,y,a1,a2,kp,kg,Mw,kv,rho_cr,F,V,T_r,U,A,rho,cp,Fc0v(i),Tc0,rho_c,cp_c,Vc,R,Eg,g,p,cAl_r);

    [t , y ] = ode45(odefun, tspan, y0);

    Tkristv(i)   = y(end,2);
    Tkopv(i)     = y(end,3);
    Lv(i)        =(y(end,5)/y(end,4))*10^6;
    Pv(i)        = y(end,4);
    Yv(i)        = (1 - (y(end,1))/( cAl_r)) * 100; %Magyarázat README

end

subplot(1,4,1)
plot(Fc0v, Tkristv,'ro','linestyle','--')
hold on 
plot(Fc0v, Tkopv,'bo','linestyle','--')
legend("Crystallization Temperature","Cape temperature")
xlabel("Fc0 m^3/s")
ylabel("Temperature /°C")
grid on
box on

subplot(1,4,2)
plot(Fc0v, Pv,'ro','linestyle','--')
xlabel("Fc0 m^3/s")
ylabel("population #/m^3")
grid on
box on

subplot(1,4,3)
plot(Fc0v, Lv,'ro','linestyle','--')
xlabel("Fc0 m^3/s")
ylabel("Average circumference /m")
grid on
box on

subplot(1,4,4)
plot(Fc0v, Yv,'ro','linestyle','--')
xlabel("Fc0 m^3/s")
ylabel("yield / %")
grid on
box on

% V = 10m^3 
% Fc0 ~ 0.02 m^3/s
