% Compare curvature

ne = 100;
% Undamaged beam 
[udV, udD] = damagedBeam(0, ne, 0.1);

% Damaged beam
[dV, dD] = damagedBeam(30, ne, 0.1);

a = 1/ne; %element length


% first mode
udMode = udV(2:2:end-2,1);
dMode = dV(2:2:end-2,1);
udMode = [0; udMode; 0];
dMode = [0; dMode; 0];

figure
hold on
title('First mode shape')
plot(udMode,'DisplayName', 'undamaged')
plot(dMode, 'DisplayName', 'damaged')

udk = zeros(length(udMode), 1);
dk = zeros(length(dMode), 1);
legend('show')

% Cuvature
for i=1:length(udMode)
    
    if i==1
        % Forward difference for first element
        udk(i) = 1/(2*a^2)*(udMode(i+2) - 2*udMode(i+1) + udMode(i));
        dk(i) = 1/(2*a^2)*(dMode(i+2) - 2*dMode(i+1) + dMode(i));
   
    elseif i == length(udMode)
        % Backward difference for last element
        udk(i) = 1/(2*a^2)*(udMode(i) - 2*udMode(i-1) + udMode(i-2));
        dk(i) = 1/(2*a^2)*(dMode(i) - 2*dMode(i-1) + dMode(i-2));
        
    else
        % Central difference
        udk(i) = 1/a^2*(udMode(i-1) - 2*udMode(i) + udMode(i+1));
        dk(i) = 1/a^2*(dMode(i-1) - 2*dMode(i) + dMode(i+1));
    end
    
end

figure
title('First mode shape curvature')
hold on
plot(udk, 'DisplayName', 'undamaged')
plot(dk,'DisplayName', 'damaged')

legend('show')



