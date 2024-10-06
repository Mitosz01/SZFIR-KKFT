function [sys,y0,str,ts] = ReaktorS(t,y,x,flag)

cA0 = 2;
cB0 = 2;
k = 5*10^(9);
R = 8.31;
Ea = 65000;
FA0 = 0.001;
            FB0 = 0.001;
TA0 = 25;
TB0 = 45;
Ro = 998;
RoH = 998;
Cp = 3140;
CpH = 3140;
            V = 0.5;
            VH = V/10;
U = 1200;
            A = 5 * V^(2/3);
FH0 = x;
TH0 = 90;

switch flag

    case 0 %inicializálás

        sizes = simsizes;
        sizes.NumContStates =   6;
        sizes.NumDiscStates =   0;
        sizes.NumOutputs =      1;
        sizes.NumInputs =       1;
        sizes.DirFeedthrough =  1;
        sizes.NumSampleTimes =  1;
        sys = simsizes(sizes);

        y0 = [0 0 0 0 20 20];

        str = [];

        ts = [0]; 
    
    case 1

        dy = reaktorODE(t, y, cA0, FA0, FB0, V, k, Ea, R, cB0, Ro, Cp, ...
    FH0, VH, TH0, TA0, TB0, U, A, RoH, CpH);

        sys = dy;

    case 3

        X = 1 - ((FA0 + FB0) * y(1)) / (FA0 * cA0);

        sys = X;

    case { 2, 4, 9 } % Unused flags

        sys = [];

    otherwise

        error(['Unhandled flag = ',num2str(flag)]); % Error handling
end

