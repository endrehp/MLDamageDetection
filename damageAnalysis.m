
damage = 4;
ne = 10;
[V, D] = damagedBeam(damage, ne);

%% Plot modes

figure
hold on

for i=1:1 %length(V(1,:))

    ev = [0; V(2:2:end-2,i); 0];
    plot(ev)
    
end


[V, D] = damagedBeam(0, ne);

for i=1:1 %length(V(1,:))

    ev = [0; V(2:2:end-2,i); 0];
    plot(ev)
    
end

legend('damage = 3', 'undamaged')