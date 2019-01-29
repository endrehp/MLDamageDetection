function COMAC = getCOMAC(U, V)

    % This function returns the COMAC vector for two sets of mode shapes U
    % and V
    
    M = length(U(:,1)); % Number of dofs
    N = length(U(1,:)); % Number of mode shapes
    
    COMAC = zeros(1,M);
    
    for i = 1:M
        
        a = 0; b1 = 0; b2 = 0;
        for j=1:N

            a = a + U(i,j)*V(i,j);
            b1 = b1 + U(i,j)*U(i,j); 
            b2 = b2 + V(i,j)*V(i,j);
        end
        
        COMAC(i) = a^2/(b1*b2);    
    end
    