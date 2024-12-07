function [sys,y0,str,ts] = KrisztaS(t,y,x,flag)

a1 = 0.0079; %kmol/m3
a2 = 0.108; %-
Mw = 215; %kg/kmol
Eg = 45000; %kJ/mol
R = 8.31; %kJ/molK
kp = 10^(11); %#/m3/s
p = 3;          %-
kg = 75;         %m/s
g = 1.32;        %-


rho = 998;      %kg/m3
rho_c = 998;    %kg/m3
rho_cr = 1300;  %kg/m3
kv = pi/6;      %-
cp = 3140;      %j/kg/K
cp_c = 3140;    %J/kg/K
V = 10;          %m3
Vc = V/10;       %m3
U = 1800;       %W/m2/K
A = 5*V^(2/3);  %m2           
%Tc0 = 0;         %°C

%Ő nekik később adunk feladatot:

%F = 0.004;     %m3/s
%T_r = 40;        %°C
%cAl_r = Mw * a1 * exp(a2* ( T_r ) ); 
%Fc0 = 0.05;     %m3/s

switch flag

    case 0 %inicializálás

        sizes = simsizes;
        sizes.NumContStates =   7;
        sizes.NumDiscStates =   0;
        sizes.NumOutputs =      4;
        sizes.NumInputs =       5;
        sizes.DirFeedthrough =  1;
        sizes.NumSampleTimes =  1;
        sys = simsizes(sizes);

        y0 = [0 20 20 10^-6 0 0 0];

        str = [];

        ts = [0]; 

   
    
    case 1

        F =     x(1);       %m3/s
        T_r =   x(2);       %°C
        cAl_r = x(3);       %kg/m^3
        Fc0 =   x(4);       %m3/s
        Tc0 =   x(5);       %°C

        dy = crystallisationODE(t,y,a1,a2,kp,kg,Mw,kv,rho_cr,F,V,T_r,U,A,rho,cp,Fc0,Tc0,rho_c,cp_c,Vc,R,Eg,g,p,cAl_r);

        sys = dy;


    case 3

        L = (y(5) / y(4))*10^6;
        Y = (1 - ( y(1) / x(3) ) ) * 100;

        sys = [L,Y, y(2),y(3)];
        %sys(1) = L;
        %sys(2) = Y;

    case { 2, 4, 9 } % Unused flags

        sys = [];

    otherwise

        error(['Unhandled flag = ',num2str(flag)]); % Error handling
end

