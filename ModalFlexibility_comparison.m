close all

% Modal Flexibility comparison

ne = 100;
ns = 9;
damage = [30, 50];
f = [0.1, 0.2];

[uV, uD] = damagedBeam(ne, ns, 0, 0);
[dV, dD] = damagedBeam(ne, ns, damage, f);

U = [zeros(1, length(uV(1,:))); uV; zeros(1, length(uV(1,:)))];
V = [zeros(1, length(dV(1,:))); dV; zeros(1, length(dV(1,:)))];

L = length(U(:,1));
N = 2;

Gu = getModalFlexibility(uV, uD, N);
Gd = getModalFlexibility(dV, dD, N);

deltaG = Gu - Gd;

maxj = max(abs(deltaG));
damagedDof = find(maxj == max(maxj));
disp("Damaged dof is:")
disp(damagedDof)

figure
hold on
title("Damage indicator dof number, ns = 9")
plot(maxj)


figure
hold on
i = 2;
plot(U(:,i), "DisplayName", "undamaged")
plot(V(:,i), "DisplayName", "damaged")
legend('show')
