function [V, D] = damagedBeamNoise(ne, ns, damage, f)
    
    % gives eigenvalues and eignevectors of a ne-element beam, where the
    % damage-parameter is a vector containing the element number of the
    % damaged elements
    % damage = [0] means undamaged beam
    % ns is number of sensors or measure points distributed evenly along the beam
    % f is a vector containing the severety of the damage, or the fraction of original
    % stiffness
    
    % Example:
    % [V, D] = damagedBeam(100, 9, [10, 30, 90], [0.1, 0.2, 0.5])
    % will output the mode shapes and natural frequencies a 100 element
    % beam at 9 sensor locations where the 10, 30 and 90 element have a
    % damage of 0.1, 0.2 and 0.5 respectively.
    
    % The only difference from damagedBeam is the noise variable that is
    % multiplied by the stiffness on the non-damaged elements.


    L = 1; % total length
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

    %damage = 3; % damaged element
    %f = 0.1; % damage factor

    for i=1:ne
    
        noise = 1+randn()*0.05;
        if ismember(i, damage)
            ix = damage==i;
            K(2*i-1:2*i+2, 2*i-1:2*i+2) = K(2*i-1:2*i+2, 2*i-1:2*i+2) + f(ix)*Ke; 
        else
            K(2*i-1:2*i+2, 2*i-1:2*i+2) = K(2*i-1:2*i+2, 2*i-1:2*i+2) + Ke*noise; 
        end

        M(2*i-1:2*i+2, 2*i-1:2*i+2) = M(2*i-1:2*i+2, 2*i-1:2*i+2) + Me;


    end

    % Enforce boundary conditions

    Mr = [M(2:end-2,2:end-2), M(2:end-2,end);M(end,2:end-2), M(end,end)];
    Kr = [K(2:end-2,2:end-2), K(2:end-2,end);K(end,2:end-2), K(end,end)];


    %% Solve eigenvalueproblem

    [tV, tD] = eig(Kr, Mr);
    tVz = tV(2:2:end-2,:);
    
    ds = ne/(ns+1); % number of elements between each sensor location
    
    % Result matrices
    V = tVz(ds:ds:end,:);
    D = tD;

end