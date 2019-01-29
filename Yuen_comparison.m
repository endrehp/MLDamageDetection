close all

% Yuen comparison

ne = 100;
ns = 9;
damage = [30, 50];
f = [0.1, 0.2];

[uV, uD] = damagedBeam(ne, ns, 0, 0);
[dV, dD] = damagedBeam(ne, ns, damage, f);

%L = length(uV(1,:));
L = 5;
N = length(uV(:,1));
yuens = zeros(N, L);

for i=1:L
    
    yuens(:,i) = getYuen(uV(:,i), dV(:,i), uD(i,i), dD(i,i));
    
end

figure
plot(yuens)


figure
hold on
i = 2;
plot([0;uV(:,i);0], "DisplayName", "undamaged")
plot([0;dV(:,i);0], "DisplayName", "damaged")
legend('show')

