close all

% COMAC comparison 

ne = 100;
ns = 99;
damage = [30, 50];
f = [0.1, 0.2];

[uV, uD] = damagedBeam(ne, ns, 0, 0);
[dV, dD] = damagedBeam(ne, ns, damage, f);

%L = length(uV(1,:));
L = 1;

COMAC = getCOMAC(uV(:,1:L), dV(:,1:L));


figure
plot(COMAC)


figure
hold on
i = 2;
plot([0;uV(:,i);0], "DisplayName", "undamaged")
plot([0;dV(:,i);0], "DisplayName", "damaged")
legend('show')

