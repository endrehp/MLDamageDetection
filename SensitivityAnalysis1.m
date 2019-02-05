close all

% Sensistivity analysis

ne = 100; % number of elements
ns = 9; % number of sensor locations

fvec = linspace(1, 0.01, 100); % linearly increasing damage severity
damage = 30; % Damaged element (arbitrary chosen)
N = 2; % number of mode shapes accounted for

% Undamaged beam
[uU, uD] = damagedBeam(ne, ns, 0, 0);
U = [zeros(1, length(uU(1,:))); uU; zeros(1, length(uU(1,:)))];
L = length(U(:,1));

ddU = zeros(L, N); 
ddu_tot = zeros(L,1);

for i=1:N
   
    ddu = getModalCurvature(U(:,i));
    ddU(:,i) = ddu;
    ddu_tot = ddu_tot + ddu;
    
end

% Initialize arrays

maxCurvature = zeros(1, length(fvec));
maxStrainEnergy = zeros(1, length(fvec));
maxFlexibility = zeros(1, length(fvec));


% ########### Increasing severity ##############

for i=1:length(fvec)
    
    [dV, dD] = damagedBeam(ne, ns, damage, fvec(i));
    V = [zeros(1, length(dV(1,:))); dV; zeros(1, length(dV(1,:)))];
    
    
    % Curvature
    ddV = zeros(L, N);
    ddv_tot = zeros(L,1);

    for j=1:N
        ddv = getModalCurvature(V(:,j));
        ddV(:,i) = ddv;
        ddv_tot = ddv_tot + ddv;
    end
    
    maxCurvature(i) = max(abs(ddu_tot - ddv_tot));
    
    % Modal Strain energy difference
    beta = getMSEdamage(U, V, N);
    maxStrainEnergy(i) = max(beta);
   
    % Modal flexibility difference
    Gu = getModalFlexibility(uU, uD, N);
    Gd = getModalFlexibility(dV, dD, N);

    deltaG = Gu - Gd;
    maxj = max(abs(deltaG));
    maxFlexibility(i) = max(maxj);
    
    
end

figure
hold on
plot((1-fvec)*100, maxCurvature/mean(maxCurvature), 'DisplayName', "Max curvature difference")
plot((1-fvec)*100, maxStrainEnergy/mean(maxStrainEnergy), 'DisplayName', "Max Strain energy difference")
plot((1-fvec)*100, maxFlexibility/mean(maxFlexibility), 'DisplayName', "Max Flexibility difference")
xlabel("Damage severity (%)")
legend('show')


maxCurvNorm = maxCurvature/max(maxCurvature);
maxStrainNorm = maxStrainEnergy/max(maxStrainEnergy);
maxFlexNorm = maxFlexibility/max(maxFlexibility);


figure
hold on
title('Normalized damage parameters vs damage severity')
plot((1-fvec)*100, maxCurvNorm, 'DisplayName', "Max curvature difference")
plot((1-fvec)*100, maxStrainNorm, 'DisplayName', "Max Strain energy difference")
plot((1-fvec)*100, maxFlexNorm, 'DisplayName', "Max Flexibility difference")
xlabel("Damage severity (%)")
legend('show')


%% Derivatives with respect to severity change

CurvDiff = diff(maxCurvNorm);
StrainDiff = diff(maxStrainNorm);
FlexDiff = diff(maxFlexNorm);

figure
hold on
title('Derivatives with respect to severity change')
plot((1-fvec(1:end-1))*100, CurvDiff, 'DisplayName', "Curvature change")
plot((1-fvec(1:end-1))*100, StrainDiff, 'DisplayName', "Strain energy change")
plot((1-fvec(1:end-1))*100, FlexDiff, 'DisplayName', "Flexibility change")
ylim([0,0.2])
xlabel("Damage severity (%)")
legend('show')
