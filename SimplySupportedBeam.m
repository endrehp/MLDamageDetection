clear
close all

% 10 element simply supported beam

L = 1; % total length
ne = 10; % number of elements
a = L/ne; % element length
nn = ne+1; % number of nodes
ndof = nn*2; % degrees of freedom
rho = 7500; % kg/m^3
E = 210000000; %N/m^2
h = 1; % m
b = 1; % m
A = h*b; % m^2
EI = E*1/12*b*h^3; 
me = a*rho*A;

% Element mass- and stiffness matrices

Me = me/420*[156, 22*a, 54, -13*a;
    22*a, 4*a^2, 13*a, -3*a^2; 
    54, 13*a, 156, -22*a; 
    -13*a, -3*a^2, -22*a, 4*a^2];

Ke = EI*[12/a^3 6/a^2 -12/a^3 6/a^2; 
    6/a^2 4/a -6/a^2 2/a;
    -12/a^3 -6/a^2 12/a^3 -6/a^2;
    6/a^2 2/a -6/a^2 4/a];


% Assemble global matrices

K = zeros(ndof);
M = zeros(ndof);

damage = 3; % damaged element
f = 0.1; % damage factor

for i=1:ne
    
    if i == damage
        K(2*i-1:2*i+2, 2*i-1:2*i+2) = K(2*i-1:2*i+2, 2*i-1:2*i+2) + f*Ke; 
    else
        K(2*i-1:2*i+2, 2*i-1:2*i+2) = K(2*i-1:2*i+2, 2*i-1:2*i+2) + Ke; 
    end
    
    M(2*i-1:2*i+2, 2*i-1:2*i+2) = M(2*i-1:2*i+2, 2*i-1:2*i+2) + Me;
    
    
end

% Enforce boundary conditions

Mr = [M(2:end-2,2:end-2), M(2:end-2,end);M(end,2:end-2), M(end,end)];
Kr = [K(2:end-2,2:end-2), K(2:end-2,end);K(end,2:end-2), K(end,end)];


%% Solve eigenvalueproblem

[V, D] = eig(Kr, Mr);


%% Plot modes

figure
hold on

for i=1:3 %length(V(1,:))

    ev = [0; V(2:2:end-2,i); 0];
    plot(ev)
    
end
    