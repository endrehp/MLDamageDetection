function ddu = getModalCurvature(u)

    % Computes the second derivative of a single mode shape u using a finite
    % difference scheme

    ddu = zeros(length(u), 1);
    a = 1;
    
    for i=1:length(u)
    
        if i==1
            % Forward difference for first element
            ddu(i) = 1/(2*a^2)*(u(i+2) - 2*u(i+1) + u(i));

        elseif i == length(u)
            % Backward difference for last element
            ddu(i) = 1/(2*a^2)*(u(i) - 2*u(i-1) + u(i-2));
           
        else
            % Central difference
            ddu(i) = 1/a^2*(u(i-1) - 2*u(i) + u(i+1));
            
        end

    end
    
    
end