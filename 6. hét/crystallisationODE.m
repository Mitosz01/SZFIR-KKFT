function dy = crystallisationODE(t,y,a1,a2,kp,kg,Mw,kv,rho_cr,F,V,T_r,U,A,rho,cp,Fc0,Tc0,rho_c,cp_c,Vc,R,Eg,g,p,cAl_r)

cAl = y(1); % kg/m3 
T  = y(2); % °C egység
Tc   = y(3); % °C köpeny
mom0 = y(4);
mom1 = y(5);
mom2 = y(6);
mom3 = y(7);

dy = zeros(size(y));

Tk = T + 273.15;
cAl_s = Mw * a1 * exp(a2*T);

hajtoero = (cAl - cAl_s) / cAl_s;

if hajtoero > 0
B = kp * hajtoero^(p);
G = kg * hajtoero^(g) * exp(-Eg/(R*Tk));
else
B = 0;
G = 0;
end

dmom0 = B - (F/V)*mom0;
dmom1 = G*mom0 - (F/V)*mom1;
dmom2 = 2*G*mom1 - (F/V)*mom2;
dmom3 = 3*G*mom2 - (F/V)*mom3;

dcAl = -3 * G * kv * rho_cr * mom2 + (F/V) * (cAl_r - cAl);
dT = (( F / V ) * ( T_r - T)) - (((U * A)/( rho * cp * V))*(T - Tc));
dTc = (( Fc0 / Vc ) * (Tc0 - Tc)) + (((U * A )/(rho_c * cp_c * Vc))*(T - Tc));

dy(1) = dcAl;
dy(2) = dT;
dy(3) = dTc;
dy(4) = dmom0;
dy(5) = dmom1;
dy(6) = dmom2;
dy(7) = dmom3;
end
