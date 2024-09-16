function dy = reaktorODE(t, y, cA0, FA0, FB0, V, k, Ea, R, cB0, Ro, Cp, FH0, VH, TH0, TA0, TB0, U, A, RoH, CpH );

    cA = y(1);
    cB = y(2);
    cC = y(3);
    cD = y(4);
    T = y(5);
    TH = y(6);
    
    dy = zeros(size(y));
    
    r = k * cA * cB * exp (-Ea/(R*Tk)) ;
    Tk = T + 273.15;
    F = FA0 + FB0;
    
    dcA = (cA0 * FA0 / V) - (cA * F / V) - (r);
    dcB = (cB0 * FB0 / V) - (cB * F / V) - (r);
    cC = (-cC * F / V) + r;
    cD = (-cD * F / V) + r;
    dT = (TA0 * FA0 / V) + (TB0 * FB0 / V) - (T * F / V) - ((U * A)/( Ro * Cp * V))*(T - TH);
    dTH = (TH0 * FH0 / VH) - (TH * FH / VH) + ((U * A)/( RoH * CpH * VH))*(T - TH);
    
    dy(1) = dcA;
    dy(2) = dcB;
    dy(3) = cC;
    dy(4) = cD;
    dy(5) = dT;
    dy(6) = dTH;

    