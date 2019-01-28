close all

% MAC comparison

ne = 100;
ns = 9;
damage = [30, 50];
f = [0.1, 0.2];

[uV, uD] = damagedBeam(ne, ns, 0, 0);
[dV, dD] = damagedBeam(ne, ns, damage, f);

%L = length(uV(1,:));
L = 5;
macs = zeros(1, L);

for i=1:L
    
    macs(i) = getMAC(uV(:,i), dV(:,i));
    
end

figure
plot(macs)


figure
hold on
i = 2;
plot([0;uV(:,i);0], "DisplayName", "undamaged")
plot([0;dV(:,i);0], "DisplayName", "damaged")
legend('show')

