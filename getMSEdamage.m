function beta = getMSEdamage(U, V, N)

    % gives the damage index of the N first mode shapes based on the modal
    % strain energy.
    % U - undamaged mode shapes
    % V - damaged mode shapes
    % N - number of mode shapes considered

    L = length(U(:,1));
    tfikd = zeros(1, L); % Total damaged flexural rigidity
    tfik = zeros(1, L); % Total undamaged flexural rigidity
    x = linspace(0, 1, L);

    for i=1:N

        % Second derivative
        ddu = getModalCurvature(U(:,i));
        ddv = getModalCurvature(V(:,i));

        % integrate over whole beam
        ui = trapz(x, ddu.^2);
        vi = trapz(x, ddv.^2);

        for k=1:L-1
            % integrate over subregion
            uik = trapz(x(k:k+1),ddu(k:k+1).^2);
            vik = trapz(x(k:k+1),ddv(k:k+1).^2);

            % compute flexural rigidty
            fikd = vik/vi;
            fik = uik/ui;

            tfikd(k) = tfikd(k) + fikd;
            tfik(k) = tfik(k) + fik;

        end


    end
    
    beta = tfikd./tfik;

end