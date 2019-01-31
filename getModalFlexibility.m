function G = getModalFlexibility(U, D, N)

    % This function computes the modal flexibility matrix G
    % The inputs are:
    % U - mode shape matrix
    % D - eigenvalue matrix
    % N - number of modes accounted for
    
    L = length(U(:,1));
    omegas = sqrt(diag(D));
    omegas = omegas(1:N);
    G = zeros(L);
    
    for i = 1:N
        G = G + 1/omegas(i)^2*U(:,i)*U(:,i)';
    end
    
end