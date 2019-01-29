close all

% Modal Curvature comparison

ne = 100;
ns = 99;
damage = [30, 50];
f = [0.1, 0.2];

[uV, uD] = damagedBeam(ne, ns, 0, 0);
[dV, dD] = damagedBeam(ne, ns, damage, f);

U = [zeros(1, length(uV(1,:))); uV; zeros(1, length(uV(1,:)))];
V = [zeros(1, length(dV(1,:))); dV; zeros(1, length(dV(1,:)))];

L = length(U(:,1));
N = 2;

ddU = zeros(L, N); 
ddV = zeros(L, N);
ddu_tot = zeros(L,1);
ddv_tot = zeros(L,1);

for i=1:N
   
    ddu = getModalCurvature(U(:,i));
    ddv = getModalCurvature(V(:,i));
    
    ddU(:,i) = ddu;
    ddV(:,i) = ddv;
    
    ddu_tot = ddu_tot + ddu;
    ddv_tot = ddv_tot + ddv;
    
end

curv_diff = abs(ddu_tot - ddv_tot);

figure
hold on
title("Modal curvature difference by sensor number, ns = 99")
plot(curv_diff)

figure
hold on
title('Mode shape curvature')
i = 2;
plot(ddU(:,i), "DisplayName", "undamaged")
plot(ddV(:,i), "DisplayName", "damaged")
legend('show')


figure
hold on
i = 2;
plot(U(:,i), "DisplayName", "undamaged")
plot(V(:,i), "DisplayName", "damaged")
legend('show')
