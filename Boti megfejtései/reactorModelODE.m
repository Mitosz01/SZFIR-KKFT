function dy = reactorModelODE(t,y,k,R,Ea,FA0,FB0,TA0,TB0,cA0,cB0,rho,rhoH,cp,cpH,V,VH,FH0,TH0,U,A)

    dy = zeros(size(y));

    cA = y(1);
    cB = y(2);
    cC = y(3);
    cD = y(4);
    T = y(5);
    TH = y(6);

    Tk = T + 273.15;
    r = k * cA * cB * exp(-Ea/R/Tk);

    F = FA0 + FB0;
    FH = FH0;

    dy(1) = FA0 * cA0 / V - F * cA / V - r;
    dy(2) = FB0 * cB0 / V - F * cB / V - r;
    dy(3) = -F * cC / V + r;
    dy(4) = -F * cD / V + r;
    dy(5) = FA0 * TA0 / V + FB0 * TB0 / V - F * T / V - U * A * (T - TH) / (rho * cp * V);
    dy(6) = FH0 * TH0 / VH - FH * TH / VH + U * A * (T - TH) / (rhoH * cpH * VH);
